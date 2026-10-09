import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/maintenance.dart'
    show Maintenance, UpdateMaintenanceRequest, maintenanceTypesValues;
import '../../viewmodels/maintenance_viewmodel.dart';
import '../common_view.dart';

/// Read/edit view for a single maintenance record.
///
/// MVVM note: the screen is a thin view. It owns *only* form-local state
/// (controllers, which field is being edited); every piece of record state and
/// every mutation goes through [MaintenanceViewModel], which in turn talks to
/// use cases. No repository or API type is touched here.
class MaintenanceDetailScreen extends StatefulWidget {
  const MaintenanceDetailScreen({
    required this.maintenanceId,
    required this.carId,
    super.key,
  });

  final String maintenanceId;
  final String carId;

  @override
  State<MaintenanceDetailScreen> createState() =>
      _MaintenanceDetailScreenState();
}

class _MaintenanceDetailScreenState extends State<MaintenanceDetailScreen> {
  Maintenance? _record;
  bool _isLoading = true;
  bool _isEditing = false;
  bool _loadFailed = false;

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _costController = TextEditingController();
  final _mileageController = TextEditingController();
  final _garageController = TextEditingController();
  final _categoryController = TextEditingController();
  final _notesController = TextEditingController();
  final _nextServiceController = TextEditingController();

  String _selectedType = 'maintenance';
  DateTime? _selectedDate;
  List<String> _selectedParts = [];

  static const _availableParts = <String>[
    'engine',
    'battery',
    'alternator',
    'radiator',
    'air-filter',
    'oil-filter',
    'belts',
    'transmission',
    'front-left-brake',
    'front-right-brake',
    'rear-left-brake',
    'rear-right-brake',
    'front-left-suspension',
    'front-right-suspension',
    'rear-left-suspension',
    'rear-right-suspension',
    'front-left-tire',
    'front-right-tire',
    'rear-left-tire',
    'rear-right-tire',
    'exhaust',
    'fuel-system',
    'cooling',
    'steering',
    'headlights',
    'tail-lights',
    'body-front',
    'body-rear',
    'interior',
    'electrical',
  ];

  @override
  void initState() {
    super.initState();
    // Scope the ViewModel to this car up-front: the save path relies on the
    // ViewModel knowing which car owns the record.
    context.read<MaintenanceViewModel>().bindCar(widget.carId);
    _loadRecord();
  }

  Future<void> _loadRecord() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _loadFailed = false;
      });
    }

    final result = await context.read<MaintenanceViewModel>().getMaintenance(
      widget.carId,
      widget.maintenanceId,
    );

    if (!mounted) return;

    setState(() {
      _isLoading = false;
      if (result.isSuccess) {
        _record = result.data;
        _populateForm();
      } else {
        // Previously the loader spun forever on a failed fetch.
        _loadFailed = true;
      }
    });
  }

  void _populateForm() {
    final r = _record;
    if (r == null) return;
    _titleController.text = r.title;
    _costController.text = r.cost.toString();
    _mileageController.text = r.mileage?.toString() ?? '';
    _garageController.text = r.garage ?? '';
    _categoryController.text = r.category ?? '';
    _notesController.text = r.notes ?? '';
    _nextServiceController.text = r.nextServiceMileage?.toString() ?? '';
    _selectedType = r.type;
    _selectedDate = r.date;
    _selectedParts = List<String>.from(r.parts);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _costController.dispose();
    _mileageController.dispose();
    _garageController.dispose();
    _categoryController.dispose();
    _notesController.dispose();
    _nextServiceController.dispose();
    super.dispose();
  }

  void _close() {
    if (_isEditing) {
      setState(() => _isEditing = false);
    } else {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: _close,
          tooltip: _isEditing ? t.common.cancel : t.common.back,
        ),
        title: Text(_isEditing ? t.common.edit : t.services.maintenanceRecords),
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit_rounded),
              tooltip: t.common.edit,
              onPressed: () => setState(() => _isEditing = true),
            ),
          const HGap(AppSpacing.xs),
        ],
      ),
      body: AnimatedSwitcher(
        duration: AppMotion.normal,
        switchInCurve: AppMotion.enter,
        child: _buildBody(t),
      ),
    );
  }

  Widget _buildBody(Translations t) {
    if (_isLoading) {
      return const Center(key: ValueKey('loading'), child: AppLoader(size: 32));
    }

    if (_loadFailed || _record == null) {
      return ErrorState(
        key: const ValueKey('error'),
        title: t.common.somethingWentWrong,
        message: t.common.couldNotLoadRecord,
        onRetry: _loadRecord,
      );
    }

    return _isEditing ? _buildEditForm(t) : _buildDetailView(t);
  }

  // ==========================================================================
  // DETAIL
  // ==========================================================================

  Widget _buildDetailView(Translations t) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final record = _record!;

    return ListView(
      key: const ValueKey('detail'),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.sm,
        AppSpacing.gutter,
        AppSpacing.huge,
      ),
      children: [
        EntranceFadeSlide(index: 0, child: _HeroHeader(record: record)),
        const VGap(AppSpacing.xxl),

        EntranceFadeSlide(
          index: 1,
          child: SectionHeader(title: t.common.summary),
        ),
        const VGap(AppSpacing.md),
        EntranceFadeSlide(
          index: 2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _SummaryCard(
                  icon: Icons.payments_rounded,
                  label: t.common.cost,
                  value: formatCurrency(record.cost),
                  color: scheme.primary,
                ),
              ),
              const HGap(AppSpacing.md),
              Expanded(
                child: _SummaryCard(
                  icon: Icons.speed_rounded,
                  label: t.common.mileage,
                  value: record.mileage != null
                      ? '${record.mileage} km'
                      : 'N/A',
                  color: scheme.secondary,
                ),
              ),
            ],
          ),
        ),
        const VGap(AppSpacing.xxl),

        if (record.parts.isNotEmpty) ...[
          EntranceFadeSlide(
            index: 3,
            child: SectionHeader(title: t.services.partsReplaced),
          ),
          const VGap(AppSpacing.md),
          EntranceFadeSlide(
            index: 4,
            child: AppCard(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final part in record.parts) _PartChip(part: part),
                ],
              ),
            ),
          ),
          const VGap(AppSpacing.xxl),
        ],

        if (record.category != null && record.category!.isNotEmpty) ...[
          EntranceFadeSlide(
            index: 5,
            child: SectionHeader(title: t.common.category),
          ),
          const VGap(AppSpacing.md),
          EntranceFadeSlide(
            index: 6,
            child: AppCard(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Icon(
                    Icons.category_rounded,
                    size: 20,
                    color: scheme.tertiary,
                  ),
                  const HGap(AppSpacing.sm),
                  Expanded(
                    child: Text(
                      record.category!,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: scheme.onSurface,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VGap(AppSpacing.xxl),
        ],

        if (record.notes != null && record.notes!.isNotEmpty) ...[
          EntranceFadeSlide(
            index: 7,
            child: SectionHeader(title: t.common.notes),
          ),
          const VGap(AppSpacing.md),
          EntranceFadeSlide(
            index: 8,
            child: AppCard(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Text(
                record.notes!,
                style: theme.textTheme.bodyMedium?.copyWith(height: 1.7),
              ),
            ),
          ),
          const VGap(AppSpacing.xxl),
        ],

        if (record.nextServiceMileage != null) ...[
          EntranceFadeSlide(
            index: 9,
            child: SectionHeader(title: t.services.schedule),
          ),
          const VGap(AppSpacing.md),
          EntranceFadeSlide(
            index: 10,
            child: AppCard(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: scheme.primary.withValues(alpha: 0.12),
                    ),
                    child: Icon(
                      Icons.event_repeat_rounded,
                      size: 20,
                      color: scheme.primary,
                    ),
                  ),
                  const HGap(AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.services.nextServiceDue,
                          style: theme.textTheme.labelSmall,
                        ),
                        const VGap(2),
                        Text(
                          '${record.nextServiceMileage} km',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  // ==========================================================================
  // EDIT
  // ==========================================================================

  Widget _buildEditForm(Translations t) {
    final vm = context.watch<MaintenanceViewModel>();

    return Form(
      key: _formKey,
      child: ListView(
        key: const ValueKey('edit'),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          AppSpacing.sm,
          AppSpacing.gutter,
          AppSpacing.huge,
        ),
        children: [
          EntranceFadeSlide(
            index: 0,
            child: _SelectField(
              label: t.services.maintenanceType,
              value: _selectedType,
              items: [
                for (final type in maintenanceTypesValues)
                  DropdownMenuItem(
                    value: type,
                    child: Text(getMaintenanceTypeLabel(type)),
                  ),
              ],
              onChanged: (v) =>
                  setState(() => _selectedType = v ?? _selectedType),
            ),
          ),
          const VGap(AppSpacing.lg),

          EntranceFadeSlide(
            index: 1,
            child: AppTextField(
              controller: _titleController,
              label: t.common.title,
              validator: (v) =>
                  Validators.required(v, fieldName: t.common.title),
            ),
          ),
          const VGap(AppSpacing.lg),

          EntranceFadeSlide(
            index: 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _costController,
                    label: t.common.cost,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (v) =>
                        Validators.positiveNumber(v, fieldName: t.common.cost),
                  ),
                ),
                const HGap(AppSpacing.md),
                Expanded(
                  child: AppTextField(
                    controller: _mileageController,
                    label: t.common.mileage,
                    keyboardType: TextInputType.number,
                    validator: Validators.mileage,
                  ),
                ),
              ],
            ),
          ),
          const VGap(AppSpacing.lg),

          EntranceFadeSlide(
            index: 3,
            child: AppTextField(
              controller: _garageController,
              label: t.garage.garage,
              prefixIcon: const Icon(Icons.store_rounded, size: 20),
            ),
          ),
          const VGap(AppSpacing.lg),

          EntranceFadeSlide(
            index: 4,
            child: AppTextField(
              controller: _categoryController,
              label: t.common.category,
              prefixIcon: const Icon(Icons.category_rounded, size: 20),
            ),
          ),
          const VGap(AppSpacing.lg),

          EntranceFadeSlide(
            index: 5,
            child: _DateField(
              label: t.common.date,
              value: _selectedDate,
              onChanged: (d) => setState(() => _selectedDate = d),
            ),
          ),
          const VGap(AppSpacing.lg),

          EntranceFadeSlide(
            index: 6,
            child: AppTextField(
              controller: _nextServiceController,
              label: t.services.nextServiceKm,
              keyboardType: TextInputType.number,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? null : Validators.mileage(v),
            ),
          ),
          const VGap(AppSpacing.xxl),

          EntranceFadeSlide(
            index: 7,
            child: _PartsSelector(
              selected: _selectedParts,
              onAdd: (id) => setState(() => _selectedParts.add(id)),
              onRemove: (id) => setState(() => _selectedParts.remove(id)),
            ),
          ),
          const VGap(AppSpacing.lg),

          EntranceFadeSlide(
            index: 8,
            child: AppTextField(
              controller: _notesController,
              label: t.common.notes,
              maxLines: 4,
            ),
          ),
          const VGap(AppSpacing.xl),

          ErrorFeedback(error: vm.error),

          AppButton(
            width: double.infinity,
            onPressed: vm.isLoading ? null : _save,
            isLoading: vm.isLoading,
            gradient: AppGradients.primary,
            child: Text(
              t.common.save,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          const VGap(AppSpacing.md),
          AppButton(
            onPressed: vm.isLoading
                ? null
                : () => setState(() => _isEditing = false),
            isOutlined: true,
            child: Text(t.common.cancel),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final t = context.t;
    final vm = context.read<MaintenanceViewModel>();
    if (vm.isLoading) return;

    final request = UpdateMaintenanceRequest(
      type: _selectedType,
      title: _titleController.text.trim(),
      cost: double.tryParse(_costController.text.trim()),
      // Safe parsing: `int.parse` threw on a non-numeric field even though the
      // text input is only a soft keyboard hint.
      mileage: int.tryParse(_mileageController.text.trim()),
      date: _selectedDate,
      garage: _emptyToNull(_garageController),
      category: _emptyToNull(_categoryController),
      notes: _emptyToNull(_notesController),
      parts: _selectedParts.isEmpty ? null : List<String>.from(_selectedParts),
      nextServiceMileage: int.tryParse(_nextServiceController.text.trim()),
    );

    final success = await vm.updateRecord(widget.maintenanceId, request);

    if (!mounted) return;

    if (success) {
      setState(() => _isEditing = false);
      _loadRecord();
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(vm.error?.message ?? t.common.error)),
        );
    }
  }

  static String? _emptyToNull(TextEditingController c) {
    final text = c.text.trim();
    return text.isEmpty ? null : text;
  }
}

// ============================================================================
// PRIVATE SUB-VIEWS
// ============================================================================

/// Gradient hero card at the top of the detail view.
class _HeroHeader extends StatelessWidget {
  const _HeroHeader({required this.record});

  final Maintenance record;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.circular(AppRadius.sheet),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.28),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'maintenance-status-${record.id}',
                child: Material(
                  color: Colors.transparent,
                  child: StatusBadge(status: record.type),
                ),
              ),
              Text(
                formatDate(record.date),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: Colors.white70,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const VGap(AppSpacing.lg),
          Text(
            record.title,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          if (record.garage != null && record.garage!.isNotEmpty) ...[
            const VGap(AppSpacing.xs),
            Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  size: 16,
                  color: Colors.white70,
                ),
                const HGap(AppSpacing.xs),
                Expanded(
                  child: Text(
                    record.garage!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// Compact stat tile used for cost / mileage.
class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: color.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          const VGap(AppSpacing.md),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          const VGap(2),
          Text(
            label,
            style: theme.textTheme.labelSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

/// Read-only pill for one replaced part.
class _PartChip extends StatelessWidget {
  const _PartChip({required this.part});

  final String part;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.badge),
        border: Border.all(color: scheme.primary.withValues(alpha: 0.18)),
      ),
      child: Text(
        getPartLabel(part),
        style: theme.textTheme.labelMedium?.copyWith(
          color: scheme.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

/// Labelled dropdown that matches the app's input styling.
class _SelectField extends StatelessWidget {
  const _SelectField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return _FieldShell(
      label: label,
      child: DropdownButtonFormField<String>(
        initialValue: items.any((i) => i.value == value) ? value : null,
        items: items,
        onChanged: onChanged,
        isExpanded: true,
        borderRadius: BorderRadius.circular(AppRadius.input),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        ),
      ),
    );
  }
}

/// Labelled tappable field showing the selected date.
class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final DateTime? value;
  final ValueChanged<DateTime?> onChanged;

  Future<void> _pick(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: value ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    );
    if (picked != null) onChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _FieldShell(
      label: label,
      child: Material(
        color: theme.inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(AppRadius.input),
        child: InkWell(
          onTap: () => _pick(context),
          borderRadius: BorderRadius.circular(AppRadius.input),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.input),
              border: Border.all(color: theme.colorScheme.outline),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 18,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const HGap(AppSpacing.sm),
                Expanded(
                  child: Text(
                    value != null
                        ? formatDate(value!)
                        : context.t.common.selectDate,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: value != null
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Icon(
                  Icons.expand_more_rounded,
                  size: 20,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Multi-select for the parts that were replaced.
class _PartsSelector extends StatelessWidget {
  const _PartsSelector({
    required this.selected,
    required this.onAdd,
    required this.onRemove,
  });

  final List<String> selected;
  final ValueChanged<String> onAdd;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final remaining = _MaintenanceDetailScreenState._availableParts
        .where((p) => !selected.contains(p))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label: t.services.partsReplaced),
        const VGap(AppSpacing.xs),
        DropdownButtonFormField<String>(
          initialValue: null,
          hint: Text(
            remaining.isEmpty
                ? t.services.allPartsAdded
                : t.services.addPartsReplaced,
            style: theme.textTheme.bodyMedium,
          ),
          isExpanded: true,
          borderRadius: BorderRadius.circular(AppRadius.input),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          ),
          items: [
            for (final part in remaining)
              DropdownMenuItem(
                value: part,
                child: Text(
                  getPartLabel(part),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
          onChanged: (id) {
            if (id != null) onAdd(id);
          },
        ),
        if (selected.isNotEmpty) ...[
          const VGap(AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final part in selected)
                InputChip(
                  label: Text(getPartLabel(part)),
                  onDeleted: () => onRemove(part),
                  deleteIcon: const Icon(Icons.close_rounded, size: 16),
                  side: BorderSide(
                    color: theme.colorScheme.primary.withValues(alpha: 0.25),
                  ),
                  backgroundColor: theme.colorScheme.primary.withValues(
                    alpha: 0.06,
                  ),
                  labelStyle: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

/// Shared floating-label wrapper so custom fields line up with [AppTextField].
class _FieldShell extends StatelessWidget {
  const _FieldShell({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FieldLabel(label: label),
        const VGap(AppSpacing.xs),
        child,
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label,
        style: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

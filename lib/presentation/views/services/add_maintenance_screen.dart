import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/maintenance.dart'
    show CreateMaintenanceRequest, maintenanceTypesValues;
import '../../viewmodels/maintenance_viewmodel.dart';
import '../common_view.dart';

class AddMaintenanceScreen extends StatefulWidget {
  final String carId;

  const AddMaintenanceScreen({required this.carId, super.key});

  @override
  State<AddMaintenanceScreen> createState() => _AddMaintenanceScreenState();
}

class _AddMaintenanceScreenState extends State<AddMaintenanceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _costController = TextEditingController();
  final _mileageController = TextEditingController();
  final _garageController = TextEditingController();
  final _categoryController = TextEditingController();
  final _notesController = TextEditingController();
  final _nextServiceController = TextEditingController();

  String _selectedType = 'maintenance';
  DateTime _selectedDate = DateTime.now();
  final List<String> _selectedParts = [];

  final List<String> _availableParts = const [
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final maintenanceVM = context.watch<MaintenanceViewModel>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(t.services.addMaintenance),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: EntranceFadeSlide(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildSectionHeader(theme, 'Service Details'),
                const Gap(16),
                _buildSelectField(
                  label: t.services.maintenanceType,
                  value: _selectedType,
                  items: maintenanceTypesValues
                      .map(
                        (t) => DropdownMenuItem(
                          value: t,
                          child: Text(getMaintenanceTypeLabel(t)),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _selectedType = v!),
                ),
                const Gap(20),
                AppTextField(
                  controller: _titleController,
                  label: t.common.title,
                  hint: 'e.g., Oil Change & Filter',
                  textInputAction: TextInputAction.next,
                  validator: (v) =>
                      Validators.required(v, fieldName: t.common.title),
                ),
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: _costController,
                        label: t.common.cost,
                        hint: '0.00',
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (v) => Validators.positiveNumber(
                          v,
                          fieldName: t.common.cost,
                        ),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: AppTextField(
                        controller: _mileageController,
                        label: t.common.mileage,
                        hint: 'Current km',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: Validators.mileage,
                      ),
                    ),
                  ],
                ),
                const Gap(32),
                _buildSectionHeader(theme, 'Provider & Schedule'),
                const Gap(16),
                AppTextField(
                  controller: _garageController,
                  label: t.garage.garage,
                  hint: 'Service Center Name',
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.store_rounded, size: 20),
                ),
                const Gap(20),
                Row(
                  children: [
                    Expanded(child: _buildDatePicker(context)),
                    const Gap(16),
                    Expanded(
                      child: AppTextField(
                        controller: _nextServiceController,
                        label: 'Next Service (km)',
                        hint: 'e.g., 10000',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        validator: (v) => Validators.positiveNumber(
                          v,
                          fieldName: t.services.nextServiceMileage,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(32),
                _buildSectionHeader(theme, 'Additional Info'),
                const Gap(16),
                _buildPartsSelector(context),
                const Gap(20),
                AppTextField(
                  controller: _notesController,
                  label: t.common.notes,
                  hint: 'Any specific findings or parts used...',
                  maxLines: 4,
                ),
                const Gap(40),
                SizedBox(
                  height: 58,
                  child: AppButton(
                    onPressed: maintenanceVM.isLoading ? null : _submit,
                    isLoading: maintenanceVM.isLoading,
                    child: Text(
                      t.common.save,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                ErrorFeedback(error: maintenanceVM.error),
                const Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w800,
        color: theme.colorScheme.primary,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSelectField({
    required String label,
    required String value,
    required List<DropdownMenuItem<String>> items,
    required ValueChanged<String?> onChanged,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          initialValue: value,
          items: items,
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            t.common.date,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(2000),
              lastDate: DateTime.now(),
            );
            if (date != null) setState(() => _selectedDate = date);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: theme.inputDecorationTheme.fillColor,
              border: Border.all(color: theme.colorScheme.outline),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  size: 18,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const Gap(12),
                Text(
                  formatDate(_selectedDate),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPartsSelector(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            t.services.partsReplaced,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          hint: const Text('Add parts replaced'),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
          items: _availableParts
              .where((partId) => !_selectedParts.contains(partId))
              .map(
                (partId) => DropdownMenuItem(
                  value: partId,
                  child: Text(getPartLabel(partId)),
                ),
              )
              .toList(),
          onChanged: (partId) {
            if (partId != null) {
              setState(() => _selectedParts.add(partId));
            }
          },
        ),
        if (_selectedParts.isNotEmpty) ...[
          const Gap(12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selectedParts.map((partId) {
              return Chip(
                label: Text(getPartLabel(partId)),
                onDeleted: () => setState(() => _selectedParts.remove(partId)),
                deleteIcon: const Icon(Icons.close_rounded, size: 16),
                side: BorderSide(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                ),
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.05,
                ),
                labelStyle: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w800,
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final vm = context.read<MaintenanceViewModel>();
    // Guards against a double-tap firing two POSTs.
    if (vm.isLoading) return;

    String? trimmed(TextEditingController c) {
      final text = c.text.trim();
      return text.isEmpty ? null : text;
    }

    final request = CreateMaintenanceRequest(
      type: _selectedType,
      title: _titleController.text.trim(),
      cost: double.tryParse(_costController.text.trim()) ?? 0,
      // `tryParse`: the numeric keyboard is only a hint, and a pasted
      // "12 000" would previously throw an uncaught FormatException.
      mileage: int.tryParse(_mileageController.text.trim()),
      date: _selectedDate,
      garage: trimmed(_garageController),
      category: trimmed(_categoryController),
      notes: trimmed(_notesController),
      parts: _selectedParts.isEmpty ? null : List<String>.from(_selectedParts),
      nextServiceMileage: int.tryParse(_nextServiceController.text.trim()),
    );

    final success = await vm.createRecord(request);

    if (!mounted) return;

    if (success) {
      context.pop();
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(vm.error?.message ?? context.t.common.error)),
        );
    }
  }
}

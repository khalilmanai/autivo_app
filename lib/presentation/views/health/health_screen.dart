import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/car_part.dart';
import '../../viewmodels/car_part_viewmodel.dart';
import '../common_view.dart';

class HealthScreen extends StatefulWidget {
  final String carId;

  const HealthScreen({required this.carId, super.key});

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<CarPartViewModel>().loadParts(widget.carId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final partVM = context.watch<CarPartViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(t.parts.parts),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            tooltip: t.parts.partStatusLegend,
            onPressed: _showLegend,
          ),
          const HGap(AppSpacing.xs),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => partVM.loadParts(widget.carId),
        child: partVM.isLoading && partVM.parts.isEmpty
            ? const _HealthSkeleton()
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.gutter,
                  AppSpacing.sm,
                  AppSpacing.gutter,
                  AppSpacing.huge,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EntranceFadeSlide(
                      child: AppCard(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.xl,
                          horizontal: AppSpacing.lg,
                        ),
                        child: Column(
                          children: [
                            Text(
                              t.parts.vehicleHealthMap,
                              style: theme.textTheme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                            const VGap(AppSpacing.xs),
                            Text(
                              t.parts.tapZonesHint,
                              style: theme.textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            const VGap(AppSpacing.xl),
                            // Bounded so the silhouette never forces the
                            // silhouette card wider than the viewport.
                            LayoutBuilder(
                              builder: (context, constraints) => Center(
                                child: CarSilhouette(
                                  parts: [
                                    for (final p in partVM.parts)
                                      {'partId': p.partId, 'status': p.status},
                                  ],
                                  onPartTap: _showPartEditor,
                                  size: constraints.maxWidth * 0.78,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const VGap(AppSpacing.xxl),

                    // Never render a bare heading over an empty list.
                    if (partVM.parts.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: AppSpacing.xxl),
                        child: EmptyState(
                          title: t.parts.noPartsTracked,
                          subtitle: t.parts.noPartsTrackedSubtitle,
                          icon: Icons.car_crash_outlined,
                        ),
                      )
                    else ...[
                      SectionHeader(title: t.parts.partCategories),
                      const VGap(AppSpacing.md),
                      _GroupedParts(
                        onPartTap: (part) => _openEditor(part.partId),
                      ),
                    ],
                  ],
                ),
              ),
      ),
    );
  }

  void _showPartEditor(String partId) => _openEditor(partId);

  void _openEditor(String partId) {
    AppBottomSheet.show(
      context: context,
      title: Text(getPartLabel(partId)),
      child: _PartEditorSheet(carId: widget.carId, partId: partId),
    );
  }

  void _showLegend() {
    AppBottomSheet.show(
      context: context,
      title: Text(context.t.parts.partStatusLegend),
      child: const Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          0,
          AppSpacing.gutter,
          AppSpacing.huge,
        ),
        child: PartStatusLegend(),
      ),
    );
  }
}

class _HealthSkeleton extends StatelessWidget {
  const _HealthSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.gutter),
      children: const [
        AppSkeleton(
          height: 320,
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.sheet)),
        ),
        VGap(AppSpacing.xxl),
        AppSkeleton(height: 18, width: 150),
        VGap(AppSpacing.md),
        AppSkeleton(height: 72),
        VGap(AppSpacing.sm),
        AppSkeleton(height: 72),
      ],
    );
  }
}

class _PartEditorSheet extends StatefulWidget {
  final String carId;
  final String partId;

  const _PartEditorSheet({required this.carId, required this.partId});

  @override
  State<_PartEditorSheet> createState() => _PartEditorSheetState();
}

class _PartEditorSheetState extends State<_PartEditorSheet> {
  String _selectedStatus = 'original';
  DateTime? _replacedAt;
  final _mileageController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final partVM = context.read<CarPartViewModel>();
    final matches = partVM.parts.where((p) => p.partId == widget.partId);
    if (matches.isNotEmpty) {
      final part = matches.first;
      _selectedStatus = part.status;
      _replacedAt = part.replacedAt;
      _mileageController.text = part.mileageAtReplacement?.toString() ?? '';
      _notesController.text = part.notes ?? '';
    }
  }

  @override
  void dispose() {
    _mileageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final partVM = context.watch<CarPartViewModel>();

    // Scrollable + shrink-wrapped: the sheet grows with the keyboard, and a
    // plain Column overflowed on short viewports.
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.xs,
        AppSpacing.gutter,
        0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(t.parts.partStatus, style: theme.textTheme.titleMedium),
          const VGap(AppSpacing.md),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final s in _partStatuses) ...[
                  ChoiceChip(
                    label: Text(getPartStatusLabel(s)),
                    selected: _selectedStatus == s,
                    showCheckmark: false,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedStatus = s);
                    },
                    selectedColor: theme.colorScheme.primary.withValues(
                      alpha: 0.12,
                    ),
                    labelStyle: theme.textTheme.labelMedium?.copyWith(
                      color: _selectedStatus == s
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurfaceVariant,
                      fontWeight: _selectedStatus == s
                          ? FontWeight.w800
                          : FontWeight.w500,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.badge),
                    ),
                  ),
                  const HGap(AppSpacing.xs),
                ],
              ],
            ),
          ),
          const VGap(AppSpacing.lg),
          AppTextField(
            controller: _mileageController,
            label: t.parts.mileageAtMaintenance,
            keyboardType: TextInputType.number,
            hint: '0 km',
            prefixIcon: const Icon(Icons.speed_rounded, size: 20),
          ),
          const VGap(AppSpacing.md),
          AppTextField(
            controller: _notesController,
            label: t.common.notes,
            hint: t.parts.conditionDetailsHint,
            maxLines: 3,
            minLines: 2,
          ),
          const VGap(AppSpacing.lg),
          AppButton(
            width: double.infinity,
            onPressed: partVM.isLoading ? null : _save,
            isLoading: partVM.isLoading,
            gradient: AppGradients.primary,
            child: Text(
              t.common.save,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const VGap(AppSpacing.md),
        ],
      ),
    );
  }

  static const _partStatuses = <String>[
    'original',
    'replaced',
    'serviced',
    'worn',
    'damaged',
  ];

  Future<void> _save() async {
    final vm = context.read<CarPartViewModel>();
    if (vm.isLoading) return;

    final notes = _notesController.text.trim();

    final request = UpsertCarPartRequest(
      status: _selectedStatus,
      replacedAt: _replacedAt ?? DateTime.now(),
      mileageAtReplacement: int.tryParse(_mileageController.text.trim()),
      notes: notes.isEmpty ? null : notes,
    );

    final success = await vm.upsertPart(widget.partId, request);

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(vm.error?.message ?? context.t.common.error)),
        );
    }
  }
}

/// Parts grouped by their system (engine, brakes, tires, ...).
class _GroupedParts extends StatelessWidget {
  const _GroupedParts({required this.onPartTap});

  final ValueChanged<CarPart> onPartTap;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CarPartViewModel>();
    final t = context.t;

    final groups = <(String, String)>[
      ('engineParts', t.parts.engineParts),
      ('brakeParts', t.parts.brakeParts),
      ('suspensionParts', t.parts.suspensionParts),
      ('tireParts', t.parts.tireParts),
      ('bodyParts', t.parts.bodyParts),
      ('electricalParts', t.parts.electricalParts),
    ];

    // Flattened so each group gets its own index base for the cascade.
    final rows = <Widget>[];
    for (final (key, label) in groups) {
      final parts = vm.getPartsByGroup(key);
      if (parts.isEmpty) continue;

      rows
        ..add(SectionHeader(title: label))
        ..add(const VGap(AppSpacing.sm));
      for (final part in parts) {
        rows.add(
          EntranceFadeSlide(
            index: rows.length,
            child: _PartListItem(part: part, onTap: () => onPartTap(part)),
          ),
        );
      }
      rows.add(const VGap(AppSpacing.md));
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows);
  }
}

class _PartListItem extends StatelessWidget {
  const _PartListItem({required this.part, required this.onTap});

  final CarPart part;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;

    return AppCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: EdgeInsets.zero,
      onTap: onTap,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        leading: StatusBadge(status: part.status),
        title: Text(
          getPartLabel(
            part.partId,
            locale: Localizations.localeOf(context).languageCode,
          ),
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: part.replacedAt != null
            ? Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '${t.common.updated}: ${formatDate(part.replacedAt!, locale: Localizations.localeOf(context).toString())}',
                  style: theme.textTheme.bodySmall,
                ),
              )
            : null,
        trailing: Icon(
          Icons.chevron_right_rounded,
          size: 20,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

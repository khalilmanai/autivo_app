import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/maintenance.dart';
import '../../viewmodels/garage_viewmodel.dart';

import '../../viewmodels/maintenance_viewmodel.dart';
import '../common_view.dart';

class MaintenanceScreen extends StatefulWidget {
  final String? carId;

  const MaintenanceScreen({super.key, this.carId});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedCarId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _selectedCarId = widget.carId;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_selectedCarId != null) {
        context.read<MaintenanceViewModel>().loadRecords(_selectedCarId!);
      } else {
        context.read<GarageViewModel>().loadCars();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final garageVM = context.watch<GarageViewModel>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(t.services.services),
        actions: [
          if (_selectedCarId == null)
            PopupMenuButton<String>(
              icon: const Icon(Icons.filter_list_rounded),
              tooltip: 'Select Vehicle',
              onSelected: (value) {
                setState(() => _selectedCarId = value);
                context.read<MaintenanceViewModel>().loadRecords(value);
              },
              itemBuilder: (context) => garageVM.cars
                  .map(
                    (car) => PopupMenuItem(
                      value: car.id,
                      child: Text('${car.make} ${car.model}'),
                    ),
                  )
                  .toList(),
            )
          else
            IconButton(
              icon: const Icon(Icons.add_rounded),
              onPressed: () =>
                  context.push('/services/add?carId=$_selectedCarId'),
            ),
        ],
        bottom: _selectedCarId != null
            ? TabBar(
                controller: _tabController,
                indicatorWeight: 3,
                tabs: [
                  Tab(text: t.services.maintenanceRecords),
                  Tab(text: t.garage.upcomingMaintenance),
                ],
              )
            : null,
      ),
      body: _selectedCarId == null
          ? _buildCarSelector(context, garageVM)
          : TabBarView(
              controller: _tabController,
              children: [
                _RecordsTab(carId: _selectedCarId!),
                _UpcomingTab(carId: _selectedCarId!),
              ],
            ),
    );
  }

  Widget _buildCarSelector(BuildContext context, GarageViewModel garageVM) {
    final theme = Theme.of(context);
    final t = context.t;

    return garageVM.isLoading
        ? const Center(child: AppLoader())
        : garageVM.cars.isEmpty
        ? garageVM.error != null
              ? ErrorState(
                  title: t.common.error,
                  message: localizeApiError(
                    garageVM.error!.code,
                    t,
                    fallback: garageVM.error!.message,
                  ),
                  onRetry: () => garageVM.loadCars(),
                )
              : EmptyState(
                  title: t.garage.noVehicles,
                  subtitle: t.garage.noVehiclesSubtitle,
                  icon: Icons.directions_car_filled_rounded,
                )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            itemCount: garageVM.cars.length,
            itemBuilder: (context, index) {
              final car = garageVM.cars[index];
              return EntranceFadeSlide(
                index: index,
                child: AppCard(
                  margin: const EdgeInsets.only(bottom: 16),
                  onTap: () {
                    setState(() => _selectedCarId = car.id);
                    context.read<MaintenanceViewModel>().loadRecords(car.id);
                  },
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        Icons.directions_car_filled_rounded,
                        color: theme.colorScheme.primary,
                        size: 28,
                      ),
                    ),
                    title: Text(
                      '${car.make} ${car.model}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        '${car.year} \u2022 ${formatMileage(car.mileage)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class _RecordsTab extends StatelessWidget {
  final String carId;

  const _RecordsTab({required this.carId});

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final maintenanceVM = context.watch<MaintenanceViewModel>();

    return maintenanceVM.isLoading
        ? const Center(child: AppLoader())
        : maintenanceVM.records.isEmpty
        ? maintenanceVM.error != null
              ? ErrorState(
                  title: t.common.error,
                  message: localizeApiError(
                    maintenanceVM.error!.code,
                    t,
                    fallback: maintenanceVM.error!.message,
                  ),
                  onRetry: () => maintenanceVM.loadRecords(carId),
                )
              : EmptyState(
                  title: 'No maintenance records',
                  subtitle: 'Add your first service record to start tracking',
                  icon: Icons.build_circle_rounded,
                  action: AppButton(
                    onPressed: () => context.push('/services/add?carId=$carId'),
                    child: Text(t.services.addMaintenance),
                  ),
                )
        : RefreshIndicator(
            onRefresh: () => maintenanceVM.loadRecords(carId),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              itemCount: maintenanceVM.records.length,
              itemBuilder: (context, index) {
                final record = maintenanceVM.records[index];
                return EntranceFadeSlide(
                  index: index,
                  child: _MaintenanceCard(record: record, carId: carId),
                );
              },
            ),
          );
  }
}

class _MaintenanceCard extends StatelessWidget {
  final Maintenance record;
  final String carId;

  const _MaintenanceCard({required this.record, required this.carId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      onTap: () => context.push('/services/${record.id}?carId=$carId'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  _getTypeIcon(record.type),
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      '${formatDate(record.date)} \u2022 ${formatCurrency(record.cost)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              StatusBadge(status: record.type),
            ],
          ),
          if (record.garage != null || record.category != null) ...[
            const Gap(16),
            Row(
              children: [
                if (record.garage != null) ...[
                  Icon(
                    Icons.location_on_rounded,
                    size: 14,
                    color: theme.colorScheme.primary,
                  ),
                  const Gap(6),
                  Text(
                    record.garage!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(16),
                ],
                if (record.category != null) ...[
                  Icon(
                    Icons.category_rounded,
                    size: 14,
                    color: theme.colorScheme.primary,
                  ),
                  const Gap(6),
                  Text(
                    record.category!,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ],
          if (record.nextServiceMileage != null) ...[
            const Gap(20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Service Progress',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Next: ${record.nextServiceMileage} km',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      // An overdue service (> 1.0) or a zero interval used to
                      // trip the `value` 0..1 assertion in `LinearProgressIndicator`.
                      value: _serviceProgress(record),
                      minHeight: 6,
                      backgroundColor: theme.colorScheme.outlineVariant,
                      valueColor: AlwaysStoppedAnimation(
                        theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'repair':
        return Icons.build_rounded;
      case 'maintenance':
        return Icons.auto_fix_high_rounded;
      case 'oil_change':
        return Icons.oil_barrel_rounded;
      case 'tire_service':
        return Icons.tire_repair_rounded;
      default:
        return Icons.miscellaneous_services_rounded;
    }
  }
}

class _UpcomingTab extends StatelessWidget {
  final String carId;

  const _UpcomingTab({required this.carId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maintenanceVM = context.watch<MaintenanceViewModel>();
    final garageVM = context.watch<GarageViewModel>();

    final t = context.t;

    // Find current car to get its mileage
    final car = garageVM.cars.where((c) => c.id == carId).firstOrNull;
    final currentMileage = car?.mileage ?? 0;

    // Overdue services are deliberately included. The old filter
    // (`currentMileage < nextServiceMileage`) dropped exactly the records the
    // user most needs, so an overdue vehicle reported "All caught up!".
    // Overdue entries sort first.
    final upcoming =
        maintenanceVM.records
            .where((r) => r.nextServiceMileage != null)
            .toList()
          ..sort((a, b) {
            final aDue = a.nextServiceMileage ?? 0;
            final bDue = b.nextServiceMileage ?? 0;
            final aOverdue = aDue - currentMileage;
            final bOverdue = bDue - currentMileage;
            final aLate = aOverdue < 0;
            final bLate = bOverdue < 0;
            if (aLate != bLate) return aLate ? -1 : 1;
            return aDue.compareTo(bDue);
          });

    if (upcoming.isEmpty) {
      return EmptyState(
        title: t.services.allCaughtUp,
        subtitle: t.services.noUpcomingMaintenance,
        icon: Icons.check_circle_rounded,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      itemCount: upcoming.length,
      itemBuilder: (context, index) {
        final record = upcoming[index];
        final target = record.nextServiceMileage ?? 0;
        final remaining = target - currentMileage;
        final isOverdue = remaining < 0;
        final isUrgent = isOverdue || remaining < 1000;
        final t = context.t;

        return EntranceFadeSlide(
          index: index,
          child: AppCard(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isUrgent
                        ? theme.colorScheme.error.withValues(alpha: 0.1)
                        : theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    isUrgent
                        ? Icons.warning_amber_rounded
                        : Icons.event_repeat_rounded,
                    color: isUrgent
                        ? theme.colorScheme.error
                        : theme.colorScheme.primary,
                    size: 24,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        '${t.services.nextServiceDue}: $target km',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (isOverdue) ...[
                        const Gap(4),
                        Text(
                          t.services.overdue,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.error,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      // Absolute value: a negative number next to "km left"
                      // read as "-1,200 km left".
                      '${remaining.abs()}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: isUrgent
                            ? theme.colorScheme.error
                            : theme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      t.services.kmLeft,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Service interval progress clamped to the `0.0..1.0` range that
/// `LinearProgressIndicator` asserts on. An overdue service (> 1.0) or a
/// zero/negative interval would otherwise trip that assertion; a `null`
/// return would render an endless indeterminate animation, so a missing
/// interval resolves to an empty bar instead.
double _serviceProgress(Maintenance record) {
  final target = record.nextServiceMileage;
  if (target == null || target <= 0) return 0;

  final current = record.mileage ?? 0;
  return (current / target).clamp(0.0, 1.0);
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/car.dart';
import '../../viewmodels/car_part_viewmodel.dart';
import '../../viewmodels/garage_viewmodel.dart';
import '../../viewmodels/maintenance_viewmodel.dart';
import '../common_view.dart';
import '../services/maintenance_screen.dart' show MaintenanceScreen;

class CarDetailScreen extends StatefulWidget {
  final String carId;

  const CarDetailScreen({required this.carId, super.key});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<GarageViewModel>().getCar(widget.carId);
      context.read<CarPartViewModel>().loadParts(widget.carId);
      context.read<MaintenanceViewModel>().loadRecords(widget.carId);
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
    // `watch`, not `read`: the health score was computed from a one-shot read,
    // so editing a part never updated it.
    final partVM = context.watch<CarPartViewModel>();

    // Resolve by `widget.carId` rather than trusting `_selectedCar`, which is
    // only whatever car was last tapped - stale after a refresh or a deep link.
    // Uses `indexWhere` instead of `collection.firstWhereOrNull` to avoid
    // depending on a package that is not a direct dependency.
    final cars = garageVM.cars;
    final match = cars.indexWhere((c) => c.id == widget.carId);
    final selected = garageVM.selectedCar;
    final car = match >= 0
        ? cars[match]
        : (selected?.id == widget.carId ? selected : null);

    if (car == null) {
      return Scaffold(
        appBar: AppBar(title: Text(t.garage.garage)),
        body: garageVM.error != null
            ? ErrorState(
                title: t.common.error,
                message: localizeApiError(
                  garageVM.error!.code,
                  t,
                  fallback: garageVM.error!.message,
                ),
                onRetry: () =>
                    context.read<GarageViewModel>().getCar(widget.carId),
              )
            : const Center(child: AppLoader()),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                '${car.make} ${car.model}',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    const Shadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  if (car.image != null && car.image!.isNotEmpty)
                    Hero(
                      tag: 'car_img_${car.id}',
                      child: Image.network(
                        car.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            _DefaultCarHeader(theme: theme),
                      ),
                    )
                  else
                    _DefaultCarHeader(theme: theme),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black45,
                          Colors.transparent,
                          Colors.black87,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.health_and_safety_rounded,
                  color: Colors.white,
                ),
                onPressed: () => context.push('/health?carId=${car.id}'),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        const Icon(Icons.edit_rounded, size: 20),
                        const Gap(12),
                        Text(t.common.edit),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline_rounded,
                          size: 20,
                          color: theme.colorScheme.error,
                        ),
                        const Gap(12),
                        Text(
                          t.common.delete,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'edit') {
                    // Navigate to edit screen
                  } else if (value == 'delete') {
                    _confirmDelete(car);
                  }
                },
              ),
            ],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                indicatorWeight: 3,
                tabs: [
                  Tab(text: t.common.overview),
                  Tab(text: t.services.services),
                  Tab(text: t.common.details),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _OverviewTab(
              car: car,
              healthScore: calculateHealthScore(
                partVM.parts.map((p) => {'status': p.status}).toList(),
              ),
            ),
            _MaintenanceTab(carId: car.id),
            _DetailsTab(car: car),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(Car car) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.common.delete),
        content: Text(
          'Are you sure you want to delete ${car.make} ${car.model}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.common.cancel),
          ),
          TextButton(
            onPressed: () async {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);
              final garageVM = context.read<GarageViewModel>();
              navigator.pop();
              final success = await garageVM.deleteCar(car.id);
              if (mounted) {
                if (success) {
                  navigator.pop();
                } else {
                  messenger.showSnackBar(
                    SnackBar(content: Text(t.common.error)),
                  );
                }
              }
            },
            child: Text(
              t.common.delete,
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultCarHeader extends StatelessWidget {
  final ThemeData theme;
  const _DefaultCarHeader({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
        ),
      ),
      child: Icon(
        Icons.directions_car_filled_rounded,
        size: 100,
        color: Colors.white.withValues(alpha: 0.2),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _OverviewTab extends StatelessWidget {
  final Car car;
  final int healthScore;

  const _OverviewTab({required this.car, required this.healthScore});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _QuickStatCard(
                  title: t.common.mileage,
                  value: formatMileage(car.mileage),
                  icon: Icons.speed_rounded,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary.withValues(alpha: 0.15),
                      theme.colorScheme.secondary.withValues(alpha: 0.05),
                    ],
                  ),
                ),
              ),
              const Gap(16),
              Expanded(
                child: _QuickStatCard(
                  title: 'Health',
                  value: '$healthScore%',
                  icon: Icons.favorite_rounded,
                  color: getHealthColor(healthScore),
                ),
              ),
            ],
          ),
          const Gap(32),
          Text(
            'Vehicle Specs',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(16),
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _SpecRow(label: 'Engine', value: car.engine),
                const Divider(height: 32),
                _SpecRow(label: 'Transmission', value: car.transmission),
                const Divider(height: 32),
                _SpecRow(label: 'Fuel Type', value: car.fuelLabel),
                const Divider(height: 32),
                _SpecRow(label: 'Color', value: car.colorName),
                const Divider(height: 32),
                _SpecRow(label: 'Year', value: car.year.toString()),
              ],
            ),
          ),
          const Gap(32),
          Text(
            'VIN & Registration',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(16),
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _SpecRow(
                  label: 'VIN',
                  value: car.vin.isNotEmpty ? car.vin : 'N/A',
                  isCopyable: true,
                ),
                const Divider(height: 32),
                _SpecRow(
                  label: 'License Plate',
                  value: car.licensePlate,
                  isCopyable: true,
                ),
              ],
            ),
          ),
          const Gap(40),
        ],
      ),
    );
  }
}

class _QuickStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Gradient? gradient;
  final Color? color;

  const _QuickStatCard({
    required this.title,
    required this.value,
    required this.icon,
    this.gradient,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null
            ? (color ?? theme.colorScheme.primary).withValues(alpha: 0.1)
            : null,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: gradient != null
                ? Colors.white
                : (color ?? theme.colorScheme.primary),
            size: 24,
          ),
          const Gap(16),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              color: gradient != null
                  ? Colors.white
                  : theme.colorScheme.onSurface,
            ),
          ),
          Text(
            title,
            style: theme.textTheme.labelMedium?.copyWith(
              color: gradient != null
                  ? Colors.white70
                  : theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isCopyable;

  const _SpecRow({
    required this.label,
    required this.value,
    this.isCopyable = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(4),
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        if (isCopyable)
          IconButton(
            icon: Icon(
              Icons.copy_rounded,
              size: 18,
              color: theme.colorScheme.primary,
            ),
            onPressed: () {
              // Copy to clipboard
            },
          ),
      ],
    );
  }
}

class _MaintenanceTab extends StatelessWidget {
  final String carId;

  const _MaintenanceTab({required this.carId});

  @override
  Widget build(BuildContext context) {
    return MaintenanceScreen(carId: carId);
  }
}

class _DetailsTab extends StatelessWidget {
  final Car car;

  const _DetailsTab({required this.car});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'System Metadata',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const Gap(16),
          AppCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _DetailRow('Method', car.identification.method),
                const Divider(height: 32),
                // `confidence` is a `String` (0-100 or 0-1 from the API), so it
                // must be parsed - multiplying the raw string threw at runtime.
                _DetailRow(
                  'Confidence',
                  _formatConfidence(car.identification.confidence),
                ),
                const Divider(height: 32),
                _DetailRow('Created', formatDateTime(car.createdAt)),
                const Divider(height: 32),
                _DetailRow('Last Updated', formatDateTime(car.updatedAt)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const HGap(AppSpacing.sm),
        // Flexible + right-aligned: a long translated value (or a large text
        // scale) previously overflowed the Row.
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

/// Renders a confidence value that may arrive as `0.87`, `"87"` or `"87%"`.
String _formatConfidence(String raw) {
  final cleaned = raw.replaceAll('%', '').trim();
  final parsed = double.tryParse(cleaned);
  if (parsed == null) return raw;

  final percent = parsed > 0 && parsed <= 1 ? parsed * 100 : parsed;
  return '${percent.toStringAsFixed(0)}%';
}

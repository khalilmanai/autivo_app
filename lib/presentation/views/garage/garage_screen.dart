import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/models/car.dart';
import '../../viewmodels/garage_viewmodel.dart';
import '../common_view.dart';

/// Tab 1: the user's vehicle list plus a summary hero.
class GarageScreen extends StatefulWidget {
  const GarageScreen({super.key});

  @override
  State<GarageScreen> createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  @override
  void initState() {
    super.initState();
    // Deferred so `context.read` never runs before the element is mounted.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<GarageViewModel>().loadCars();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final vm = context.watch<GarageViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(t.garage.garage),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: t.garage.addVehicle,
            onPressed: () => context.push('/garage/add'),
          ),
          const HGap(AppSpacing.xs),
        ],
      ),

      // Every branch must be scrollable, otherwise pull-to-refresh silently
      // does nothing (and Flutter logs a layout warning) exactly when the user
      // most wants to retry.
      body: RefreshIndicator(
        onRefresh: vm.loadCars,
        child: switch (vm) {
          _ when vm.isLoading && !vm.hasCars => const _GarageSkeleton(),
          _ when vm.error != null && !vm.hasCars => _MessageScrollView(
            child: ErrorState(
              title: t.common.error,
              message: localizeApiError(
                vm.error!.code,
                t,
                fallback: vm.error!.message,
              ),
              retryLabel: t.common.retry,
              onRetry: vm.loadCars,
            ),
          ),
          _ when !vm.hasCars => _MessageScrollView(
            child: EmptyState(
              title: t.garage.noVehicles,
              subtitle: t.garage.noVehiclesSubtitle,
              icon: Icons.directions_car_filled_rounded,
              action: AppButton(
                onPressed: () => context.push('/garage/add'),
                child: Text(t.garage.addVehicle),
              ),
            ),
          ),
          _ => _CarList(cars: vm.cars),
        },
      ),
    );
  }
}

/// Wraps a non-scrollable message widget so it still satisfies
/// [RefreshIndicator]'s "must contain a scrollable" requirement.
class _MessageScrollView extends StatelessWidget {
  const _MessageScrollView({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: child,
        ),
      ),
    );
  }
}

class _GarageSkeleton extends StatelessWidget {
  const _GarageSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.gutter),
      children: [
        const AppSkeleton(
          height: 190,
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.sheet)),
        ),
        const VGap(AppSpacing.xxl),
        const AppSkeleton(height: 20, width: 140),
        const VGap(AppSpacing.md),
        for (var i = 0; i < 3; i++) ...[
          const AppSkeleton(height: 130),
          const VGap(AppSpacing.md),
        ],
      ],
    );
  }
}

class _CarList extends StatelessWidget {
  const _CarList({required this.cars});

  final List<Car> cars;

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.sm,
        AppSpacing.gutter,
        AppSpacing.xxl,
      ),
      itemCount: cars.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return EntranceFadeSlide(child: _HeroCard(cars: cars));
        }
        if (index == 1) {
          return Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xxl, bottom: 12),
            child: SectionHeader(
              title: t.garage.sectionVehicles,
              trailing: TextButton.icon(
                onPressed: () => context.push('/garage/add'),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: Text(t.common.add),
              ),
            ),
          );
        }
        final car = cars[index - 2];
        return EntranceFadeSlide(
          index: index,
          child: _CarCard(car: car),
        );
      },
    );
  }
}

/// Gradient summary header.
class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.cars});

  final List<Car> cars;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;

    // NOTE: the previous version used a 15%-alpha gradient with hard-coded
    // white text. On the light theme that renders white-on-cream and the whole
    // header is unreadable. It now uses the solid brand gradient and a
    // foreground colour derived from the scheme.
    final fg = theme.colorScheme.onPrimary;
    final fgMuted = fg.withValues(alpha: 0.82);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: BorderRadius.circular(AppRadius.sheet),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.garage.garage,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: fg,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const VGap(AppSpacing.xxs),
                    Text(
                      t.garage.dashboardSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: fgMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: fg.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.analytics_rounded, color: fg, size: 24),
              ),
            ],
          ),
          const VGap(AppSpacing.xl),
          Row(
            children: [
              Expanded(
                child: _HeroPill(
                  icon: Icons.directions_car_filled_rounded,
                  label: t.garage.vehicles,
                  value: '${cars.length}',
                ),
              ),
              const HGap(AppSpacing.sm),
              Expanded(
                child: _HeroPill(
                  icon: Icons.check_circle_rounded,
                  label: t.garage.active,
                  value: '${cars.where((c) => c.status == 'active').length}',
                ),
              ),
              const HGap(AppSpacing.sm),
              Expanded(
                child: _HeroPill(
                  icon: Icons.build_rounded,
                  label: t.common.maintenance,
                  value:
                      '${cars.where((c) => c.status == 'maintenance').length}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fg = theme.colorScheme.onPrimary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: fg.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: fg.withValues(alpha: 0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: fg),
          const VGap(AppSpacing.xs),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              color: fg,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: fg.withValues(alpha: 0.78),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _CarCard extends StatelessWidget {
  const _CarCard({required this.car});

  final Car car;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = context.t;
    final hasImage = car.image != null && car.image!.isNotEmpty;

    return AppCard(
      onTap: () => context.push('/garage/car/${car.id}'),
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Hero(
                tag: 'car_img_${car.id}',
                child: hasImage
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.badge),
                        child: Image.network(
                          car.image!,
                          width: 90,
                          height: 60,
                          fit: BoxFit.cover,
                          // Decoding at display size avoids holding a full-res
                          // bitmap per card on low-end devices.
                          cacheWidth: 180,
                          errorBuilder: (_, _, _) => const _CarPlaceholder(),
                          loadingBuilder: (context, child, progress) =>
                              progress == null
                              ? child
                              : const _CarPlaceholder(),
                        ),
                      )
                    : const _CarPlaceholder(),
              ),
              const HGap(AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${car.make} ${car.model}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const VGap(2),
                    Text(
                      '${car.year} • ${car.fuelLabel}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const HGap(AppSpacing.xs),
              StatusBadge(status: car.status),
            ],
          ),
          const VGap(AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.45,
              ),
              borderRadius: BorderRadius.circular(AppRadius.badge),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _InfoItem(
                    icon: Icons.speed_rounded,
                    label: t.common.mileage,
                    value: formatMileage(car.mileage, distanceUnit: 'km'),
                  ),
                ),
                _Divider(color: theme.colorScheme.outlineVariant),
                Expanded(
                  child: _InfoItem(
                    icon: Icons.event_repeat_rounded,
                    label: t.services.schedule,
                    value: '${car.serviceInterval} km',
                  ),
                ),
                _Divider(color: theme.colorScheme.outlineVariant),
                Expanded(
                  child: _InfoItem(
                    icon: Icons.local_gas_station_rounded,
                    label: t.catalog.fuel,
                    value: car.fuelLabel,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) =>
      Container(width: 1, height: 24, color: color);
}

class _CarPlaceholder extends StatelessWidget {
  const _CarPlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 90,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.16),
            theme.colorScheme.secondary.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.badge),
      ),
      child: Icon(
        Icons.directions_car_filled_rounded,
        color: theme.colorScheme.primary,
        size: 28,
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 14, color: theme.colorScheme.primary),
            const HGap(AppSpacing.xxs),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const VGap(AppSpacing.xxs),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common_view.dart';

/// The four top-level destinations, in nav-bar order.
enum ShellTab {
  garage('/garage'),
  services('/services'),
  catalog('/catalog'),
  profile('/profile');

  const ShellTab(this.location);

  final String location;
}

/// Hosts the persistent bottom navigation bar around the active tab's content.
class MainShell extends StatelessWidget {
  const MainShell({required this.child, required this.location, super.key});

  final Widget child;

  /// The active route location, passed in by the `ShellRoute` builder so the
  /// selected tab is derived from routing state rather than from a duplicated
  /// local field that can drift out of sync.
  final String location;

  static ShellTab _tabFor(String location) {
    if (location.startsWith('/services') || location.startsWith('/health')) {
      return ShellTab.services;
    }
    if (location.startsWith('/catalog')) return ShellTab.catalog;
    if (location.startsWith('/profile')) return ShellTab.profile;
    return ShellTab.garage;
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;
    final active = _tabFor(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: CurvedNavigationBar(
        currentIndex: active.index,
        onTap: (index) {
          final target = ShellTab.values[index];
          // Re-tapping the active tab is a no-op instead of rebuilding it.
          if (target != active) context.go(target.location);
        },
        destinations: [
          CurvedNavigationDestination(
            icon: Icons.directions_car_outlined,
            selectedIcon: Icons.directions_car_filled_rounded,
            label: t.garage.garage,
          ),
          CurvedNavigationDestination(
            icon: Icons.build_circle_outlined,
            selectedIcon: Icons.build_circle_rounded,
            label: t.services.services,
          ),
          CurvedNavigationDestination(
            icon: Icons.explore_outlined,
            selectedIcon: Icons.explore_rounded,
            label: t.catalog.catalog,
          ),
          CurvedNavigationDestination(
            icon: Icons.person_outline_rounded,
            selectedIcon: Icons.person_rounded,
            label: t.profile.profile,
          ),
        ],
      ),
    );
  }
}

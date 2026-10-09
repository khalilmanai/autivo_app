import 'package:flutter/material.dart';

/// Pure bottom navigation bar — no Scaffold, no PageView, no FAB.
class CurvedNavigationBar extends StatelessWidget {
  final List<CurvedNavigationDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool showShadow;

  const CurvedNavigationBar({
    required this.destinations,
    required this.currentIndex,
    required this.onTap,
    this.showShadow = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;

    return Container(
      height: kBottomNavigationBarHeight + 20,
      decoration: BoxDecoration(
        color: scheme.surface,
        boxShadow: showShadow && !isDark
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ]
            : null,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          destinations.length,
          (index) => _NavBarItem(
            label: destinations[index].label,
            icon: destinations[index].icon,
            selectedIcon: destinations[index].selectedIcon,
            isActive: index == currentIndex,
            onTap: onTap,
            index: index,
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.isActive,
    required this.onTap,
    required this.index,
  });

  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final bool isActive;
  final ValueChanged<int> onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final activeColor = scheme.primary;
    final inactiveColor = scheme.onSurfaceVariant;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? activeColor.withValues(alpha: 0.14)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: AnimatedScale(
                  scale: isActive ? 1.08 : 1.0,
                  duration: const Duration(milliseconds: 280),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    isActive ? selectedIcon ?? icon : icon,
                    size: 22,
                    color: isActive ? activeColor : inactiveColor,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 280),
                style: theme.textTheme.labelSmall!.copyWith(
                  fontSize: 11,
                  fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                  color: isActive ? activeColor : inactiveColor,
                ),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvedNavigationDestination {
  final String label;
  final IconData icon;
  final IconData? selectedIcon;

  const CurvedNavigationDestination({
    required this.label,
    required this.icon,
    this.selectedIcon,
  });
}

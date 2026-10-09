import 'package:flutter/material.dart';

/// Premium card with optional gradient, shadow, and hover effects
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? color;
  final Gradient? gradient;
  final BorderSide? border;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final bool showShadow;
  final double? width;

  const AppCard({
    required this.child,
    super.key,
    this.padding,
    this.onTap,
    this.color,
    this.gradient,
    this.border,
    this.margin,
    this.radius = 20,
    this.showShadow = true,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = color ?? theme.cardColor;
    final cardBorder = border ?? BorderSide(color: theme.dividerColor);
    final shadowColor = showShadow
        ? theme.colorScheme.shadow.withValues(alpha: isDark ? 0.4 : 0.12)
        : Colors.transparent;
    final shape = BorderRadius.circular(radius);

    return Container(
      width: width,
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: shape,
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: shadowColor,
                  blurRadius: isDark ? 20 : 18,
                  offset: Offset(0, isDark ? 12 : 8),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: shape,
          child: Ink(
            decoration: BoxDecoration(
              color: gradient != null ? null : cardColor,
              gradient: gradient,
              borderRadius: shape,
              border: Border.all(
                color: cardBorder.color.withValues(alpha: isDark ? 0.2 : 0.15),
                width: cardBorder.width,
              ),
            ),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Small statistic card with icon
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget? icon;
  final Color? valueColor;
  final VoidCallback? onTap;

  const StatCard({
    required this.title,
    required this.value,
    super.key,
    this.icon,
    this.valueColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              if (icon != null)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: scheme.primary.withValues(alpha: 0.12),
                  ),
                  child: icon,
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: valueColor ?? scheme.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Card with gradient background
class GradientCard extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  const GradientCard({
    required this.child,
    required this.gradient,
    super.key,
    this.radius = 20,
    this.padding,
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      margin: margin,
      padding: EdgeInsets.zero,
      gradient: gradient,
      radius: radius,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(20),
            child: child,
          ),
        ),
      ),
    );
  }
}

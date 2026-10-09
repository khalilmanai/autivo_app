// Common view utilities - import this in all view files.
//
// This barrel is the presentation layer's single import surface. It re-exports
// design tokens, shared widgets, formatters, validators and translations so a
// view never has to know the folder layout of `core/`, `app/`, or `l10n/`.
//
// It deliberately exports NO new widget implementations beyond view-only
// helpers (see below) — every reusable widget lives in `core/widgets/`.

import 'package:flutter/material.dart';

import '../../app/theme/index.dart';
import '../../core/network/api_exception.dart';
import '../../core/utils/api_error_localizer.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/app_spacing.dart';
import '../../l10n/translations/strings.g.dart';
export 'package:autivo/app/theme/index.dart';
export 'package:autivo/core/constants/app_constants.dart';
export 'package:autivo/core/network/api_exception.dart';
export 'package:autivo/core/utils/api_error_localizer.dart';
export 'package:autivo/core/utils/formatters.dart';
export 'package:autivo/core/utils/validators.dart';
// Re-export custom widgets and utilities only (NOT Flutter core types)
export 'package:autivo/core/widgets/index.dart';
export 'package:autivo/l10n/translations/strings.g.dart';

/// Theme + localization shortcuts available on every [BuildContext].
extension AppContext on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get text => Theme.of(this).textTheme;
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  // Typography helpers (Material 3)
  TextStyle get h1 => Theme.of(this).textTheme.displayLarge!;
  TextStyle get h2 => Theme.of(this).textTheme.displayMedium!;
  TextStyle get h3 => Theme.of(this).textTheme.displaySmall!;
  TextStyle get h4 => Theme.of(this).textTheme.headlineMedium!;
  TextStyle get h5 => Theme.of(this).textTheme.titleLarge!;
  TextStyle get body => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get bodySmall => Theme.of(this).textTheme.bodySmall!;
  TextStyle get label => Theme.of(this).textTheme.labelLarge!;
  TextStyle get muted => Theme.of(this).textTheme.bodyMedium!.copyWith(
    color: Theme.of(this).colorScheme.onSurfaceVariant,
  );
  TextStyle get p => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get small => Theme.of(this).textTheme.labelSmall!;
}

/// Semantic aliases over [ColorScheme] so views can read like design intent.
extension AppColors on ColorScheme {
  Color get destructive => error;
  Color get input => surfaceContainerHighest;
  Color get border => outline;
  Color get mutedForeground => onSurfaceVariant;
  Color get muted => surfaceContainerHighest;
  Color get background => surface;
  Color get foreground => onSurface;
  Color get card => surfaceContainerLow;
  Color get cardForeground => onSurface;
  Color get popover => surfaceContainerHighest;
  Color get popoverForeground => onSurface;
  Color get secondaryColor => secondary;
  Color get secondaryForeground => onSecondary;
  Color get accent => tertiary;
  Color get accentForeground => onTertiary;
  Color get ring => primary;
}

/// Staggered entrance animation (fade + slide-up).
///
/// [index] increases the delay so list items cascade in instead of popping
/// simultaneously. Cap the index in long lists to avoid an invisible wait.
class EntranceFadeSlide extends StatelessWidget {
  const EntranceFadeSlide({
    required this.child,
    super.key,
    this.index = 0,
    this.duration,
    this.offset = 24,
  });

  final Widget child;
  final int index;
  final Duration? duration;
  final double offset;

  /// Milliseconds added per cascade step.
  static const int stepMs = 55;

  /// Steps are clamped so a 200-item list never waits 11 seconds.
  static const int _maxStep = 6;

  @override
  Widget build(BuildContext context) {
    final step = index.clamp(0, _maxStep);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: duration ?? Duration(milliseconds: 260 + step * stepMs),
      curve: AppMotion.enter,
      child: child,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, offset * (1 - value)),
          child: child,
        ),
      ),
    );
  }
}

/// Selectable pill used for filters and multi-select rows.
class AppChip extends StatelessWidget {
  const AppChip({
    required this.label,
    super.key,
    this.selected = false,
    this.onSelected,
    this.selectedColor,
    this.checkmarkColor,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final Color? selectedColor;
  final Color? checkmarkColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: onSelected,
      selectedColor: selectedColor,
      checkmarkColor: checkmarkColor,
      labelStyle: theme.textTheme.labelMedium?.copyWith(
        color: selected
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface,
        fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
      ),
      side: BorderSide(
        color: selected
            ? theme.colorScheme.primary.withValues(alpha: 0.35)
            : theme.colorScheme.outlineVariant,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.badge),
      ),
    );
  }
}

/// Renders a localized, human-readable API error message.
class ErrorFeedback extends StatelessWidget {
  const ErrorFeedback({super.key, this.error, this.padding});

  final ApiException? error;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    if (error == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final message = localizeApiError(
      error!.code,
      context.t,
      fallback: error!.message,
    );

    return Padding(
      padding: padding ?? const EdgeInsets.only(top: AppSpacing.md),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.error.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(AppRadius.badge),
          border: Border.all(
            color: theme.colorScheme.error.withValues(alpha: 0.25),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 18,
              color: theme.colorScheme.error,
            ),
            const HGap(AppSpacing.sm),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.error,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Horizontal legend of part-status colors.
class PartStatusLegend extends StatelessWidget {
  const PartStatusLegend({super.key, this.locale});

  final String? locale;

  static const _entries = <String, Color>{
    'original': StatusColors.original,
    'replaced': StatusColors.replaced,
    'serviced': StatusColors.serviced,
    'worn': StatusColors.worn,
    'damaged': StatusColors.damaged,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.xs,
      children: [
        for (final entry in _entries.entries)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: entry.value,
                  shape: BoxShape.circle,
                ),
              ),
              const HGap(6),
              Text(
                getPartStatusLabel(entry.key, locale: locale),
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
      ],
    );
  }
}

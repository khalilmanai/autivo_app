import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../app/theme/racing_theme.dart';
import 'app_spacing.dart';

/// Centered placeholder for "nothing here yet" states.
class EmptyState extends StatelessWidget {
  const EmptyState({
    required this.title,
    super.key,
    this.subtitle,
    this.lottieAsset,
    this.icon,
    this.action,
  });

  final String title;
  final String? subtitle;
  final String? lottieAsset;
  final IconData? icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (lottieAsset != null)
              SizedBox(
                width: 200,
                height: 200,
                child: Lottie.asset(lottieAsset!),
              )
            else if (icon != null)
              Container(
                width: 116,
                height: 116,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary.withValues(alpha: 0.22),
                      theme.colorScheme.secondary.withValues(alpha: 0.08),
                    ],
                  ),
                ),
                child: Icon(icon, size: 52, color: theme.colorScheme.primary),
              ),
            const Gap(AppSpacing.lg),
            Text(
              title,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const Gap(AppSpacing.xs),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Text(
                  subtitle!,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            if (action != null) ...[const Gap(AppSpacing.lg), action!],
          ],
        ),
      ),
    );
  }
}

/// Centered error placeholder with an optional retry affordance.
class ErrorState extends StatelessWidget {
  const ErrorState({
    required this.title,
    super.key,
    this.message,
    this.onRetry,
    this.retryLabel = 'Retry',
  });

  final String title;
  final String? message;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 116,
              height: 116,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.error.withValues(alpha: 0.10),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 52,
                color: theme.colorScheme.error,
              ),
            ),
            const Gap(AppSpacing.lg),
            Text(
              title,
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const Gap(AppSpacing.xs),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Text(
                  message!,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            if (onRetry != null) ...[
              const Gap(AppSpacing.lg),
              FilledButton.tonalIcon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded, size: 18),
                label: Text(retryLabel),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Small pill used for vehicle / part status.
class StatusBadge extends StatelessWidget {
  const StatusBadge({required this.status, super.key, this.locale});

  final String status;
  final String? locale;

  ({Color fg, Color bg, String label}) _resolve(
    ThemeData theme,
    Locale? activeLocale,
  ) {
    final lang = locale ?? activeLocale?.languageCode;
    Color tint;

    switch (status) {
      case 'active':
        tint = StatusColors.active;
      case 'maintenance':
        tint = StatusColors.maintenance;
      case 'inactive':
        tint = StatusColors.inactive;
      case 'original':
        tint = StatusColors.original;
      case 'replaced':
        tint = StatusColors.replaced;
      case 'serviced':
        tint = StatusColors.serviced;
      case 'worn':
        tint = StatusColors.worn;
      case 'damaged':
        tint = StatusColors.damaged;
      default:
        return (
          fg: theme.colorScheme.onSurfaceVariant,
          bg: theme.colorScheme.surfaceContainerHighest,
          label: status,
        );
    }

    const labels = <String, (String, String, String)>{
      // key: (en, fr, ar)
      'active': ('Active', 'Actif', 'نشط'),
      'maintenance': ('Maintenance', 'Maintenance', 'صيانة'),
      'inactive': ('Inactive', 'Inactif', 'غير نشط'),
      'original': ('Original', 'Origine', 'أصلي'),
      'replaced': ('Replaced', 'Remplacé', 'مستبدل'),
      'serviced': ('Serviced', 'Entretenu', 'مخدوم'),
      'worn': ('Worn', 'Usé', 'بالي'),
      'damaged': ('Damaged', 'Endommagé', 'تالف'),
    };

    final l = labels[status]!;
    final label = switch (lang) {
      'ar' => l.$3,
      'fr' => l.$2,
      _ => l.$1,
    };

    return (fg: tint, bg: tint.withValues(alpha: 0.15), label: label);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolved = _resolve(theme, Localizations.localeOf(context));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: resolved.bg,
        borderRadius: BorderRadius.circular(AppRadius.badge),
        border: Border.all(color: resolved.fg.withValues(alpha: 0.3)),
      ),
      child: Text(
        resolved.label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: resolved.fg,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

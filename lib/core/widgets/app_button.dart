import 'package:flutter/material.dart';

import '../../app/theme/racing_theme.dart';

/// The app's button.
///
/// Supports filled / outlined / text / gradient variants and a destructive
/// tint, with a scale-down press animation so taps feel responsive on every
/// variant (including the custom gradient one, which has no built-in
/// Material press feedback).
class AppButton extends StatelessWidget {
  const AppButton({
    required this.onPressed,
    required this.child,
    super.key,
    this.isLoading = false,
    this.isDestructive = false,
    this.isOutlined = false,
    this.isText = false,
    this.width,
    this.height,
    this.gradient,
    this.enableMicroInteraction = true,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool isLoading;
  final bool isDestructive;
  final bool isOutlined;
  final bool isText;
  final double? width;
  final double? height;
  final Gradient? gradient;

  /// Scales down slightly while held. Disable for dense list rows.
  final bool enableMicroInteraction;

  bool get _isEnabled => !isLoading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final fg = isDestructive ? scheme.onError : scheme.onPrimary;
    final bg = isDestructive ? scheme.error : scheme.primary;

    final Widget content = isLoading
        ? SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              valueColor: AlwaysStoppedAnimation<Color>(
                isOutlined || isText
                    ? (isDestructive ? scheme.error : scheme.primary)
                    : fg,
              ),
            ),
          )
        : child;

    final radius = BorderRadius.circular(AppRadius.button);

    // ---- Text variant ----------------------------------------------------
    if (isText) {
      return _Pressable(
        enabled: _isEnabled && enableMicroInteraction,
        onTap: _isEnabled ? onPressed : null,
        child: TextButton(
          onPressed: _isEnabled ? onPressed : null,
          style: TextButton.styleFrom(
            foregroundColor: isDestructive ? scheme.error : scheme.primary,
            disabledForegroundColor: scheme.onSurfaceVariant,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            shape: RoundedRectangleBorder(borderRadius: radius),
          ),
          child: content,
        ),
      );
    }

    // ---- Outlined variant ------------------------------------------------
    if (isOutlined) {
      final stroke = isDestructive ? scheme.error : scheme.primary;
      return _Pressable(
        enabled: _isEnabled && enableMicroInteraction,
        onTap: _isEnabled ? onPressed : null,
        child: OutlinedButton(
          onPressed: _isEnabled ? onPressed : null,
          style: OutlinedButton.styleFrom(
            foregroundColor: stroke,
            backgroundColor: stroke.withValues(alpha: 0.06),
            disabledForegroundColor: scheme.onSurfaceVariant,
            side: BorderSide(color: stroke.withValues(alpha: 0.45)),
            minimumSize: Size(width ?? 0, height ?? 52),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            shape: RoundedRectangleBorder(borderRadius: radius),
          ),
          child: content,
        ),
      );
    }

    // ---- Gradient variant ------------------------------------------------
    if (gradient != null) {
      return _Pressable(
        enabled: _isEnabled && enableMicroInteraction,
        onTap: _isEnabled ? onPressed : null,
        child: Opacity(
          opacity: _isEnabled ? 1 : 0.5,
          child: SizedBox(
            width: width,
            height: height,
            child: Material(
              color: Colors.transparent,
              borderRadius: radius,
              clipBehavior: Clip.antiAlias,
              child: Ink(
                decoration: BoxDecoration(
                  gradient: gradient,
                  borderRadius: radius,
                ),
                child: InkWell(
                  borderRadius: radius,
                  onTap: _isEnabled ? onPressed : null,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg,
                        vertical: 15,
                      ),
                      child: DefaultTextStyle.merge(
                        style: theme.textTheme.labelLarge?.copyWith(color: fg),
                        child: IconTheme.merge(
                          data: IconThemeData(color: fg),
                          child: content,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // ---- Filled variant --------------------------------------------------
    return _Pressable(
      enabled: _isEnabled && enableMicroInteraction,
      onTap: _isEnabled ? onPressed : null,
      child: FilledButton(
        onPressed: _isEnabled ? onPressed : null,
        style: FilledButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: fg,
          disabledBackgroundColor: scheme.onSurface.withValues(alpha: 0.12),
          disabledForegroundColor: scheme.onSurface.withValues(alpha: 0.38),
          minimumSize: Size(width ?? 0, height ?? 52),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          shape: RoundedRectangleBorder(borderRadius: radius),
          elevation: 0,
        ),
        child: content,
      ),
    );
  }
}

/// Wraps a button in a press-down scale animation.
///
/// Kept as a private helper so all four variants share identical feel instead
/// of each one re-implementing the gesture handling.
class _Pressable extends StatefulWidget {
  const _Pressable({
    required this.child,
    required this.enabled,
    required this.onTap,
  });

  final Widget child;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  State<_Pressable> createState() => _PressableState();
}

class _PressableState extends State<_Pressable> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (!widget.enabled || _pressed == value) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.965 : 1,
        duration: AppMotion.instant,
        curve: AppMotion.smooth,
        child: widget.child,
      ),
    );
  }
}

/// Icon button with a built-in busy state.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.onPressed,
    required this.icon,
    super.key,
    this.tooltip,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final String? tooltip;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isLoading || onPressed == null ? null : onPressed,
      tooltip: tooltip,
      icon: isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : icon,
    );
  }
}

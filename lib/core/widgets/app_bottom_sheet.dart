import 'package:flutter/material.dart';

/// Standard bottom-sheet entry point: rounded top corners, drag handle,
/// safe-area and keyboard insets, optional title with close button.
class AppBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    Widget? title,
    Widget? child,
    double maxHeightFraction = 0.9,
    bool isScrollControlled = true,
    bool isDismissible = true,
  }) {
    final maxHeight = MediaQuery.of(context).size.height * maxHeightFraction;
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      isDismissible: isDismissible,
      enableDrag: true,
      constraints: BoxConstraints(maxHeight: maxHeight),
      builder: (context) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 16 + bottomInset),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 6),
                if (title != null) ...[
                  Row(
                    children: [
                      Expanded(
                        child: DefaultTextStyle.merge(
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                          child: title,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        tooltip: 'Close',
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                ],
                Flexible(child: child ?? const SizedBox.shrink()),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Bottom-sheet confirmation/action sheet (destructive or primary).
class AppActionSheet extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;
  final String confirmLabel;
  final String? cancelLabel;
  final bool destructive;
  final VoidCallback onConfirm;

  const AppActionSheet({
    required this.icon,
    required this.title,
    required this.confirmLabel,
    required this.onConfirm,
    super.key,
    this.message,
    this.cancelLabel,
    this.destructive = false,
  });

  static Future<void> show({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String confirmLabel,
    required VoidCallback onConfirm,
    String? message,
    String cancelLabel = 'Cancel',
    bool destructive = false,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      showDragHandle: true,
      builder: (context) => AppActionSheet(
        icon: icon,
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        destructive: destructive,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final accent = destructive ? scheme.error : scheme.primary;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withValues(alpha: 0.14),
                ),
                child: Icon(icon, size: 30, color: accent),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            if (message != null) ...[
              const SizedBox(height: 8),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              style: FilledButton.styleFrom(
                backgroundColor: destructive ? scheme.error : null,
                foregroundColor: destructive ? scheme.onError : null,
                minimumSize: const Size.fromHeight(52),
              ),
              child: Text(confirmLabel),
            ),
            if (cancelLabel != null) ...[
              const SizedBox(height: 8),
              SizedBox(
                height: 48,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(cancelLabel!),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../app/theme/index.dart';

/// Rounded search input with a leading magnifier, an animated clear button and
/// a search keyboard action.
///
/// Owns its [controller] so callers do not have to, but accepts one so a parent
/// can clear the text imperatively (for example when the selection resets). The
/// clear button only appears once there is something to clear.
class AppSearchField extends StatefulWidget {
  const AppSearchField({
    required this.hint,
    required this.onChanged,
    super.key,
    this.controller,
    this.onSubmitted,
    this.clearTooltip,
    this.autofocus = false,
    this.enabled = true,
  });

  final String hint;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final String? clearTooltip;
  final bool autofocus;
  final bool enabled;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();

  /// True when the field created its own controller and must dispose it.
  late final bool _ownsController = widget.controller == null;

  @override
  void dispose() {
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  void _clear() {
    _controller.clear();
    // A `TextEditingController` does not notify `onChanged` for `clear()`, so
    // tell the caller explicitly to keep the filtered list in sync.
    widget.onChanged('');
  }

  OutlineInputBorder _border(Color color, [double width = 1.0]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.button),
      borderSide: BorderSide(color: color, width: width),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          controller: _controller,
          autofocus: widget.autofocus,
          enabled: widget.enabled,
          textInputAction: TextInputAction.search,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: scheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
          cursorColor: scheme.primary,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
            filled: true,
            fillColor: scheme.surface,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              size: 22,
              color: scheme.onSurfaceVariant,
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 44,
              minHeight: 44,
            ),
            suffixIcon: value.text.isEmpty
                ? null
                : IconButton(
                    onPressed: _clear,
                    icon: const Icon(Icons.close_rounded, size: 20),
                    tooltip: widget.clearTooltip,
                    splashRadius: 20,
                  ),
            border: _border(scheme.outline),
            enabledBorder: _border(scheme.outline),
            focusedBorder: _border(scheme.primary, 2),
          ),
        );
      },
    );
  }
}

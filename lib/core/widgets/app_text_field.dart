import 'package:flutter/material.dart';

/// Animated text field with label, border state validation, and password toggle suffix
class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.label,
    super.key,
    this.hint,
    this.keyboardType,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines,
    this.minLines,
    this.contentPadding,
    this.borderRadius,
    this.borderWidth,
    this.fillColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.focusedErrorBorderColor,
    this.enabledBorderColor,
    this.onSaved,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onSubmitted,
    this.autofocus = false,
    this.initialValue,
    this.enabled = true,
    this.focusNode,
    this.autofillHints,
  });

  final String label;
  final String? hint;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? minLines;
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;
  final double? borderWidth;
  final Color? fillColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;
  final Color? enabledBorderColor;
  final FormFieldSetter<String>? onSaved;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;
  final String? initialValue;
  final bool enabled;
  final FocusNode? focusNode;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    final effectiveBorderRadius = borderRadius ?? BorderRadius.circular(12);
    final effectiveBorderWidth = borderWidth ?? 1.0;
    final effectiveContentPadding =
        contentPadding ??
        const EdgeInsets.symmetric(horizontal: 20, vertical: 16);

    final OutlineInputBorder effectiveBorder = OutlineInputBorder(
      borderRadius: effectiveBorderRadius,
      borderSide: BorderSide(
        color: enabledBorderColor ?? scheme.outline,
        width: effectiveBorderWidth,
      ),
    );

    final OutlineInputBorder effectiveFocusedBorder = OutlineInputBorder(
      borderRadius: effectiveBorderRadius,
      borderSide: BorderSide(
        color: focusedBorderColor ?? scheme.primary,
        width: effectiveBorderWidth + 2,
      ),
    );

    final OutlineInputBorder effectiveErrorBorder = OutlineInputBorder(
      borderRadius: effectiveBorderRadius,
      borderSide: BorderSide(
        color: errorBorderColor ?? scheme.error,
        width: effectiveBorderWidth,
      ),
    );

    final OutlineInputBorder effectiveFocusedErrorBorder = OutlineInputBorder(
      borderRadius: effectiveBorderRadius,
      borderSide: BorderSide(
        color: focusedErrorBorderColor ?? scheme.error,
        width: effectiveBorderWidth + 2,
      ),
    );

    return TextFormField(
      autofocus: autofocus,
      initialValue: initialValue,
      enabled: enabled,
      controller: controller,
      focusNode: focusNode,
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted ?? onSubmitted,
      validator: validator,
      onSaved: onSaved,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: scheme.onSurface,
        fontWeight: FontWeight.w500,
      ),
      cursorColor: scheme.primary,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant.withValues(alpha: 0.7),
        ),
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
        floatingLabelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: scheme.primary,
          fontWeight: FontWeight.w700,
        ),
        filled: true,
        fillColor: fillColor ?? scheme.surface,
        border: effectiveBorder,
        enabledBorder: effectiveBorder,
        focusedBorder: effectiveFocusedBorder,
        errorBorder: effectiveErrorBorder,
        focusedErrorBorder: effectiveFocusedErrorBorder,
        contentPadding: effectiveContentPadding,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
    );
  }
}

/// Password text field with an eye toggle in the suffix that switches between
/// obscured and plain text.
///
/// State lives here, so the caller keeps passing the same [controller]; the
/// selection and focus are explicitly restored across the toggle because
/// flipping `obscureText` otherwise collapses the caret to the end of the field.
class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    required this.controller,
    required this.label,
    super.key,
    this.hint,
    this.textInputAction,
    this.validator,
    this.onSubmitted,
    this.autofocus = false,
    this.prefixIcon,
    this.keyboardType,
    this.autofillHints,
    this.enabled = true,
    this.initiallyObscured = true,
  });

  final TextEditingController? controller;
  final String label;
  final String? hint;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;
  final bool autofocus;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final bool enabled;
  final bool initiallyObscured;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  late bool _obscureText = widget.initiallyObscured;

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _toggle() {
    final controller = widget.controller;
    if (controller == null) {
      setState(() => _obscureText = !_obscureText);
      return;
    }

    // Preserve where the caret is: re-hiding the field otherwise collapses the
    // selection to offset 0 and makes editing a long password painful.
    final selection = controller.selection;
    final base = selection.baseOffset;
    final extent = selection.extentOffset;
    final wasFocused = _focusNode.hasFocus;

    setState(() => _obscureText = !_obscureText);

    if (base < 0 || extent < 0) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // Re-read the length: it is unchanged, but the controller is owned by the
      // caller and could have been swapped or cleared.
      final safeLength = controller.text.length;
      controller.selection = TextSelection(
        baseOffset: base.clamp(0, safeLength),
        extentOffset: extent.clamp(0, safeLength),
      );
      if (wasFocused) _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return AppTextField(
      controller: widget.controller,
      focusNode: _focusNode,
      label: widget.label,
      hint: widget.hint,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      autofillHints: widget.autofillHints,
      prefixIcon: widget.prefixIcon,
      enabled: widget.enabled,
      obscureText: _obscureText,
      validator: widget.validator,
      onFieldSubmitted: widget.onSubmitted,
      suffixIcon: IconButton(
        onPressed: widget.enabled ? _toggle : null,
        icon: Icon(
          _obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: widget.enabled
              ? scheme.onSurfaceVariant
              : scheme.onSurface.withValues(alpha: 0.38),
        ),
        tooltip: _obscureText ? 'Show password' : 'Hide password',
        splashRadius: 20,
      ),
    );
  }
}

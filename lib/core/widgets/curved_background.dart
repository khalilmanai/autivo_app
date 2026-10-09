import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';

/// Curved background widget with animated gradient
class CurvedBackground extends StatelessWidget {
  final Widget child;
  final bool enableAnimation;
  final Duration animationDuration;

  const CurvedBackground({
    required this.child,
    super.key,
    this.enableAnimation = true,
    this.animationDuration = const Duration(seconds: 20),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return AnimatedContainer(
      duration: animationDuration,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: enableAnimation
              ? [scheme.surface, scheme.surfaceContainerHighest, scheme.surface]
              : [scheme.surface, scheme.surface],
        ),
      ),
      child: child,
    );
  }
}

/// Blurred background effect
class BlurredBackground extends StatelessWidget {
  final Widget child;
  final double blur;

  const BlurredBackground({required this.child, super.key, this.blur = 20});

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      child: child,
    );
  }
}

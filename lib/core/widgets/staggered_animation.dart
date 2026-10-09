import 'dart:async';

import 'package:flutter/material.dart';

/// Staggered entrance animation for list items.
///
/// Each item waits [baseDelay] * ([index] + 1) before playing a combined
/// fade + slide + scale. Implemented with a single [AnimationController] that
/// is explicitly delayed, so the controller is only ever disposed once (in
/// [dispose]) — the previous version disposed it from a status listener *and*
/// from `dispose`, which threw on the second call.
class StaggeredAnimation extends StatefulWidget {
  const StaggeredAnimation({
    required this.child,
    required this.index,
    super.key,
    this.baseDelay = const Duration(milliseconds: 90),
    this.animationDuration = const Duration(milliseconds: 320),
    this.curve = Curves.easeOutCubic,
    this.offset = const Offset(0, 0.14),
    this.beginScale = 0.92,
  });

  final Widget child;

  /// Zero-based position in the list. Drives the delay.
  final int index;

  /// Delay unit; total delay is `baseDelay * (index + 1)`.
  final Duration baseDelay;

  final Duration animationDuration;
  final Curve curve;

  /// Slide start offset, in fractions of the child's height.
  final Offset offset;

  final double beginScale;

  /// Upper bound on cascade steps so long lists don't wait seconds.
  static const int maxStaggerSteps = 8;

  @override
  State<StaggeredAnimation> createState() => _StaggeredAnimationState();
}

class _StaggeredAnimationState extends State<StaggeredAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  late final Animation<double> _scale;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    final curved = CurvedAnimation(parent: _controller, curve: widget.curve);

    _opacity = Tween<double>(begin: 0, end: 1).animate(curved);
    _slide = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(curved);
    _scale = Tween<double>(begin: widget.beginScale, end: 1).animate(curved);

    final steps = widget.index.clamp(0, StaggeredAnimation.maxStaggerSteps);
    _delayTimer = Timer(widget.baseDelay * steps, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void didUpdateWidget(covariant StaggeredAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-animate when the item's position changes (e.g. list re-sorted).
    if (oldWidget.index != widget.index) {
      _delayTimer?.cancel();
      _controller.reset();
      final steps = widget.index.clamp(0, StaggeredAnimation.maxStaggerSteps);
      _delayTimer = Timer(widget.baseDelay * steps, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(scale: _scale, child: widget.child),
      ),
    );
  }
}

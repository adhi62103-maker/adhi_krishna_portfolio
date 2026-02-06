import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedOnScroll extends StatefulWidget {
  final Widget child;
  final Axis axis;
  final double offset;
  final Duration duration;
  final Duration delay;
  final double visibleFraction;

  const AnimatedOnScroll({
    Key? key,
    required this.child,
    this.axis = Axis.vertical,
    this.offset = 0.08,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.visibleFraction = 0.12,
  }) : super(key: key);

  @override
  State<AnimatedOnScroll> createState() => _AnimatedOnScrollState();
}

class _AnimatedOnScrollState extends State<AnimatedOnScroll> {
  bool _visible = false;
  Timer? _delayTimer;

  @override
  void dispose() {
    _delayTimer?.cancel();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_visible && info.visibleFraction >= widget.visibleFraction) {
      if (widget.delay > Duration.zero) {
        _delayTimer = Timer(widget.delay, () {
          if (mounted) setState(() => _visible = true);
        });
      } else {
        setState(() => _visible = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final beginOffset = widget.axis == Axis.vertical
        ? Offset(0, widget.offset)
        : Offset(widget.offset, 0);

    return VisibilityDetector(
      key: UniqueKey(),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedOpacity(
        duration: widget.duration,
        opacity: _visible ? 1.0 : 0.0,
        curve: Curves.easeOut,
        child: AnimatedSlide(
          duration: widget.duration,
          offset: _visible ? Offset.zero : beginOffset,
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class FloatingWidget extends StatefulWidget {
  final Widget child;
  final double amplitude; // vertical movement in px
  final Duration duration;
  final double phase; // phase offset 0..1

  const FloatingWidget({
    Key? key,
    required this.child,
    this.amplitude = 6.0,
    this.duration = const Duration(milliseconds: 4500),
    this.phase = 0.0,
  }) : super(key: key);

  @override
  State<FloatingWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, child) {
        final t = (_ctrl.value + widget.phase) % 1.0;
        final y = sin(2 * pi * t) * widget.amplitude;
        final scale = 1 + (sin(2 * pi * t + pi / 2) * 0.006);
        return Transform.translate(
          offset: Offset(0, y),
          child: Transform.scale(scale: scale, child: child),
        );
      },
      child: widget.child,
    );
  }
}

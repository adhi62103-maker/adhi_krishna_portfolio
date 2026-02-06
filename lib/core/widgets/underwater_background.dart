import 'package:flutter/material.dart';

class UnderwaterBackground extends StatelessWidget {
  final Widget child;

  const UnderwaterBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Deep ocean gradient
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF05243A), Color(0xFF042235)],
            ),
          ),
        ),
        // Subtle light rays overlay
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(painter: _LightRaysPainter()),
          ),
        ),
        // Bubbles layer
        Positioned.fill(child: IgnorePointer(child: _BubblesLayer())),
        // Foreground content
        child,
      ],
    );
  }
}

class _BubblesLayer extends StatefulWidget {
  @override
  State<_BubblesLayer> createState() => _BubblesLayerState();
}

class _BubblesLayerState extends State<_BubblesLayer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
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
      builder: (context, _) {
        return CustomPaint(painter: _BubblesPainter(progress: _ctrl.value));
      },
    );
  }
}

class _BubblesPainter extends CustomPainter {
  final double progress;
  _BubblesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.06);
    final rand = List.generate(8, (i) => i);
    for (var i in rand) {
      final cx = (size.width * ((i * 0.37) % 1.0));
      final sp = ((i * 0.21) % 1.0) * 1.2 + 0.6;
      final y = size.height - ((progress + i * 0.12) % 1.0) * size.height * sp;
      final r = 6.0 + (i % 4) * 3.0;
      canvas.drawCircle(Offset(cx + (i * 7) % 20, y), r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _BubblesPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _LightRaysPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white.withOpacity(0.04), Colors.transparent],
      stops: [0.0, 0.6],
    );
    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);

    // soft diagonal streaks
    final streakPaint = Paint()
      ..color = Colors.white.withOpacity(0.02)
      ..strokeWidth = 120
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 40);

    for (var i = -2; i < 3; i++) {
      final dx = size.width * 0.2 * i;
      canvas.drawLine(
        Offset(dx, 0),
        Offset(dx + size.width * 0.4, size.height),
        streakPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

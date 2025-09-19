import 'package:flutter/material.dart';
import 'package:unigate/core/theme/text_styles.dart';

class TwinRingProgress extends StatelessWidget {
  final double profile;
  final double applications;
  const TwinRingProgress(
      {super.key, required this.profile, required this.applications});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      width: 88,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _Ring(value: applications, bg: Colors.white12, fg: Colors.white),
          Center(
            child: SizedBox(
              height: 64,
              width: 64,
              child: _Ring(
                value: profile,
                bg: Colors.white10,
                fg: Colors.amberAccent,
              ),
            ),
          ),
          Center(
            child: Text(
              '${(profile * 100).round()}%',
              style: AppTextStyles.inter400White16,
            ),
          )
        ],
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  final double value; // 0..1
  final Color bg;
  final Color fg;

  const _Ring({required this.value, required this.bg, required this.fg});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.clamp(0.0, 1.0)),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      builder: (context, v, _) {
        return CustomPaint(
          painter: _RingPainter(progress: v, bg: bg, fg: fg),
        );
      },
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color bg;
  final Color fg;

  _RingPainter({required this.progress, required this.bg, required this.fg});

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.shortestSide * 0.11;
    final center = size.center(Offset.zero);
    final radius = (size.shortestSide - stroke) / 2;

    final bgPaint = Paint()
      ..color = bg
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final fgPaint = Paint()
      ..shader = SweepGradient(
        colors: [fg.withOpacity(.9), fg],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * 0.0174533,
      360 * 0.0174533,
      false,
      bgPaint,
    );

    final sweep = 360 * progress * 0.0174533;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -90 * 0.0174533,
      sweep,
      false,
      fgPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.fg != fg ||
      oldDelegate.bg != bg;
}

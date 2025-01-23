import 'package:flutter/material.dart';
import 'dart:math' as math;

class HumidityDialPainter extends CustomPainter {
  final double progress;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;
  final bool showCheckmark;

  HumidityDialPainter({
    required this.progress,
    this.progressColor = Colors.green,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.strokeWidth = 10,
    this.showCheckmark = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth;

    // Setup paints
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Draw background arc (270 degrees, starting from -225)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -225 * math.pi / 180, // Start angle in radians
      270 * math.pi / 180, // Sweep angle in radians
      false,
      backgroundPaint,
    );

    // Draw progress arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -225 * math.pi / 180,
      270 * math.pi / 180 * progress,
      false,
      progressPaint,
    );

    // Draw tick marks
    _drawTickMarks(canvas, center, radius, size);

    // Draw checkmark if needed
    if (showCheckmark && progress >= 0.4 && progress <= 0.6) {
      _drawCheckmark(canvas, center, radius);
    }
  }

  void _drawTickMarks(Canvas canvas, Offset center, double radius, Size size) {
    final tickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5; // Make all ticks thinner and more delicate

    // Calculate the last active tick index based on progress
    final activeTickIndex = (progress * 27).floor();

    for (int i = 0; i < 27; i++) {
      final angle = -225 + (i * 10); // 270 degrees divided into 27 parts
      final angleInRadians = angle * math.pi / 180;

      // Determine if this is the last active tick
      final isLastActiveTick = i == activeTickIndex;

      // Set color based on active state
      tickPaint.color =
          i <= activeTickIndex ? progressColor : Colors.grey[300]!;

      // Adjust length based on whether it's the last active tick
      final inwardExtension =
          isLastActiveTick ? 8.0 : 6.0; // Last tick slightly longer

      final innerPoint = Offset(
        center.dx + (radius - inwardExtension) * math.cos(angleInRadians),
        center.dy + (radius - inwardExtension) * math.sin(angleInRadians),
      );
      final outerPoint = Offset(
        center.dx + radius * math.cos(angleInRadians),
        center.dy + radius * math.sin(angleInRadians),
      );

      canvas.drawLine(innerPoint, outerPoint, tickPaint);
    }
  }

  void _drawCheckmark(Canvas canvas, Offset center, double radius) {
    final checkmarkPaint = Paint()
      ..color = progressColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final checkmarkPath = Path();
    final checkmarkSize = radius * 0.3;

    // Calculate checkmark position at the bottom of the circle
    final checkmarkCenter = Offset(
      center.dx,
      center.dy + radius - checkmarkSize,
    );

    // Draw checkmark
    checkmarkPath.moveTo(
      checkmarkCenter.dx - checkmarkSize / 2,
      checkmarkCenter.dy,
    );
    checkmarkPath.lineTo(
      checkmarkCenter.dx - checkmarkSize / 6,
      checkmarkCenter.dy + checkmarkSize / 2,
    );
    checkmarkPath.lineTo(
      checkmarkCenter.dx + checkmarkSize / 2,
      checkmarkCenter.dy - checkmarkSize / 2,
    );

    canvas.drawPath(checkmarkPath, checkmarkPaint);
  }

  @override
  bool shouldRepaint(HumidityDialPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.showCheckmark != showCheckmark;
  }
}

import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A custom painter that draws a circular dial with tick marks, progress arc, and optional checkmark
/// This can be used for displaying humidity or any other percentage-based metric
class HumidityDialPainter extends CustomPainter {
  // Core parameters that control the dial's appearance and behavior
  final double progress; // Value between 0.0 and 1.0 (0% to 100%)
  final Color progressColor; // Color for active elements (arc, ticks)
  final Color backgroundColor; // Color for inactive elements
  final double strokeWidth; // Thickness of the main arcs
  final bool showCheckmark; // Whether to show the checkmark indicator

  /// Constructor with customizable parameters
  /// [progress]: The current value (0.0 to 1.0)
  /// [progressColor]: Color for active elements (default: green)
  /// [backgroundColor]: Color for inactive elements (default: light gray)
  /// [strokeWidth]: Thickness of the arcs (default: 10)
  /// [showCheckmark]: Show checkmark when in optimal range (default: true)
  HumidityDialPainter({
    required this.progress,
    this.progressColor = Colors.green,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.strokeWidth = 10,
    this.showCheckmark = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate center point and radius for the dial
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth;

    // Setup paint styles for background and progress arcs
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

    // Draw the background arc (270 degrees, starting from -225)
    // This creates the inactive portion of the dial
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -225 * math.pi / 180, // Start at -225 degrees
      270 * math.pi / 180, // Sweep 270 degrees
      false,
      backgroundPaint,
    );

    // Draw the progress arc
    // This shows the active portion based on the progress value
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -225 * math.pi / 180,
      270 * math.pi / 180 * progress,
      false,
      progressPaint,
    );

    // Draw the tick marks around the dial
    _drawTickMarks(canvas, center, radius, size);

    // Draw checkmark if enabled and progress is in optimal range (40-60%)
    if (showCheckmark && progress >= 0.4 && progress <= 0.6) {
      _drawCheckmark(canvas, center, radius);
    }
  }

  /// Draws the tick marks around the dial
  /// - 27 evenly spaced ticks
  /// - Active ticks use progressColor
  /// - Inactive ticks use gray
  /// - Last active tick is slightly longer
  void _drawTickMarks(Canvas canvas, Offset center, double radius, Size size) {
    final tickPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.5; // Thin, delicate tick marks

    // Calculate which tick should be the last active one
    final activeTickIndex = (progress * 27).floor();

    // Draw 27 tick marks evenly spaced around the dial
    for (int i = 0; i < 27; i++) {
      final angle = -225 + (i * 10); // Space ticks every 10 degrees
      final angleInRadians = angle * math.pi / 180;

      // Determine if this is the last active tick
      final isLastActiveTick = i == activeTickIndex;

      // Set color based on whether tick is active
      tickPaint.color =
          i <= activeTickIndex ? progressColor : Colors.grey[300]!;

      // Make the last active tick slightly longer
      final inwardExtension = isLastActiveTick ? 8.0 : 6.0;

      // Calculate tick start and end points
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

  /// Draws the checkmark indicator when progress is in optimal range
  /// The checkmark appears at the bottom of the dial
  void _drawCheckmark(Canvas canvas, Offset center, double radius) {
    final checkmarkPaint = Paint()
      ..color = progressColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final checkmarkPath = Path();
    final checkmarkSize = radius * 0.3; // Checkmark size relative to dial

    // Position checkmark at the bottom of the dial
    final checkmarkCenter = Offset(
      center.dx,
      center.dy + radius - checkmarkSize,
    );

    // Draw the checkmark using a path
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

import 'dart:math';
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double percentage;
  final String label;
  final String subtitle;

  const CustomCircularProgressIndicator({
    super.key,
    required this.percentage,
    required this.label,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.grey[300]!,
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Colors.grey[100]!,
            width: 1,
          ),
        ),
        child: CustomPaint(
          painter: CircularProgressPainter(
            percentage: percentage,
            color: const Color(0xFF3FBD40),
            backgroundColor: const Color(0xFFF5F5F5),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$percentage%',
                  style: const TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF3FBD40),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 190, 188, 188),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 6),
                const Icon(
                  Icons.check_circle,
                  color: Color(0xFF3FBD40),
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircularProgressPainter extends CustomPainter {
  final double percentage;
  final Color color;
  final Color backgroundColor;
  static const int totalBars = 60; // Increased number of bars
  static const double barWidth = 2.5; // Thinner bars
  static const double gapDegrees = 2.0; // Smaller gaps

  CircularProgressPainter({
    required this.percentage,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2) - 20;

    // Calculate how many bars should be filled based on percentage
    final filledBars = (totalBars * (percentage / 100)).round();

    // Calculate the sweep angle for each bar
    const totalGapSpace = gapDegrees * totalBars;
    final barSweepDegrees = (360 - totalGapSpace) / totalBars;

    // Convert degrees to radians for the calculations
    final barSweepRadians = (barSweepDegrees * pi) / 180;
    const gapRadians = (gapDegrees * pi) / 180;

    // Draw each bar
    for (int i = 0; i < totalBars; i++) {
      final startAngle = -pi / 2 + (i * (barSweepRadians + gapRadians));
      final isActive = i < filledBars;

      // Draw bar
      final paint = Paint()
        ..color = isActive ? color : backgroundColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = barWidth
        ..strokeCap = StrokeCap.round;

      if (!isActive) {
        // Add subtle inner shadow for inactive bars
        final shadowPaint = Paint()
          ..color = Colors.grey[100]!
          ..style = PaintingStyle.stroke
          ..strokeWidth = barWidth
          ..strokeCap = StrokeCap.round;

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius - 0.5),
          startAngle,
          barSweepRadians,
          false,
          shadowPaint,
        );
      }

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        barSweepRadians,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CircularProgressPainter oldDelegate) =>
      percentage != oldDelegate.percentage;
}

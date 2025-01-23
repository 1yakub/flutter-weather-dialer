import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HumidityDialWidget extends StatelessWidget {
  final double averageHumidity;
  final double currentHumidity;

  const HumidityDialWidget({
    super.key,
    required this.averageHumidity,
    required this.currentHumidity,
  });

  @override
  Widget build(BuildContext context) {
    final robotoNormal = GoogleFonts.roboto(fontWeight: FontWeight.w400);

    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(180, 180),
            painter: HumidityProgressPainter(
              progress: averageHumidity / 100,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: averageHumidity.toStringAsFixed(0),
                      style: GoogleFonts.roboto(
                        fontSize: 40,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -3,
                        color: const Color(0xFF3ABE51),
                        height: 0.5,
                      ),
                    ),
                    TextSpan(
                      text: ' %',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -1,
                        color: const Color(0xFF3ABE51),
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'HUMIDITY',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  letterSpacing: -1,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF757575),
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '72hr Average',
                style: robotoNormal.copyWith(
                  fontSize: 10,
                  letterSpacing: 0.2,
                  color: const Color.fromARGB(255, 145, 145, 145),
                  height: 1.0,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 32,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF3ABE51),
              ),
              child: const Icon(
                Icons.check,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HumidityProgressPainter extends CustomPainter {
  final double progress;
  static const int totalBars = 100;

  HumidityProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.42;
    const barHeight = 9.0;

    // Draw grey circle first (outer circle)
    final circlePaint = Paint()
      ..color = const Color.fromARGB(255, 242, 241, 241)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;
    canvas.drawCircle(center, radius, circlePaint);

    final progressBars = (totalBars * progress).round();
    // Start at 7 o'clock (210 degrees)
    const startAngle = (135 * math.pi / 180);
    // End at 5 o'clock (150 degrees), sweep counterclockwise
    const sweepAngle = (270 * math.pi / 180);
    const barWidth = 1.2;

    // Draw bars slightly inside the grey circle
    final barsRadius = radius - 10;

    // Draw all bars (active and inactive)
    for (var i = 0; i < totalBars; i++) {
      final t = i / (totalBars - 1); // Normalized position [0, 1]
      final angle = startAngle + (sweepAngle * t);
      final barCenter = Offset(
        center.dx + barsRadius * math.cos(angle),
        center.dy + barsRadius * math.sin(angle),
      );

      final barPaint = Paint()
        ..color = i < progressBars
            ? const Color.fromARGB(255, 70, 202, 92)
            : const Color.fromARGB(255, 242, 242, 242)
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(barCenter.dx, barCenter.dy);
      canvas.rotate(angle + math.pi / 2);

      canvas.drawRect(
        Rect.fromCenter(
          center: Offset.zero,
          width: barWidth,
          height: barHeight,
        ),
        barPaint,
      );

      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant HumidityProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Usage example widget
class HumidityDisplay extends StatelessWidget {
  const HumidityDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const HumidityDialWidget(
          currentHumidity: 44,
          averageHumidity: 45,
        ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                child: Text(
                  'DETAILS',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        _buildMetricRow(
          icon: Icons.cloud,
          label: 'Current Temperature',
          value: '58°F',
        ),
        _buildMetricRow(
          icon: Icons.battery_full,
          label: 'Battery Life',
          value: '71%',
        ),
        _buildMetricRow(
          icon: Icons.warning_outlined,
          label: 'Impact Incidents',
          value: '---',
        ),
      ],
    );
  }

  Widget _buildMetricRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 20),
          const SizedBox(width: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.withOpacity(0.7),
              fontSize: 14,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.chevron_right,
            color: Colors.grey.withOpacity(0.5),
          ),
        ],
      ),
    );
  }
}

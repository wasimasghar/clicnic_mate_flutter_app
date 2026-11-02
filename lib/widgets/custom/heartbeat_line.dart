// Decorative heartbeat trace used behind the splash illustration.
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';

/// Draws a thin teal pulse line.
class HeartbeatLine extends StatelessWidget {
  const HeartbeatLine({super.key});
  @override
  Widget build(BuildContext context) => SizedBox(
    height: AppSpacing.splashHeartbeatHeight,
    width: double.infinity,
    child: CustomPaint(painter: HeartbeatPainter()),
  );
}

/// Painter for the decorative heartbeat trace.
class HeartbeatPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.25)
      ..strokeWidth = AppSpacing.inputBorderWidth
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(0, size.height * .55)
      ..lineTo(size.width * .32, size.height * .55)
      ..lineTo(size.width * .39, size.height * .35)
      ..lineTo(size.width * .44, size.height * .76)
      ..lineTo(size.width * .51, size.height * .08)
      ..lineTo(size.width * .58, size.height * .58)
      ..lineTo(size.width, size.height * .58);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

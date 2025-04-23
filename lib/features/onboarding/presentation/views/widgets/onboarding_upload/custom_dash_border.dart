// Custom dashed border implementation
import 'package:flutter/material.dart';

import '../../../../../../core/utils/app_colors.dart';

class DashedBorder extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  const DashedBorder({
    super.key,
    required this.child,
    this.color = AppColors.primaryColor,
    this.strokeWidth = 2.0,
    this.dashWidth = 10.0,
    this.dashSpace = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        dashWidth: dashWidth,
        dashSpace: dashSpace,
      ),
      child: child,
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    const borderRadius = 20.0;
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(borderRadius),
      ));

    final metrics = path.computeMetrics().first;
    final totalLength = metrics.length;

    for (double i = 0; i < totalLength; i += dashWidth + dashSpace) {
      final segment = metrics.extractPath(i, i + dashWidth);
      canvas.drawPath(segment, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  LinePainter({required this.blurRadius});

  final double blurRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      //..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height / 2,
    );

    final blurPaint = Paint()
      ..color = Colors.deepPurpleAccent
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius);

    canvas.drawPath(path, blurPaint);
    //canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) =>
      oldDelegate.blurRadius != blurRadius;
}

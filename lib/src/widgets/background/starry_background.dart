import 'dart:math' as math;

import 'package:flutter/material.dart';

final class StarryBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final stars = (size.width * size.height) / 5000;

    final random = math.Random();
    for (var i = 0; i < stars; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * 2;
      final paint = Paint()..color = Colors.white;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

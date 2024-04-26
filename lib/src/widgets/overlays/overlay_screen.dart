import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'line_painter.dart';

class OverlayScreen extends StatefulWidget {
  const OverlayScreen({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  _OverlayScreenState createState() => _OverlayScreenState();
}

class _OverlayScreenState extends State<OverlayScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _blurAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);

    _blurAnimation = Tween<double>(begin: 5, end: 20).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _blurAnimation,
      builder: (context, _) {
        return Container(
          alignment: const Alignment(0, -0.15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CustomPaint(
                    painter: LinePainter(blurRadius: _blurAnimation.value),
                    size: const Size(600, 35),
                  ),
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ).animate().slideY(duration: 750.ms, begin: -3, end: 0),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                widget.subtitle,
                style: Theme.of(context).textTheme.headlineSmall,
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .fadeIn(duration: 1.seconds)
                  .then()
                  .fadeOut(duration: 1.seconds),
            ],
          ).animate().scaleXY(duration: 0.5.seconds, begin: 0.5, end: 1),
        );
      },
    );
  }
}

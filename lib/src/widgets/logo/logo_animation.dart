import 'package:flutter/material.dart';

class LogoAnimation extends StatelessWidget {
  const LogoAnimation({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      duration: const Duration(milliseconds: 1200),
      builder: (context, value, _) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..scale(value),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            opacity: value.clamp(0.0, 1.0),
            child: child,
          ),
        );
      },
    );
  }
}

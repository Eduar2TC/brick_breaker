import 'package:brick_breaker/src/config.dart';
import 'package:flutter/material.dart';

import 'circle_figure.dart';
import 'logo_title.dart';

class LogoContainer extends StatefulWidget {
  const LogoContainer({
    super.key,
    required this.controller,
  });
  final AnimationController controller;
  @override
  State<LogoContainer> createState() => _LogoContainerState();
}

class _LogoContainerState extends State<LogoContainer>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _translateAnimation;
  @override
  void initState() {
    super.initState();
    _translateAnimation = CurvedAnimation(
      parent: widget.controller,
      curve: const Interval(
        0.6,
        1.0,
        curve: Curves.elasticOut,
      ),
    );

    widget.controller.forward();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.only(top: 50),
        width: gameWidth * 0.8,
        height: gameHeight * 0.23,
        decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(
            Radius.circular(150),
          ),
        ),
        child: Stack(
          children: [
            //Draw a circle
            AnimatedBuilder(
              animation: widget.controller,
              builder: (BuildContext context, Widget? _) {
                return Transform.translate(
                  offset: Offset(
                    -450 + _translateAnimation.value * 500,
                    _translateAnimation.value * 50,
                  ),
                  child: const CircleFigure(),
                );
              },
            ),
            const LogoTitle()
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'logo_container.dart';

class LogoAnimation extends StatefulWidget {
  const LogoAnimation({
    Key? key,
  }) : super(key: key);

  @override
  _LogoAnimationState createState() => _LogoAnimationState();
}

class _LogoAnimationState extends State<LogoAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _translateAnimation;
  late final Animation<double> _opacityAnimation;
  late final Widget _logoContainer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    _translateAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.2,
        1.0,
        curve: Curves.elasticOut,
      ),
    );

    _opacityAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.3,
        0.5,
        curve: Curves.easeIn,
      ),
    );
    _logoContainer = LogoContainer(
      controller: _controller,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Transform(
          alignment: Alignment.topCenter,
          transform: Transform.translate(
            offset: Offset(
              0,
              200 * (1 - _translateAnimation.value),
            ),
          ).transform,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 0),
            opacity: _opacityAnimation.value,
            child: _logoContainer,
          ),
        );
      },
    );
  }
}

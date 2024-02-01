import 'package:brick_breaker/src/brick_breaker.dart';
import 'package:flutter/material.dart';

class OverlayCounter extends StatefulWidget {
  const OverlayCounter({super.key});
  @override
  State<OverlayCounter> createState() => _OverlayCounterState();
}

class _OverlayCounterState extends State<OverlayCounter> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: const Alignment(0, -0.15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder(
              tween: IntTween(begin: 3, end: 0),
              duration: const Duration(seconds: 3),
              onEnd: () {
                //add playing state
                BrickBreaker().playState = PlayState.playing;
                debugPrint('Playing $PlayState.playing');
              },
              builder: (context, value, _) {
                return Text(
                  value.toString(),
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 100,
                      ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

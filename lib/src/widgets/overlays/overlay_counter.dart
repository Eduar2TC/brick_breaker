import 'dart:async';

import 'package:flutter/material.dart';

class OverlayCounter extends StatefulWidget {
  const OverlayCounter({super.key});
  @override
  State<OverlayCounter> createState() => _OverlayCounterState();
}

class _OverlayCounterState extends State<OverlayCounter> {
  Timer? _timer;
  int _counter = 3;
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: const Alignment(0, -0.15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TweenAnimationBuilder(
              key: ValueKey(_counter),
              tween: Tween<double>(begin: 0.0, end: 1.0),
              //rebound effect
              curve: Curves.elasticOut,
              duration: const Duration(seconds: 1),
              //reduce size of text 'GO!' on end of animation
              builder: (context, value, _) {
                return Stack(
                  children: [
                    Opacity(
                      opacity: value.clamp(0.0, 1.0),
                      child: Transform.translate(
                        offset: _counter == 0
                            ? const Offset(0, 100)
                            : Offset(
                                0,
                                -100 * (1 - value * 2),
                              ),
                        child: Text(
                          _counter == 0 ? 'GO!' : _counter.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                fontSize: _counter == 0 ? 200 * value : 100,
                              ),
                        ),
                      ),
                    ),
                    _counter >= 1 && _counter < 3
                        ? TweenAnimationBuilder(
                            key: ValueKey(_counter),
                            tween: Tween<Offset>(
                                begin: const Offset(0, 100),
                                end: const Offset(0, 250)),
                            curve: Curves.fastOutSlowIn,
                            duration: const Duration(milliseconds: 500),
                            builder: (context, valueOffset, _) {
                              return TweenAnimationBuilder(
                                duration: const Duration(milliseconds: 500),
                                tween: Tween<double>(begin: 1.0, end: 0.0),
                                builder: (context, value, _) => Opacity(
                                  opacity: value,
                                  child: Transform.translate(
                                    offset: valueOffset,
                                    child: Text(
                                      _counter.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge!
                                          .copyWith(
                                            fontSize: 100,
                                          ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const SizedBox(),
                  ],
                );
              },
              onEnd: () {
                if (_counter > 0) {
                  _timer = Timer(const Duration(milliseconds: 500), () {
                    setState(() {
                      _counter--;
                    });
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

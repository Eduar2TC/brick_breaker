import 'dart:async';
import 'package:brick_breaker/src/brick_breaker.dart';
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
              curve: Curves.fastOutSlowIn,
              duration: const Duration(seconds: 1),
              builder: (context, value, _) {
                return Opacity(
                  opacity: 1.0 * value,
                  child: Transform.translate(
                    offset: _counter == 0
                        ? const Offset(0, 100)
                        : Offset(0, -100 * (1 - value * 2)),
                    child: Text(
                      _counter == 0 ? 'GO!' : _counter.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                        fontSize: _counter == 0 ? 100 * value: 100,
                      ),
                    ),
                  ),
                );
              },
              onEnd: () {
                if (_counter > 0) {
                  _timer = Timer(const Duration(seconds: 1), () {
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

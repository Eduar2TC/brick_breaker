import 'package:flutter/material.dart';

class LogoTitle extends StatelessWidget {
  const LogoTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 100, left: 20),
      child: Align(
        alignment: Alignment.topCenter,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'BRICK\n',
                style: TextStyle(
                  fontSize: 90,
                  color: Theme.of(context).colorScheme.secondary,
                  fontFamily:
                      Theme.of(context).textTheme.headlineLarge!.fontFamily,
                  letterSpacing: 10,
                  shadows: [
                    Shadow(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      blurRadius: 8,
                      offset: const Offset(5, 5),
                    ),
                  ],
                ),
              ),
              const WidgetSpan(
                child: SizedBox(
                  height: 90,
                ),
              ),
              TextSpan(
                text: 'BREAKER',
                style: TextStyle(
                  fontSize: 60,
                  color: Colors.white,
                  fontFamily:
                      Theme.of(context).textTheme.headlineLarge!.fontFamily,
                  letterSpacing: 5,
                  shadows: const [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 7,
                      offset: Offset(3, 5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

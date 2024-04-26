import 'package:flutter/material.dart';

class CircleFigure extends StatelessWidget {
  const CircleFigure({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
              center: const Alignment(-0.7, -1.1),
              radius: 0.5,
              colors: [
                Colors.blue.shade50,
                Theme.of(context).colorScheme.shadow
              ],
              stops: const [
                0.4,
                1.0
              ]),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 60, 62, 63).withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 7,
              offset: const Offset(0, 3),
            )
          ]),
    );
  }
}

import 'package:brick_breaker/src/config.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class RectangleButton extends StatefulWidget {
   const RectangleButton({super.key, required this.icon, required this.btnColor, required this.textColor});
  static  double width = gameWidth * 0.10;
  static const double height = gameHeight * 0.03;
  final MaterialAccentColor btnColor;
  final Color textColor;
  final IconData icon;

  @override
  State<RectangleButton> createState() => _RectangleButtonState();
}

class _RectangleButtonState extends State<RectangleButton> {

  double get width => RectangleButton.width;
  MaterialAccentColor get btnColor => widget.btnColor;
  Color get textColor => widget.textColor;

  set width(double width) {
    setState(() {
      RectangleButton.width = width;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.black12,
        borderRadius: BorderRadius.circular(40),
        border: const Border(
            top: BorderSide(color: Colors.white, width: 2),
            bottom: BorderSide(color: Colors.white, width: 6),
            left: BorderSide(color: Colors.white, width: 4),
            right: BorderSide(color: Colors.white, width: 4)),
      ),
      child: InkWell(
        onTap: () {
        width  = RectangleButton.width + RectangleButton.width * 0.10;
        //pause game
        // widget.game?.pauseEngine();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeIn,
          width: RectangleButton.width,
          height: RectangleButton.height,
          onEnd: () {
            if( width >= gameWidth * 0.10 ){
              width = RectangleButton.width - RectangleButton.width * 0.10;
            }
          },
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: btnColor,
            borderRadius: BorderRadius.circular(40),
            border: const Border(
                top: BorderSide(color: Colors.black12, width: 3),
                bottom: BorderSide(color: Colors.black12, width: 8),
                left: BorderSide(color: Colors.black12, width: 3),
                right: BorderSide(color: Colors.black12, width: 3)),
          ),
          child: Center(
              child: Icon(
                widget.icon,
            color: textColor,
            size: RectangleButton.width * 0.5,
          ),),
        ),
      ),
    );
  }
}

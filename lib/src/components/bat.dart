import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
//aceleometer

import '../brick_breaker.dart';

class Bat extends PositionComponent
    with DragCallbacks, HasGameReference<BrickBreaker> {
  Bat({
    required this.cornerRadius,
    required super.position,
    required super.size,
  }) : super(
          anchor: Anchor.center,
          children: [RectangleHitbox()],
        );

  final Radius cornerRadius;

  final _paint = Paint()
    ..color = const Color(0xff1e6091)
    ..style = PaintingStyle.fill;

  @override
  void render(Canvas canvas) {
    //draws the bat
    super.render(canvas);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size.toSize(),
          cornerRadius,
        ),
        _paint);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    //moves the bat with the finger
    super.onDragUpdate(event);
    position.x = (position.x + event.localDelta.x)
        .clamp(width / 2, game.width - width / 2);
  }

  @override
  void onLoad() {
    //moves the bat with accelerometer
    super.onLoad();
    startListening();
  }

  void moveBy(double dx) {
    //moves the bat with keyboard
    add(
      MoveToEffect(
        Vector2(
          (position.x + dx).clamp(width / 2, game.width - width / 2),
          position.y,
        ),
        EffectController(duration: 0.1),
      ),
    );
  }

  //moves the bat with accelerometer
  void startListening() {
    accelerometerEventStream.call().listen(
      (event) {
        moveBy(event.x * 30);
      },
      onError: (error) {
        debugPrint(error.toString());
      },
    );
  }
}

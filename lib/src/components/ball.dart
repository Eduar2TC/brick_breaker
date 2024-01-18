import 'package:flame/collisions.dart'; // Add this import
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../brick_breaker.dart'; // And this import
import 'play_area.dart'; // And this one too

import 'package:flame/effects.dart';
import 'bat.dart';
import 'brick.dart';

class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<BrickBreaker> {
  // Add these mixins
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
    required this.difficultyModifier,
  }) : super(
            radius: radius,
            anchor: Anchor.center,
            paint: Paint()
              ..color = const Color(0xff1e6091)
              ..style = PaintingStyle.fill,
            children: [CircleHitbox()]); //

  final Vector2 velocity; //ball velocity
  final double difficultyModifier; // difficult game

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is PlayArea) {
      if (intersectionPoints.first.y <= 0) {
        //detection colision with play area
        velocity.y = -velocity.y;
      } else if (intersectionPoints.first.x <= 0) {
        //detect collision with left play area
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.x >= game.width) {
        //detect collision with right play area
        velocity.x = -velocity.x;
      } else if (intersectionPoints.first.y >= game.height) {
        //detect collision with bottom play area
        //removeFromParent();
        add(
          RemoveEffect(
              delay: 0.35,
              onComplete: () =>
                  game.playState = PlayState.gameOver), //game over
        ); //remove ball
      }
    } else if (other is Bat) {
      //detection colision with bat
      velocity.y = -velocity.y;
      velocity.x = velocity.x +
          (position.x - other.position.x) / other.size.x * game.width * 0.3;
    } else if (other is Brick) {
      //detection collision top and bottom of brick
      if (position.y < other.position.y - other.size.y / 2) {
        velocity.y = -velocity.y;
      } else if (position.y > other.position.y + other.size.y / 2) {
        velocity.y = -velocity.y;
        //detection collision left and right of brick
      } else if (position.x < other.position.x) {
        velocity.x = -velocity.x;
      } else if (position.x > other.position.x) {
        velocity.x = -velocity.x;
      }
      velocity.setFrom(velocity * difficultyModifier); //personalize this
    } else {
      debugPrint('collision with $other');
    }
  }
}

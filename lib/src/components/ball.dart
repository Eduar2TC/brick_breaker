import 'package:brick_breaker/src/components/audio.dart';
import 'package:flame/collisions.dart'; // Add this import
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../screens/levels/level_one.dart'; // And this import
import 'bat.dart';
import 'brick.dart';
import 'play_area.dart'; // And this one too

class Ball extends CircleComponent
    with CollisionCallbacks, HasGameReference<LevelOne> {
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
      BrickBreakerAudio.playHitWithArea();
      if (intersectionPoints.first.y <= 0) {
        //detection collision with play area
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
            onComplete: () => game.playState = PlayState.gameOver,
          ), //game over
        ); //remove ball
      }
    } else if (other is Bat) {
      //detection collision with bat
      velocity.y = -velocity.y;
      velocity.x = velocity.x +
          (position.x - other.position.x) / other.size.x * game.width * 0.3;
      BrickBreakerAudio.playHitWithBat();
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
      BrickBreakerAudio.playBrickHitSound();
    } else {
      debugPrint('collision with $other');
    }
  }
}

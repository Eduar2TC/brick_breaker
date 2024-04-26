import 'package:brick_breaker/src/components/particles.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../config.dart';
import '../screens/levels/level_one.dart';
import 'ball.dart';
import 'bat.dart';

class Brick extends RectangleComponent
    with CollisionCallbacks, HasGameReference<LevelOne> {
  Brick(Vector2 position, Color color)
      : super(
          position: position,
          size: Vector2(brickWidth, brickHeight),
          anchor: Anchor.center,
          paint: Paint()
            ..color = color
            ..style = PaintingStyle.fill,
          children: [RectangleHitbox()],
        );

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    removeFromParent();
    game.score.value++; //increment score game
    //add particle effect
    game.world.add(
      ParticleSystemComponent(
        priority: 100,
        particle: explodeBrickParticle(paint),
        position: position.clone(),
      ),
    );
    //game wins when all bricks are removed
    if (game.world.children.query<Brick>().length == 1) {
      game.playState = PlayState.won; //game won
      game.world.removeAll(game.world.children.query<Ball>());
      game.world.removeAll(game.world.children.query<Bat>());
    }
  }
}

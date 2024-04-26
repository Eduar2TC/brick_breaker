import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../screens/levels/level_one.dart';

class PlayArea extends RectangleComponent with HasGameReference<LevelOne> {
  PlayArea()
      : super(paint: Paint()..color = const Color(0xfff2e8cf), children: [
          RectangleHitbox()
        ]); //rectangle hitbox is used to detect collisions and this involves a component

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
}

import 'package:brick_breaker/src/router.dart';
import 'package:brick_breaker/src/screens/levels/level_one.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        // Define your routes here
        'level1': (context) => GameWidget(game: LevelOne()),
        // ...
      },
      debugShowCheckedModeBanner: false,
      home: GameWidget(
        game: RouterGame(),
      ),
    ),
  );
}

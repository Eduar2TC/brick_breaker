import 'dart:async';
import 'dart:math' as math;
import 'package:brick_breaker/src/components/audio.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'components/brick.dart';
import 'components/components.dart';
import 'config.dart';

enum PlayState { welcome, countDown, playing, won, gameOver }

class BrickBreaker extends FlameGame
    with HasCollisionDetection, KeyboardEvents, TapDetector {
  BrickBreaker()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );
  final ValueNotifier<int> score = ValueNotifier(0); //score game

  double get width => size.x; // size is inherited from FlameGame
  double get height => size.y; // size is inherited from FlameGame
  final rand = math.Random();
  late PlayState _playState; // State of the game
  PlayState get playState => _playState;

  set playState(PlayState playState) {
    _playState = playState;
    switch (playState) {
      case PlayState.welcome:
      case PlayState.gameOver:
        gameOver();
      case PlayState.won:
        overlays.add(playState.name);
      case PlayState.playing:
        overlays.remove(PlayState.welcome.name);
        overlays.remove(PlayState.gameOver.name);
        overlays.remove(PlayState.won.name);
      case PlayState.countDown:
        overlays.remove(PlayState.welcome.name);
        overlays.add(PlayState.countDown.name);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(PlayArea());

    playState = PlayState.welcome;

    //debugMode = true; // show hitboxes
  }

  //init game
  Future<void> startGame() async {
    if (playState == PlayState.playing) return;

    //remove all components game over statw
    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Bat>());
    world.removeAll(world.children.query<Brick>());

    playState = PlayState.countDown;
    playState = PlayState.playing;
    score.value = 0;

    //add the bat
    world.add(
      Bat(
        size: Vector2(batWidth, batHeight),
        cornerRadius: const Radius.circular(ballRadius / 2),
        position: Vector2(width / 2, height * 0.95),
      ),
    );
    //generate the bricks
    // world.addAll([
    //   for (var i = 0; i < colors.length; i++)
    //     for (var j = 1; j <= 5; j++)
    //       Brick(
    //         Vector2(
    //           (i + 0.5) * brickWidth + (i + 1) * brickGutter,
    //           (j + 2.0) * brickHeight + (j + 1) * brickGutter,
    //         ),
    //         colors[i],
    //       ),
    // ]);
    //progressive generation of bricks
    for (var i = 0; i < colors.length; i++) {
      for (var j = 1; j <= 5; j++) {
        Brick brick = Brick(
          Vector2(
            (i + 0.5) * brickWidth + (i + 1) * brickGutter,
            (j + 2.0) * brickHeight + (j + 1) * brickGutter,
          ),
          colors[i],
        );
        world.add(brick);
        await Future.delayed(
            const Duration(milliseconds: 30)); // Add delay here
      }
    }

    //delay to start the game
    Future.delayed(const Duration(milliseconds: 4500), () {
      world.add(
        Ball(
          radius: ballRadius,
          position:
              size / 2, //size is the zise of the game screen (width, height)
          velocity: Vector2((rand.nextDouble() - 0.5) * width, -height * 0.2)
              .normalized()
            ..scale(height / 4),
          difficultyModifier: difficultyModifier,
        ),
      );
      //remove overlay count down
      overlays.remove(PlayState.countDown.name);
    });

    //BrickBreakerAudio.playBackgroundMusic();
  }

  @override
  void onTap() {
    super.onTap();
    startGame();
  }

  //remove all components ui game over state
  void gameOver() {
    world.removeAll(world.children.query<Ball>());
    world.removeAll(world.children.query<Bat>());
    world.removeAll(world.children.query<Brick>());
    overlays.add(playState.name);
    if (playState == PlayState.gameOver) {
      BrickBreakerAudio.gameOver();
    }
  }

  //keyboard events
  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);
    switch (event.logicalKey) {
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Bat>().first.moveBy(-batStep);
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Bat>().first.moveBy(batStep);
      //init game with keyboard
      case LogicalKeyboardKey.space:
      case LogicalKeyboardKey.enter:
        startGame();
    }
    return KeyEventResult.handled;
  }

  // @override
  //Color backgroundColor() => const Color(0xfff2e8cf);
}

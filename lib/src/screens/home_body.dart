import 'package:brick_breaker/src/screens/levels/level_one.dart';
import 'package:brick_breaker/src/widgets/background/starry_background.dart';
import 'package:brick_breaker/src/widgets/logo/logo_animation.dart';
import 'package:brick_breaker/src/widgets/overlays/overlay_counter.dart';
import 'package:brick_breaker/src/widgets/overlays/overlay_screen.dart';
import 'package:brick_breaker/src/widgets/score_card.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config.dart';
import 'levels.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.level,
  });
  final LevelOne level;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.pressStart2pTextTheme()
            .apply(
              bodyColor: const Color(0xff184e77),
              displayColor: const Color(0xff184e77),
            )
            .copyWith(
              headlineLarge: GoogleFonts.pressStart2p(
                fontSize: 35,
                color: const Color(0xff184e77),
              ),
            ),
      ),
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffa9d6e5),
                Color(0xfff2e8cf),
              ],
            ),
          ),
          child: CustomPaint(
            painter: StarryBackground(),
            child: GestureDetector(
              onTap: () {
                level.overlays.add('levels');
              },
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Column(
                      children: [
                        ScoreCard(score: level.score),
                        Expanded(
                          child: FittedBox(
                            child: SizedBox(
                              width: gameWidth,
                              height: gameHeight,
                              child: GameWidget(
                                game: level,
                                overlayBuilderMap: {
                                  PlayState.welcome.name: (context, game) =>
                                      const Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          LogoAnimation(),
                                          OverlayScreen(
                                            title: 'TAP TO PLAY',
                                            subtitle: 'Use arrow keys or swipe',
                                          ),
                                        ],
                                      ),
                                  PlayState.gameOver.name: (context, game) =>
                                      const Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          LogoAnimation(),
                                          OverlayScreen(
                                            title: 'G A M E   O V E R',
                                            subtitle: 'Tap to Play Again',
                                          )
                                        ],
                                      ),
                                  PlayState.won.name: (context, game) =>
                                      const OverlayScreen(
                                        title: 'Y O U   W O N ! ! !',
                                        subtitle: 'Tap to Play Again',
                                      ),
                                  PlayState.countDown.name: (context, game) =>
                                      const OverlayCounter(),
                                  'levels': (context, game) =>
                                      Levels(level: level),
                                  'level1': (context, game) =>
                                      GameWidget(game: LevelOne()),
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), // To here.
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

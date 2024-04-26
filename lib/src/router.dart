import 'package:brick_breaker/src/screens/home.dart';
import 'package:brick_breaker/src/screens/levels/level_one.dart';
import 'package:flame/game.dart';

class RouterGame extends FlameGame {
  late final RouterComponent router;
  @override
  Future<void> onLoad() async {
    add(
      router = RouterComponent(
        routes: {
          'home': OverlayRoute(
            (context, game) {
              return const Home();
            },
          ),
          //'levels': OverlayRoute((context, game) => const Levels(level: ,)),
          'level1': Route(LevelOne.new), // OverlayRoute
        },
        initialRoute: 'home',
      ),
    );
  }
}

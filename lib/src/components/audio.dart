import 'package:flame_audio/flame_audio.dart';

class BrickBreakerAudio {
  static const String backgroundMusic = 'Good-Morning-Doctor-Weird.mp3';
  static const String brickHitSound = 'explosion.wav';
  static const String paddleHitSound = 'paddle_hit_sound.mp3';
  static const String gameOverSound = 'lost2.wav';
  static const String hitWithBat = 'hit_bat.wav';
  static const String hitWithArea = 'hit_area.wav';

  static void initialize() {
    FlameAudio.audioCache.loadAll([
      backgroundMusic,
      brickHitSound,
      paddleHitSound,
    ]);
  }

  static void playBackgroundMusic() {
    FlameAudio.bgm.audioPlayer.setVolume(0.05);
    FlameAudio.bgm.play(backgroundMusic);
  }

  static void playBrickHitSound() {
    FlameAudio.play(brickHitSound);
  }

  static void playPaddleHitSound() {
    FlameAudio.play(paddleHitSound);
  }

  static void stopBackgroundMusic() {
    FlameAudio.bgm.stop();
  }

  static void gameOver() {
    FlameAudio.play(gameOverSound);
  }

  static void playHitWithBat() {
    FlameAudio.play(hitWithBat);
  }

  static void playHitWithArea() {
    FlameAudio.play(hitWithArea);
  }
}

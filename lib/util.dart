import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

class Debug {
  static final bool debug = true;
  static void log(String msg) {
    if (debug) {
      print(". DEBUG     ");
      print( "  \"" + msg + "\"");
      print (" ");
    }
  }
}

class AppPresence {
  AppPresence._();

  static const _primaryColor = 0xFFFF6B35;
  static void custom(String message) {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: '$message',
        primaryColor: _primaryColor,
      ),
    );
  }
  static void studying(String timeLeft) {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: '$timeLeft | Studying 📚',
        primaryColor: _primaryColor,
      ),
    );
  }

  static void onBreak() {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: 'Just Study | On Break ☕',
        primaryColor: _primaryColor,
      ),
    );
  }

  static void idle() {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: 'JustStudy | Idle ',
        primaryColor: _primaryColor,
      ),
    );
  }
}


class AppSounds {
  AppSounds._();

  static final _player = AudioPlayer();

  static Future<void> studyStart() =>
      _play('sounds/start.wav');

  static Future<void> breakStart() =>
      _play('sounds/end.wav');

  static Future<void> _play(String path) async {
    await _player.stop();
    await _player.play(AssetSource(path));
  }
}
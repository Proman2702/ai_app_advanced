import 'dart:developer';
import 'dart:ui';

import 'package:ai_app/repositories/audio/storage.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

class SoundPlayer {
  FlutterSoundPlayer? audioPlayer;
  String? audioPath;

  bool get isPlaying => audioPlayer!.isPlaying;

  Future init() async {
    audioPlayer = FlutterSoundPlayer();

    try {
      audioPath = await Storage().completePath();
    } catch (e) {
      log('Ошибка $e');
    }

    await audioPlayer!.openAudioSession();
  }

  void dispose() {
    audioPlayer!.closeAudioSession();
    audioPlayer = null;
  }

  Future play(VoidCallback whenFinished) async {
    try {
      await audioPlayer!.startPlayer(fromURI: audioPath!, whenFinished: whenFinished);
    } on Exception catch (e) {
      log("Ошибка $e");
      // TODO
    }
  }

  Future stop() async {
    await audioPlayer!.stopPlayer();
  }

  Future togglePlaying({required VoidCallback whenFinished}) async {
    if (audioPlayer!.isStopped) {
      await play(whenFinished);
    } else {
      await stop();
    }
  }
}

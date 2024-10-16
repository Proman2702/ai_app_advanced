import 'dart:ui';

import 'package:flutter_sound_lite/flutter_sound.dart';

final audioPath = 'audio.aac';

class SoundPlayer {
  FlutterSoundPlayer? audioPlayer;

  bool get isPlaying => audioPlayer!.isPlaying;

  Future init() async {
    audioPlayer = FlutterSoundPlayer();

    await audioPlayer!.openAudioSession();
  }

  void dispose() {
    audioPlayer!.closeAudioSession();
    audioPlayer = null;
  }

  Future play(VoidCallback whenFinished) async {
    await audioPlayer!.startPlayer(fromURI: audioPath, whenFinished: whenFinished);
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

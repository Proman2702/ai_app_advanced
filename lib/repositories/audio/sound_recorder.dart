import 'dart:developer';

import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ai_app/repositories/audio/storage.dart';

class SoundRecorder {
  FlutterSoundRecorder? audioRecorder;
  bool isRecorderInit = false;
  String? audioPath;

  bool get isRecording => audioRecorder!.isRecording;

  Future init() async {
    log("init sound");
    audioRecorder = FlutterSoundRecorder();

    final statusMic = await Permission.microphone.request();
    if (statusMic != PermissionStatus.granted) {
      throw RecordingPermissionException('microphone permission');
    }
    final statusStorage = await Permission.storage.status;
    if (!statusStorage.isGranted) {
      await Permission.storage.request();
    }

    log("До audioPath");

    try {
      audioPath = await Storage().completePath();
    } catch (e) {
      log('Ошибка $e');
    }

    log("После audioPath $audioPath");

    await audioRecorder!.openAudioSession();
    isRecorderInit = true;
  }

  void dispose() {
    if (!isRecorderInit) {
      return;
    }

    audioRecorder!.closeAudioSession();
    audioRecorder = null;
    isRecorderInit = false;
  }

  Future<void> record() async {
    if (!isRecorderInit) {
      return;
    }
    await audioRecorder!.openAudioSession();
    await audioRecorder!.startRecorder(toFile: audioPath);
  }

  Future<void> stop() async {
    if (!isRecorderInit) {
      return;
    }

    await audioRecorder!.stopRecorder();
    audioRecorder!.closeAudioSession();
  }

  Future toggleRecording() async {
    if (audioRecorder!.isStopped) {
      await record();
    } else {
      await stop();
    }
  }
}

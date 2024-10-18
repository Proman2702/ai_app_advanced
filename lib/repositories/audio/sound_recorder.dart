import 'dart:developer';

import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ai_app/repositories/audio/storage.dart';

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  String? _audioPath;

  // Проверка, включен ли диктофон
  bool get isRecording => _audioRecorder!.isRecording;

  // Инициализация диктофона
  Future init() async {
    _audioRecorder = FlutterSoundRecorder();

    final statusMic = await Permission.storage.status;
    if (!statusMic.isGranted) {
      await Permission.microphone.request();
    }
    final statusStorage = await Permission.storage.status;
    if (!statusStorage.isGranted) {
      await Permission.storage.request();
    }

    try {
      _audioPath = await Storage().completePath();
    } catch (e) {
      log('<SoundRecorder> Ошибка $e');
    }

    log("<SoundRecorder> Путь к аудио: $_audioPath");

    await _audioRecorder!.openAudioSession();
  }

  // Выключение диктофона при выходе
  void dispose() {
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
  }

  // Локальный метод запуска диктофона
  Future<void> _record() async {
    await _audioRecorder!.openAudioSession();
    await _audioRecorder!.startRecorder(toFile: _audioPath);
  }

  // Локальный метод остановки диктофона
  Future<void> _stop() async {
    await _audioRecorder!.stopRecorder();
    _audioRecorder!.closeAudioSession();
  }

  // Включение/отключение диктофона
  Future<void> toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}

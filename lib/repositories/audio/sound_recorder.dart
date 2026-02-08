import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

import 'audio_storage.dart';

class SoundRecorderService {
  final AudioStorage storage;
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  bool _inited = false;
  String? _path;

  SoundRecorderService(this.storage);

  bool get isRecording => _inited && _recorder.isRecording;

  Future<void> init() async {
    if (_inited) return;

    final mic = await Permission.microphone.request();
    if (!mic.isGranted) {
      throw Exception('Нет доступа к микрофону');
    }

    _path = await storage.getPath();
    await _recorder.openAudioSession();

    _inited = true;
  }

  Future<void> dispose() async {
    if (!_inited) return;
    await _recorder.closeAudioSession();
    _inited = false;
  }

  Future<void> start() async {
    if (!_inited) throw Exception('Recorder не инициализирован (init не вызван)');
    await _recorder.startRecorder(toFile: _path);
  }

  Future<void> stop() async {
    if (!_inited) return;
    if (_recorder.isRecording) {
      await _recorder.stopRecorder();
    }
  }

  Future<void> toggle() async {
    if (isRecording) {
      await stop();
    } else {
      await start();
    }
  }
}

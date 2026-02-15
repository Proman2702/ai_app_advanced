import 'package:ai_app/etc/error_presentation/failures/audio_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:ai_app/repositories/audio/audio_guard.dart';
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

  Future<Result> init() async {
    if (_inited) return const Ok(Unit());

    final mic = await Permission.microphone.request();
    final bool micGranted = mic.isGranted;

    if (!micGranted) {
      return Err(AudioFailure(AudioFailureType.permissionDenied));
    }

    return AudioGuard.audioGuard(() async {
      await _recorder.openAudioSession();
      _inited = true;
    });
  }

  Future<void> dispose() async {
    if (!_inited) return;
    await _recorder.closeAudioSession();
    _inited = false;
  }

  Future<Unit> _start() async {
    _path = await storage.getPathWithCreating();
    await _recorder.startRecorder(toFile: _path);
    return const Unit();
  }

  Future<Unit> _stop() async {
    await _recorder.stopRecorder();
    return const Unit();
  }

  Future<Result> toggle() async {
    if (!_inited) return Err(AudioFailure(AudioFailureType.unknown));
    if (isRecording) {
      return AudioGuard.audioGuard(_stop);
    } else {
      return AudioGuard.audioGuard(_start);
    }
  }
}

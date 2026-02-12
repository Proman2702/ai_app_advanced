import 'package:ai_app/etc/error_presentation/failures/audio_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:ai_app/repositories/audio/failure.dart';
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
    if (_inited) return Ok(null);

    final mic = await Permission.microphone.request();
    final bool _micGranted = mic.isGranted;

    if (!_micGranted) {
      return Err(AudioFailure(AudioFailureType.permissionDenied));
    }

    return storage.audioGuard(() async {
      await _recorder.openAudioSession();
      _inited = true;
    });
  }

  Future<void> dispose() async {
    if (!_inited) return;
    await _recorder.closeAudioSession();
    _inited = false;
  }

  Future<void> _start() async {
    _path = await storage.getPathWithCreating();
    await _recorder.startRecorder(toFile: _path);
  }

  Future<void> _stop() async {
    await _recorder.stopRecorder();
  }

  Future<Result> toggle() async {
    if (!_inited) return Err(AudioFailure(AudioFailureType.unknown));
    if (isRecording) {
      return storage.audioGuard(_stop);
    } else {
      return storage.audioGuard(_start);
    }
  }
}

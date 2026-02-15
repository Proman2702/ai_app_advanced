import 'package:ai_app/etc/error_presentation/failures/audio_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:ai_app/repositories/audio/audio_guard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

import 'audio_storage.dart';

class SoundPlayerService {
  final AudioStorage storage;
  final FlutterSoundPlayer _player = FlutterSoundPlayer();

  bool _inited = false;
  String? _path;

  SoundPlayerService(this.storage);

  bool get isPlaying => _inited && _player.isPlaying;

  Future<Result> init() async {
    if (_inited) return const Ok(Unit());

    return AudioGuard.audioGuard(() async {
      await _player.openAudioSession();
      _inited = true;
    });
  }

  Future<void> dispose() async {
    if (!_inited) return;
    await _player.closeAudioSession();
    _inited = false;
  }

  Future<void> _play({VoidCallback? onFinished}) async {
    _path = await storage.getPath();

    await _player.startPlayer(
      fromURI: _path,
      whenFinished: onFinished,
    );
  }

  Future<void> _stop() async {
    await _player.stopPlayer();
  }

  Future<Result> toggle({VoidCallback? onFinished}) async {
    if (!_inited) return Err(AudioFailure(AudioFailureType.unknown));

    if (_player.isStopped) {
      return AudioGuard.audioGuard(() async {
        await _play(onFinished: onFinished);
        return const Unit();
      });
    } else {
      return AudioGuard.audioGuard(() async {
        await _stop();
        return const Unit();
      });
    }
  }
}

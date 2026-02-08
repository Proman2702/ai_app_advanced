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

  Future<void> init() async {
    if (_inited) return;

    _path = await storage.getPath();
    await _player.openAudioSession();

    _inited = true;
  }

  Future<void> dispose() async {
    if (!_inited) return;
    await _player.closeAudioSession();
    _inited = false;
  }

  Future<void> play({VoidCallback? onFinished}) async {
    if (!_inited) throw Exception('Player не инициализирован (init не вызван)');

    await _player.startPlayer(
      fromURI: _path,
      whenFinished: onFinished,
    );
  }

  Future<void> stop() async {
    if (!_inited) return;
    await _player.stopPlayer();
  }

  Future<void> toggle({VoidCallback? onFinished}) async {
    if (!_inited) throw Exception('Player не инициализирован (init не вызван)');

    if (_player.isStopped) {
      await play(onFinished: onFinished);
    } else {
      await stop();
    }
  }
}

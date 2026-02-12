import 'dart:io';
import 'package:ai_app/etc/error_presentation/failures/audio_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:ai_app/repositories/audio/failure.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class AudioStorage {
  final String _fileName;

  AudioStorage({String fileName = 'audio.wav'}) : _fileName = fileName;

  Future<String> getPathWithCreating() async {
    final dir = await getApplicationDocumentsDirectory();
    final recordsDir = Directory(p.join(dir.path, 'records'));
    await recordsDir.create(recursive: true);

    return p.join(recordsDir.path, _fileName);
  }

  Future<String> getPath() async {
    final dir = await getApplicationDocumentsDirectory();
    final recordsDir = Directory(p.join(dir.path, 'records'));
    return p.join(recordsDir.path, _fileName);
  }

  Future<Result<T>> audioGuard<T>(Future<T> Function() action) async {
    try {
      final v = await action();
      return Ok(v);
    } on FileSystemException catch (e) {
      return Err(AudioFailure(AudioFailureType.io, st: e.toString()));
    } on PlatformException catch (e) {
      final type =
          e.code.toLowerCase().contains('permission') ? AudioFailureType.permissionDenied : AudioFailureType.unknown;
      return Err(AudioFailure(type));
    } on UnsupportedError catch (e) {
      return Err(AudioFailure(AudioFailureType.notSupported, st: e.toString()));
    } catch (e) {
      return Err(AudioFailure(AudioFailureType.unknown, st: e.toString()));
    }
  }
}

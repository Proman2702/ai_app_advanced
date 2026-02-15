import 'dart:io';

import 'package:ai_app/etc/error_presentation/failures/audio_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:flutter/services.dart';

class AudioGuard {
  static Future<Result<T>> audioGuard<T>(Future<T> Function() action) async {
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

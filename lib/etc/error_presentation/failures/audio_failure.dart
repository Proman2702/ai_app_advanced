import 'package:ai_app/etc/error_presentation/failure.dart';

final class AudioFailure extends Failure {
  final AudioFailureType _type;
  final String? _message;
  AudioFailure(this._type, {String? message}) : _message = message;

  @override
  String get messageKey => switch (_type) {
        AudioFailureType.permissionDenied => 'audio_no_permission',
        _ => 'auth_error_generic',
      };

  @override
  String? get st => _message;
}

enum AudioFailureType {
  notSupported,
  sourceFileMissing,
  permissionDenied,
  io,
  unknown,
}

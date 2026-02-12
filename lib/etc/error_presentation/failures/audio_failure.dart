import 'package:ai_app/etc/error_presentation/failure.dart';
import 'package:ai_app/repositories/audio/failure.dart';

final class AudioFailure extends Failure {
  final AudioFailureType _type;
  final String? _st;
  AudioFailure(this._type, {String? st}) : _st = st;

  @override
  String get messageKey => switch (_type) {
        AudioFailureType.permissionDenied => 'audio_no_permission',
        _ => 'auth_error_generic',
      };

  @override
  String? get st => _st;
}

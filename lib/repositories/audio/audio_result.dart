import 'package:ai_app/repositories/audio/audio_failure.dart';

class AudioResult<T> {
  final T? data;
  final AudioFailure? error;

  const AudioResult.success(this.data) : error = null;
  const AudioResult.failure(this.error) : data = null;

  bool get isSuccess => error == null;
}

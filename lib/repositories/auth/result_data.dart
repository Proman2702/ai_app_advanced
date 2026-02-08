import 'package:ai_app/repositories/auth/failure.dart';

class Result<T> {
  final T? data;
  final AuthFailure? error;

  Result.ok(T value)
      : data = value,
        error = null;

  Result.err(AuthFailure e)
      : data = null,
        error = e;

  bool get isOk => error == null;
}

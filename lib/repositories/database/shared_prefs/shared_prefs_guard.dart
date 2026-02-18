import 'package:ai_app/etc/error_presentation/failures/shared_prefs_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';

class SharedPrefsGuard {
  static Future<Result<T>> sharedPrefsGuard<T>(Future<T> Function() action) async {
    try {
      final v = await action();
      return Ok(v);
    } catch (e) {
      return Err(SharedPrefsFailure(SharedPrefsFailureType.unknown, message: e.toString()));
    }
  }
}

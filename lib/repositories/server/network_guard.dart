import 'package:ai_app/etc/error_presentation/failures/net_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:dio/dio.dart' show DioException;

class NetworkGuard {
  static Future<Result<T>> networkGuard<T>(Future<T> Function() action) async {
    try {
      final v = await action();
      return Ok(v);
    } on DioException catch (e) {
      final code = e.response?.statusCode;
      final body = e.response?.data;
      return Err(NetworkFailure(
        NetworkFailureType.http,
        message: 'HTTP $code: $body',
      ));
    } catch (e) {
      return Err(NetworkFailure(NetworkFailureType.unknown, message: e.toString()));
    }
  }
}

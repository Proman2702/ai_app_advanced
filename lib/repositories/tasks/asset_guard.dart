import 'package:ai_app/etc/error_presentation/failures/asset_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:flutter/foundation.dart' show FlutterError;

class AssetGuard {
  static Future<Result<T>> assetGuard<T>(Future<T> Function() action) async {
    try {
      final v = await action();
      return Ok(v);
    } on FlutterError catch (e) {
      return Err(AssetFailure(AssetFailureType.unable, message: e.toString()));
    } catch (e) {
      return Err(AssetFailure(AssetFailureType.unknown, message: e.toString()));
    }
  }
}

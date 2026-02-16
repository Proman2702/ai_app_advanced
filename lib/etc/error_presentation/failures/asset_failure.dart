import 'package:ai_app/etc/error_presentation/failure.dart';

final class AssetFailure extends Failure {
  final AssetFailureType _type;
  final String? _message;
  AssetFailure(this._type, {String? message}) : _message = message;

  @override
  String get messageKey => switch (_type) {
        AssetFailureType.unable => 'not_found',
        _ => 'auth_error_generic',
      };

  @override
  String? get st => _message;
}

enum AssetFailureType { unable, unknown }

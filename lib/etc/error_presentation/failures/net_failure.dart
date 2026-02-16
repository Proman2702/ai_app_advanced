import 'package:ai_app/etc/error_presentation/failure.dart';

final class NetworkFailure extends Failure {
  final NetworkFailureType _type;
  final String? _message;
  NetworkFailure(this._type, {String? message}) : _message = message;

  @override
  String get messageKey => switch (_type) {
        NetworkFailureType.notFound => 'not_found',
        _ => 'auth_error_generic',
      };

  @override
  String? get st => _message;
}

enum NetworkFailureType { notFound, forbidden, unknown, http }

import 'package:ai_app/etc/error_presentation/failure.dart';

final class DatabaseFailure extends Failure {
  final DatabaseFailureType _type;
  final String? _message;
  DatabaseFailure(this._type, {String? message}) : _message = message;

  @override
  String get messageKey => switch (_type) {
        DatabaseFailureType.permissionDenied => 'read_no_permission',
        _ => 'auth_error_generic',
      };

  @override
  String? get st => _message;
}

enum DatabaseFailureType {
  permissionDenied,
  unauthenticated,
  notFound,
  unavailable,
  invalidArgument,
  unknown,
}

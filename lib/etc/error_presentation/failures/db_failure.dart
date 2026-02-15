import 'package:ai_app/etc/error_presentation/failure.dart';

final class DatabaseFailure extends Failure {
  final DatabaseFailureType _type;
  final String? _st;
  DatabaseFailure(this._type, {String? st}) : _st = st;

  @override
  String get messageKey => switch (_type) {
        DatabaseFailureType.permissionDenied => 'read_no_permission',
        _ => 'auth_error_generic',
      };

  @override
  String? get st => _st;
}

enum DatabaseFailureType {
  permissionDenied,
  unauthenticated,
  notFound,
  unavailable,
  invalidArgument,
  unknown,
}

import 'package:ai_app/etc/error_presentation/failure.dart';
import 'package:ai_app/repositories/auth/failure.dart';

final class AuthFailure extends Failure {
  final AuthFailureType _type;
  final String? _st;
  AuthFailure(this._type, {String? st}) : _st = st;

  @override
  String get messageKey => switch (_type) {
        AuthFailureType.requiresLogin => 'auth_req_l',
        _ => 'auth_error_generic',
      };

  @override
  String? get st => _st;
}

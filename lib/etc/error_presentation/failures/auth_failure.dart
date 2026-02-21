import 'package:ai_app/etc/error_presentation/failure.dart';

class AuthFailure extends Failure {
  final AuthFailureType _type;
  final String? _message;
  AuthFailure(this._type, {String? message}) : _message = message;

  @override
  String get messageKey => switch (_type) {
        AuthFailureType.requiresLogin => 'auth_req_l',
        _ => 'auth_error_generic',
      };

  @override
  String? get message => _message;
}

enum AuthFailureType { format, exists, weak, notFound, wrong, wrongOrNotFound, requiresLogin, unknown, unauthorized }

import 'package:ai_app/repositories/auth/failure.dart';

abstract interface class Failure {
  String get code;
  String get messageKey;
}

final class AuthFailure extends Failure {
  final AuthFailureType type;
  AuthFailure(this.type);

  @override
  String get code => 'auth/${type.name}';

  @override
  String get messageKey => switch (type) {
        AuthFailureType.requiresLogin => 'auth_requires_login',
        AuthFailureType.wrongOrNotFound => 'auth_wrong_or_not_found',
        _ => 'auth_error_generic',
      };
}

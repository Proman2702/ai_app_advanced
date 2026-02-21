import 'package:ai_app/etc/error_presentation/failure.dart';

final class SharedPrefsFailure extends Failure {
  final SharedPrefsFailureType _type;
  final String? _message;
  SharedPrefsFailure(this._type, {String? message}) : _message = message;

  @override
  String get messageKey => switch (_type) {
        SharedPrefsFailureType.notFound => 'not_found',
        _ => 'auth_error_generic',
      };

  @override
  String? get message => _message;
}

enum SharedPrefsFailureType { notFound, unknown }

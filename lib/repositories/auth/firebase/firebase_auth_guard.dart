import 'package:ai_app/etc/error_presentation/failures/auth_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;

class FirebaseAuthGuard {
  static Future<Result<T>> firebaseAuthGuard<T>(Future<T> Function() action) async {
    try {
      final v = await action();
      return Ok(v);
    } on FirebaseAuthException catch (e) {
      return Err(_mapFirebaseError(e));
    } catch (e) {
      return Err(AuthFailure(AuthFailureType.unknown, message: e.toString()));
    }
  }

  static AuthFailure _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return AuthFailure(AuthFailureType.format, message: e.message);

      case 'email-already-in-use':
        return AuthFailure(AuthFailureType.exists, message: e.message);

      case 'weak-password':
        return AuthFailure(AuthFailureType.weak, message: e.message);

      case 'user-not-found':
        return AuthFailure(AuthFailureType.notFound, message: e.message);

      case 'wrong-password':
        return AuthFailure(AuthFailureType.wrong, message: e.message);

      case 'invalid-credential':
        return AuthFailure(AuthFailureType.wrongOrNotFound, message: e.message);

      case 'requires-recent-login':
        return AuthFailure(AuthFailureType.requiresLogin, message: e.message);

      default:
        return AuthFailure(AuthFailureType.unknown, message: e.message);
    }
  }
}

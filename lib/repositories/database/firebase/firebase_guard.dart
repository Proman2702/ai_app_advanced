import 'package:ai_app/etc/error_presentation/failures/db_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseException;

class FirebaseDatabaseGuard {
  static Future<Result<T>> firebaseDatabaseGuard<T>(Future<T> Function() action) async {
    try {
      final v = await action();
      return Ok(v);
    } on FirebaseException catch (e) {
      return Err(_mapDatabaseError(e));
    } catch (e) {
      return Err(DatabaseFailure(DatabaseFailureType.unknown, st: e.toString()));
    }
  }

  static DatabaseFailure _mapDatabaseError(FirebaseException e) {
    switch (e.code) {
      case 'permission-denied':
        return DatabaseFailure(DatabaseFailureType.permissionDenied, st: e.message);
      case 'unauthenticated':
        return DatabaseFailure(DatabaseFailureType.unauthenticated, st: e.message);
      case 'not-found':
        return DatabaseFailure(DatabaseFailureType.notFound, st: e.message);
      case 'unavailable':
        return DatabaseFailure(DatabaseFailureType.unavailable, st: e.message);
      case 'invalid-argument':
        return DatabaseFailure(DatabaseFailureType.invalidArgument, st: e.message);
      default:
        return DatabaseFailure(DatabaseFailureType.unknown, st: e.message);
    }
  }
}

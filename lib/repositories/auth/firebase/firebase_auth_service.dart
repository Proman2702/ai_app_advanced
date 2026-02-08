import 'package:ai_app/repositories/auth/auth_service.dart';
import 'package:ai_app/repositories/auth/auth_user.dart';
import 'package:ai_app/repositories/auth/failure.dart';
import 'package:ai_app/repositories/auth/result_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements AuthService {
  final FirebaseAuth _auth;

  FirebaseAuthService(this._auth);

  // ЧТОБЫ ИЗМЕНЯЛСЯ И НОРМАЛЬНЫЙ ДАТА ЮЗЕР
  @override
  Stream<AuthUser?> authStateChanges() {
    return _auth.authStateChanges().map((User? user) {
      return user?.toAuthUser();
    });
  }

  // ВНУТРЕННЯЯ РЕАУТЕНТИФИКАЦИЯ
  Future<void> _reauthWithPassword(User user, String email, String password) async {
    final cred = EmailAuthProvider.credential(
      email: email,
      password: password,
    );
    await user.reauthenticateWithCredential(cred);
  }

  // СМЕНА ПАРОЛЯ
  @override
  Future<Result<void>> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      return Result.err(AuthFailure.requiresLogin);
    }

    try {
      await _reauthWithPassword(user, email, currentPassword);
      await user.updatePassword(newPassword);

      return Result.ok(null);
    } on FirebaseAuthException catch (e) {
      return Result.err(_mapFirebaseError(e));
    } catch (e) {
      return Result.err(AuthFailure.unknown);
    }
  }

  // УДАЛЕНИЕ АККАУНТА
  @override
  Future<Result<void>> deleteAccount({
    required String email,
    required String password,
  }) async {
    final user = _auth.currentUser;
    if (user == null) {
      return Result.err(AuthFailure.requiresLogin);
    }

    try {
      await _reauthWithPassword(user, email, password);

      await user.delete();

      return Result.ok(null);
    } on FirebaseAuthException catch (e) {
      return Result.err(_mapFirebaseError(e));
    } catch (e) {
      return Result.err(AuthFailure.unknown);
    }
  }

  // СБРОС ПАРОЛЯ
  @override
  Future<Result<void>> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Result.ok(null);
    } on FirebaseAuthException catch (e) {
      return Result.err(_mapFirebaseError(e));
    } catch (e) {
      return Result.err(AuthFailure.unknown);
    }
  }

  // ВОЙТИ
  @override
  Future<Result<AuthUser>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;
      if (user == null) {
        return Result.err(AuthFailure.unknown);
      }

      return Result.ok(user.toAuthUser());
    } on FirebaseAuthException catch (e) {
      return Result.err(_mapFirebaseError(e));
    } catch (e) {
      return Result.err(AuthFailure.unknown);
    }
  }

  // ВЫЙТИ
  @override
  Future<Result<void>> signOut() async {
    try {
      await _auth.signOut();
      return Result.ok(null);
    } catch (e) {
      return Result.err(AuthFailure.unknown);
    }
  }

  // ЗАРЕГИСТРИРОВАТЬСЯ
  @override
  Future<Result<AuthUser>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;
      if (user == null) {
        return Result.err(AuthFailure.unknown);
      }

      return Result.ok(user.toAuthUser());
    } on FirebaseAuthException catch (e) {
      return Result.err(_mapFirebaseError(e));
    } catch (e) {
      return Result.err(AuthFailure.unknown);
    }
  }

  @override
  Future<Result<void>> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) {
      return Result.err(AuthFailure.requiresLogin);
    }

    try {
      await user.sendEmailVerification();
      return Result.ok(null);
    } on FirebaseAuthException catch (e) {
      return Result.err(_mapFirebaseError(e));
    } catch (e) {
      return Result.err(AuthFailure.unknown);
    }
  }
}

AuthFailure _mapFirebaseError(FirebaseAuthException e) {
  // Подстрой имена AuthFailureType под свои, если отличаются
  switch (e.code) {
    case 'invalid-email':
      return AuthFailure.format;

    case 'email-already-in-use':
      return AuthFailure.exists;

    case 'weak-password':
      return AuthFailure.weak;

    case 'user-not-found':
      return AuthFailure.notFound;

    case 'wrong-password':
      return AuthFailure.wrong;

    case 'invalid-credential':
      return AuthFailure.wrongOrNotFound;

    case 'requires-recent-login':
      return AuthFailure.requiresLogin;

    default:
      return AuthFailure.unknown;
  }
}

extension _FirebaseUserMapper on User {
  AuthUser toAuthUser() => AuthUser(
        id: uid,
        email: email,
        isEmailVerified: emailVerified,
      );
}

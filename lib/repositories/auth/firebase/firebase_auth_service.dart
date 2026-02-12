import 'package:ai_app/etc/error_presentation/failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:ai_app/repositories/auth/auth_service.dart';
import 'package:ai_app/repositories/auth/auth_user.dart';
import 'package:ai_app/repositories/auth/failure.dart';
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
      return Err(AuthFailure(AuthFailureType.requiresLogin));
    }

    try {
      await _reauthWithPassword(user, email, currentPassword);
      await user.updatePassword(newPassword);

      return const Ok(null);
    } on FirebaseAuthException catch (e) {
      return Err(AuthFailure(_mapFirebaseError(e)));
    } catch (e) {
      return Err(AuthFailure(AuthFailureType.unknown));
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
      return Err(AuthFailure(AuthFailureType.requiresLogin));
    }

    try {
      await _reauthWithPassword(user, email, password);

      await user.delete();

      return const Ok(null);
    } on FirebaseAuthException catch (e) {
      return Err(AuthFailure(_mapFirebaseError(e)));
    } catch (e) {
      return Err(AuthFailure(AuthFailureType.unknown));
    }
  }

  // СБРОС ПАРОЛЯ
  @override
  Future<Result<void>> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Ok(null);
    } on FirebaseAuthException catch (e) {
      return Err(AuthFailure(_mapFirebaseError(e)));
    } catch (e) {
      return Err(AuthFailure(AuthFailureType.unknown));
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
        return Err(AuthFailure(AuthFailureType.unknown));
      }

      return Ok(user.toAuthUser());
    } on FirebaseAuthException catch (e) {
      return Err(AuthFailure(_mapFirebaseError(e)));
    } catch (e) {
      return Err(AuthFailure(AuthFailureType.unknown));
    }
  }

  // ВЫЙТИ
  @override
  Future<Result<void>> signOut() async {
    try {
      await _auth.signOut();
      return const Ok(null);
    } catch (e) {
      return Err(AuthFailure(AuthFailureType.unknown));
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
        return Err(AuthFailure(AuthFailureType.unknown));
      }

      return Ok(user.toAuthUser());
    } on FirebaseAuthException catch (e) {
      return Err(AuthFailure(_mapFirebaseError(e)));
    } catch (e) {
      return Err(AuthFailure(AuthFailureType.unknown));
    }
  }

  // ВЕРИФИКАЦИЯ
  @override
  Future<Result<void>> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) {
      return Err(AuthFailure(AuthFailureType.requiresLogin));
    }

    try {
      await user.sendEmailVerification();
      return const Ok(null);
    } on FirebaseAuthException catch (e) {
      return Err(AuthFailure(_mapFirebaseError(e)));
    } catch (e) {
      return Err(AuthFailure(AuthFailureType.unknown));
    }
  }
}

AuthFailureType _mapFirebaseError(FirebaseAuthException e) {
  // Подстрой имена AuthFailureType под свои, если отличаются
  switch (e.code) {
    case 'invalid-email':
      return AuthFailureType.format;

    case 'email-already-in-use':
      return AuthFailureType.exists;

    case 'weak-password':
      return AuthFailureType.weak;

    case 'user-not-found':
      return AuthFailureType.notFound;

    case 'wrong-password':
      return AuthFailureType.wrong;

    case 'invalid-credential':
      return AuthFailureType.wrongOrNotFound;

    case 'requires-recent-login':
      return AuthFailureType.requiresLogin;

    default:
      return AuthFailureType.unknown;
  }
}

extension _FirebaseUserMapper on User {
  AuthUser toAuthUser() => AuthUser(
        id: uid,
        email: email,
        isEmailVerified: emailVerified,
      );
}

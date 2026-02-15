import 'package:ai_app/etc/error_presentation/failures/auth_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:ai_app/repositories/auth/auth_service.dart';
import 'package:ai_app/repositories/auth/auth_user.dart';
import 'package:ai_app/repositories/auth/firebase/firebase_auth_guard.dart';
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
  Future<Result<Unit>> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return Err(AuthFailure(AuthFailureType.unauthorized, st: "unauthorized"));
    return FirebaseAuthGuard.firebaseAuthGuard(() async {
      await _reauthWithPassword(user, email, currentPassword);
      await user.updatePassword(newPassword);
      return const Unit();
    });
  }

  // УДАЛЕНИЕ АККАУНТА
  @override
  Future<Result<Unit>> deleteAccount({
    required String email,
    required String password,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return Err(AuthFailure(AuthFailureType.unauthorized, st: "unauthorized"));
    return FirebaseAuthGuard.firebaseAuthGuard(() async {
      await _reauthWithPassword(user, email, password);
      await user.delete();
      return const Unit();
    });
  }

  // СБРОС ПАРОЛЯ
  @override
  Future<Result<Unit>> resetPassword({required String email}) async {
    return FirebaseAuthGuard.firebaseAuthGuard(() async {
      await _auth.sendPasswordResetEmail(email: email);
      return const Unit();
    });
  }

  // ВОЙТИ
  @override
  Future<Result<AuthUser>> signIn({
    required String email,
    required String password,
  }) async {
    return FirebaseAuthGuard.firebaseAuthGuard(() async {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user == null) throw Exception("user is null");
      return user.toAuthUser();
    });
  }

  // ВЫЙТИ
  @override
  Future<Result<Unit>> signOut() async {
    return FirebaseAuthGuard.firebaseAuthGuard(() async {
      await _auth.signOut();
      return const Unit();
    });
  }

  // ЗАРЕГИСТРИРОВАТЬСЯ
  @override
  Future<Result<AuthUser>> signUp({
    required String email,
    required String password,
  }) async {
    return FirebaseAuthGuard.firebaseAuthGuard(() async {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user == null) throw Exception("user is null");
      return user.toAuthUser();
    });
  }

  // ВЕРИФИКАЦИЯ
  @override
  Future<Result<Unit>> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) return Err(AuthFailure(AuthFailureType.unauthorized, st: "unauthorized"));
    return FirebaseAuthGuard.firebaseAuthGuard(() async {
      await user.sendEmailVerification();
      return const Unit();
    });
  }
}

extension _FirebaseUserMapper on User {
  AuthUser toAuthUser() => AuthUser(
        id: uid,
        email: email,
        isEmailVerified: emailVerified,
      );
}

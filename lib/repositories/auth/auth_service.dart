import 'package:ai_app/etc/error_presentation/result.dart';
import 'auth_user.dart';

abstract interface class AuthService {
  Stream<AuthUser?> authStateChanges();

  Future<Result<AuthUser>> signUp({
    required String email,
    required String password,
  });

  Future<Result<AuthUser>> signIn({
    required String email,
    required String password,
  });

  Future<Result<Unit>> signOut();

  Future<Result<Unit>> sendEmailVerification();

  Future<Result<Unit>> resetPassword({
    required String email,
  });

  Future<Result<Unit>> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  });

  Future<Result<Unit>> deleteAccount({
    required String email,
    required String password,
  });
}

import 'package:ai_app/repositories/auth/result_data.dart';
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

  Future<Result<void>> signOut();

  Future<Result<void>> sendEmailVerification();

  Future<Result<void>> resetPassword({
    required String email,
  });

  Future<Result<void>> changePassword({
    required String email,
    required String currentPassword,
    required String newPassword,
  });

  Future<Result<void>> deleteAccount({
    required String email,
    required String password,
  });
}

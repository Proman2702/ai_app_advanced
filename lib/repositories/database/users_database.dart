import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:ai_app/etc/models/user.dart';

abstract interface class UsersDatabase {
  Future<Result<CustomUser?>> getUserById(String id);
  Future<Result<Unit>> upsertUser(CustomUser user);
  Future<Result<Unit>> deleteUserById(String id);
}

abstract interface class UsersDatabaseWithStream {}

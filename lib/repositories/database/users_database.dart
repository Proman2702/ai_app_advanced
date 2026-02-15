import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:ai_app/etc/models/user.dart';

abstract interface class UsersDatabase {
  Future<Result<CustomUser?>> getUser();
  Future<Result<Unit>> upsertUser(CustomUser user);
  Future<Result<Unit>> deleteUser();
}

abstract interface class UsersDatabaseWithStream {
  Stream<Result<List<CustomUser>>> watchUsers();
  Stream<Result<CustomUser?>> watchUser();
}

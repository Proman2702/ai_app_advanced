import 'package:ai_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String database_path = 'users';

class DatabaseService {
  final firestore = FirebaseFirestore.instance;

  late final CollectionReference usersRef;

  DatabaseService() {
    usersRef = firestore.collection(database_path).withConverter<CustomUser>(
        fromFirestore: (snapshots, _) => CustomUser.fromJson(snapshots.data()!),
        toFirestore: (user, _) => user.toJson());
  }

  // Получить данные
  Stream<QuerySnapshot> getUsers() {
    return usersRef.snapshots();
  }

  // Добавить в базу данных пользователя
  Future<void> addUser(CustomUser user) async {
    await usersRef.doc(user.email).set(user);
  }

  // Обновление данных (используются все параметры пользователя)
  Future<void> updateUser(String userId, CustomUser user) async {
    await usersRef.doc(userId).update(user.toJson());
  }

  // Удаление по почте
  Future<void> deleteUser(String email) async {
    await usersRef.doc(email).delete();
  }
}

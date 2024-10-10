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

  Stream<QuerySnapshot> getUsers() {
    return usersRef.snapshots();
  }

  void addUser(CustomUser user) async {
    usersRef.doc(user.email).set(user);
  }
}

import 'package:ai_app/etc/error_presentation/failures/db_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:ai_app/etc/models/user.dart';
import 'package:ai_app/etc/models/user_firebase.dart';
import 'package:ai_app/repositories/database/firebase/firebase_guard.dart';
import 'package:ai_app/repositories/database/users_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const String _path = 'users';

class FirebaseUsersDatabase implements UsersDatabase, UsersDatabaseWithStream {
  final FirebaseFirestore _firestore;
  late final CollectionReference<CustomUser> _usersRef;

  // В конструкоре класса создается референс к базе данных
  // Который автоматически обрабатывает входные и выходные данные
  FirebaseUsersDatabase(this._firestore) {
    _usersRef = _firestore.collection(_path).withConverter<CustomUser>(
          fromFirestore: (snap, _) {
            final data = snap.data();
            if (data == null) {
              throw StateError('${snap.id} не имеет данных');
            }
            return customUserFromFirestore(data);
          },
          toFirestore: (user, _) => customUserToFirestore(user),
        );
  }

  @override
  Future<Result<Unit>> deleteUserById(String id) async {
    return FirebaseDatabaseGuard.firebaseDatabaseGuard(() async {
      await _usersRef.doc(id).delete();
      return const Unit();
    });
  }

  @override
  Future<Result<CustomUser?>> getUserById(String id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

// TODO
//   @override
//   Future<Result<Unit>> upsertUser(CustomUser user) {

//   return firestoreGuardVoid(() async {
//     await _doc(uid).set(user, SetOptions(merge: true));
//   });
// }
//   }

  @override
  Stream<Result<CustomUser?>> watchUserById(String id) {
    // TODO: implement watchUserById
    throw UnimplementedError();
  }

  @override
  Stream<Result<List<CustomUser>>> watchUsers() {
    // TODO: implement watchUsers
    throw UnimplementedError();
  }
}

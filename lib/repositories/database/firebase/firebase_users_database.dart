import 'package:ai_app/etc/error_presentation/failures/db_failure.dart';
import 'package:ai_app/etc/error_presentation/result.dart';
import 'package:ai_app/models/user.dart';
import 'package:ai_app/models/user_firebase.dart';
import 'package:ai_app/repositories/auth/firebase/firebase_auth_gate.dart';
import 'package:ai_app/repositories/database/firebase/firebase_guard.dart';
import 'package:ai_app/repositories/database/users_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseUsersDatabase implements UsersDatabase, UsersDatabaseWithStream {
  FirebaseUsersDatabase(this._firestore, this._gate) {
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

  final FirebaseFirestore _firestore;
  final UserSessionGate _gate;

  static const String _path = 'users';
  late final CollectionReference<CustomUser> _usersRef;

  @override
  Future<Result<CustomUser?>> getUser() {
    final uid = _gate.currentUid;
    if (uid == null) return Future.value(Err(DatabaseFailure(DatabaseFailureType.unauthenticated)));

    return FirebaseDatabaseGuard.firebaseDatabaseGuard(() async {
      final snap = await _usersRef.doc(uid).get();
      return snap.data();
    });
  }

  @override
  Future<Result<Unit>> upsertUser(CustomUser user) {
    final uid = _gate.currentUid;
    if (uid == null) return Future.value(Err(DatabaseFailure(DatabaseFailureType.unauthenticated)));

    return FirebaseDatabaseGuard.firebaseDatabaseGuard(() async {
      await _usersRef.doc(uid).set(user, SetOptions(merge: true));
      return const Unit();
    });
  }

  @override
  Future<Result<Unit>> deleteUser() {
    final uid = _gate.currentUid;
    if (uid == null) return Future.value(Err(DatabaseFailure(DatabaseFailureType.unauthenticated)));

    return FirebaseDatabaseGuard.firebaseDatabaseGuard(() async {
      await _usersRef.doc(uid).delete();
      return const Unit();
    });
  }

  @override
  Stream<Result<CustomUser?>> watchUser() {
    return _gate.watchUid().startWith(_gate.currentUid).distinct().switchMap((uid) {
      if (uid == null) {
        return Stream.value(Err(DatabaseFailure(DatabaseFailureType.unauthenticated)));
      }

      final source = _usersRef.doc(uid).snapshots().map((snap) => snap.data());
      return FirebaseDatabaseGuard.firebaseStreamGuard(source);
    });
  }

  @override
  Stream<Result<List<CustomUser>>> watchUsers() {
    return _gate.watchUid().startWith(_gate.currentUid).distinct().switchMap((uid) {
      if (uid == null) return Stream.value(Err(DatabaseFailure(DatabaseFailureType.unauthenticated)));

      final source = _usersRef.snapshots().map((q) => q.docs.map((d) => d.data()).toList());
      return FirebaseDatabaseGuard.firebaseStreamGuard(source);
    });
  }

  //Stream<Result<CustomUser?>> watchUserById(String id) {
  //  final source = _usersRef.doc(id).snapshots().map((snap) => snap.data());
  //  return FirebaseDatabaseGuard.firebaseStreamGuard(source);
  //}
}

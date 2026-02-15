import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract interface class UserSessionGate {
  String? get currentUid;
  Stream<String?> watchUid();
}

class FirebaseUserSessionGate implements UserSessionGate {
  FirebaseUserSessionGate(this._auth) {
    _currentUid = _auth.currentUser?.uid;

    _sub = _auth.authStateChanges().listen((user) {
      final nextUid = user?.uid;
      if (nextUid == _currentUid) return;

      _currentUid = nextUid;
      _controller.add(_currentUid);
    });
  }

  final FirebaseAuth _auth;

  final _controller = StreamController<String?>.broadcast();
  StreamSubscription<User?>? _sub;

  String? _currentUid;

  @override
  String? get currentUid => _currentUid;

  @override
  Stream<String?> watchUid() => _controller.stream;

  void dispose() {
    _sub?.cancel();
    _controller.close();
  }
}

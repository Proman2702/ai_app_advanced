import 'dart:async';

import 'package:ai_app/repositories/auth/firebase/firebase_auth_gate.dart';
import 'package:flutter/foundation.dart';

class SessionListenable extends ChangeNotifier {
  SessionListenable(this._gate) {
    _sub = _gate.watchUid().listen((_) => notifyListeners());
  }

  final UserSessionGate _gate;
  StreamSubscription<String?>? _sub;

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

//
// Сервис для работы с аунтефикацией
// Реализованы основные функции аунтефикации
//

class AuthService {
  final auth = FirebaseAuth.instance;

  // Регистрация (е-маил, пароль)
  Future<List?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return [0, cred.user];
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return [1, 'format'];
      } else if (e.code == 'email-already-in-use') {
        return [1, 'exists'];
      } else if (e.code == 'weak-password') {
        return [1, 'weak'];
      }
    }
    return [1, 'unknown'];
  }

  // Логин (е-маил и пароль)
  Future<List> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return [0, cred.user];
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return [1, 'format'];
      } else if (e.code == 'user-not-found') {
        return [1, 'not_found'];
      } else if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return [1, 'wrong'];
      }
    }
    return [1, 'unknown'];
  }

  // Выход из сессии
  Future<void> signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      log("Ошибка $e");
    }
  }

  Future<List> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return [0];
    } on FirebaseAuthException catch (e) {
      if (e.toString() == "auth/invalid-email") return [1, 'format'];
    }
    return [1, 'unknown'];
  }
}

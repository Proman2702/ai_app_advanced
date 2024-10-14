import 'package:ai_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';


class GetValues {
  final List users;
  final User user;
  final String subject;

  GetValues({required this.subject, required this.users, required this.user});


  CustomUser? getUser() {

    for (var i in users) {
        if (i.id == user.email) {
            return i.data();
        }
  }
  return null;
  }
}
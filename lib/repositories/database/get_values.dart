import 'package:firebase_auth/firebase_auth.dart';


class GetValues {
  final List users;
  final User user;
  final String subject;

  GetValues({required this.subject, required this.users, required this.user});


  Future<dynamic> getSingle() async {
    if (users == []) {
      return 'not_found';
    } else {
      for (var i in users) {
        if (i.id == user.email) {
              return i.data().subject;
              few
          }
      }
      return 'not_found';
    } 
  }
}
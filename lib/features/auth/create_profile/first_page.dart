// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/features/auth/auth_error_hander.dart';
import 'package:ai_app/repositories/auth_service.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final auth = AuthService();

  String? username;
  String? email;
  String? password;

  void signUp(String em, String p) async {
    final user = await auth.createUserWithEmailAndPassword(em, p);

    if (user != null) {
      log("Пользователь создан");
      Navigator.of(context).pushNamed("/home", arguments: user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100),
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(width: 450),
                  child: TextField(
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black87),
                    maxLength: 25,
                    onChanged: (value) => setState(() {
                      username = value;
                    }),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.only(bottom: 12),
                      counterText: "",
                      border: InputBorder.none,
                      labelText: "Имя пользователя",
                      labelStyle: TextStyle(
                        color: Colors.black12,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(width: 450),
                  child: TextField(
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black87),
                    maxLength: 25,
                    onChanged: (value) => setState(() {
                      email = value;
                    }),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.only(bottom: 12),
                      counterText: "",
                      border: InputBorder.none,
                      labelText: "Почта",
                      labelStyle: TextStyle(
                        color: Colors.black12,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(width: 450),
                  child: TextField(
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black87),
                    maxLength: 25,
                    onChanged: (value) => setState(() {
                      password = value;
                    }),
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      contentPadding: EdgeInsets.only(bottom: 12),
                      counterText: "",
                      border: InputBorder.none,
                      labelText: "Пароль",
                      labelStyle: TextStyle(
                        color: Colors.black12,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(CustomColors.bright)),
              onPressed: () async {
                if (email == null || password == null) {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          const AuthDenySheet(type: "none"));
                } else if (email!.length < 4 || password!.length < 4) {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          AuthDenySheet(type: "length"));
                } else {
                  log("Логин: $email, пароль: $password");
                  signUp(email!, password!);
                }
              },
              child: Text(
                "Создать",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

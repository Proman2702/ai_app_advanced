// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:ai_app/features/auth/auth_error_hander.dart';
import 'package:flutter/material.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/etc/colors/colors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Container(
      decoration: BoxDecoration(gradient: BackgroundGrad()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: (height - width) > 0 ? height / 3 : height / 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Text(
                        "десептиконы",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 40,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        "AI APP",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: Color(CustomColors.bright),
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                    height: (height - width) > 0 ? height / 6.5 : height / 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 40,
                      width: 295,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Icon(
                            Icons.account_circle_outlined,
                            size: 24,
                            color: Color(CustomColors.bright),
                          ),
                          SizedBox(width: 8),
                          SizedBox(
                            width: 250,
                            height: 40,
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
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    contentPadding: EdgeInsets.only(bottom: 12),
                                    counterText: "",
                                    border: InputBorder.none,
                                    labelText: "Логин",
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
                        ],
                      ),
                    ),
                    SizedBox(height: 18),
                    Container(
                      height: 40,
                      width: 295,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Icon(
                            Icons.lock_outline,
                            size: 24,
                            color: Color(CustomColors.bright),
                          ),
                          SizedBox(width: 8),
                          SizedBox(
                            width: 250,
                            height: 40,
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
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
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
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        log("Forgot the password");
                      },
                      child: Text(
                        "Забыли пароль?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                    height: (height - width) > 0 ? height / 10 : height / 16),
                SizedBox(
                  height: 40,
                  width: 180,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(CustomColors.bright)),
                    onPressed: () async {
                      if (username == null || password == null) {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) =>
                                const AuthDenySheet(type: "none"));
                      } else if (username!.length < 4 || password!.length < 4) {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) =>
                                AuthDenySheet(type: "length"));
                      } else {
                        log("Логин: $username, пароль: $password");
                        Navigator.of(context).pushNamed("/");
                      }
                    },
                    child: Text(
                      "Войти",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    log("create an account");
                    Navigator.of(context).pushNamed("/auth/create");
                  },
                  child: Text(
                    'Создать аккаунт',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

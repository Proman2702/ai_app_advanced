// ignore_for_file: prefer_const_constructors, unused_import, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:ai_app/ui/auth/auth_formats.dart';
import 'package:ai_app/repositories/auth/firebase/firebase_auth_service.dart';
import 'package:ai_app/ui/auth/main/view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ai_app/etc/colors/colors.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthPageModel>();

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
                SizedBox(height: (height - width) > 0 ? height / 7 : height / 12),
                Container(
                  height: 140,
                  width: 140,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(75)),
                  child: Image.asset("images/icon.png",
                      scale: 4.2, opacity: const AlwaysStoppedAnimation(1), alignment: Alignment.center),
                ),
                SizedBox(height: 30),
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
                            fontWeight: FontWeight.w600, fontSize: 24, color: CustomColors.bright, letterSpacing: 2),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: (height - width) > 0 ? height / 8 : height / 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 40,
                      width: 295,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Icon(Icons.account_circle_outlined, size: 24, color: CustomColors.bright),
                          SizedBox(width: 8),
                          SizedBox(
                            width: 250,
                            height: 40,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ConstrainedBox(
                                constraints:
                                    BoxConstraints.expand(width: AuthSettings().maxEmailLength * 18), // 18 - fontSize
                                child: TextField(
                                  style:
                                      const TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black87),
                                  maxLength: AuthSettings().maxEmailLength,
                                  onChanged: (_) {},
                                  decoration: InputDecoration(
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    contentPadding: EdgeInsets.only(bottom: 12),
                                    counterText: "",
                                    border: InputBorder.none,
                                    labelText: "Почта",
                                    labelStyle:
                                        TextStyle(color: Colors.black12, fontSize: 20, fontWeight: FontWeight.w700),
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
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Icon(
                            Icons.lock_outline,
                            size: 24,
                            color: CustomColors.bright,
                          ),
                          SizedBox(width: 8),
                          SizedBox(
                            width: 210,
                            height: 40,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: ConstrainedBox(
                                constraints: BoxConstraints.expand(
                                    width: AuthSettings().maxPasswordLength * 18), // 18 - fontSize
                                child: TextField(
                                  style:
                                      const TextStyle(fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black87),
                                  maxLength: AuthSettings().maxPasswordLength,
                                  onChanged: (value) {},
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
                          IconButton(
                              iconSize: 20,
                              visualDensity: VisualDensity.compact,
                              onPressed: () {},
                              icon: Icon(Icons.abc))
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {},
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
                SizedBox(height: (height - width) > 0 ? height / 10 : height / 16),
                Container(
                  height: 40,
                  width: 180,
                  decoration: BoxDecoration(
                      gradient: ButtonGrad(),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(spreadRadius: 1, offset: Offset(0, 2), blurRadius: 2, color: Colors.black26)
                      ]),
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.transparent, shadowColor: Colors.transparent),
                    onPressed: () {},
                    child: Text(
                      "Войти",
                      style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () {},
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

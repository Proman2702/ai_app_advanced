import 'dart:developer';
import 'dart:math' as math;
import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients/background.dart';
import 'package:ai_app/etc/colors/gradients/tiles.dart';
import 'package:ai_app/features/auth/auth_error_hander.dart';
import 'package:ai_app/features/auth/email_notificator.dart';
import 'package:ai_app/models/defects.dart';
import 'package:ai_app/models/user.dart';
import 'package:ai_app/repositories/auth/auth_service.dart';
import 'package:ai_app/repositories/database/database_service.dart';
import 'package:flutter/material.dart';
import 'package:ai_app/features/auth/auth_formats.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final auth = AuthService();
  final database = DatabaseService();

  String? username;
  String? email;
  String? password;

  bool obscureBool = true;

  Map buildAuth() {
    Map defs = Defects.getAll();
    Map<String, int> newDefs = {};

    defs.forEach((i, value) {
      newDefs['$i'] = 0;
    });
    return newDefs;
  }

  void signUp(String em, String p) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(CustomColors.mainLightX2)),
            ),
          );
        });

    final user = await auth.createUserWithEmailAndPassword(em, p);
    Navigator.pop(context);

    if (user![0] == 0) {
      log("Пользователь создан");

      var pattern = buildAuth();
      log("PATTERN $pattern");

      await database.addUser(CustomUser(
          username: username!,
          email: em,
          defects: pattern, // 0 - не пройдено, 1 - нет дефекта, 2 - есть дефект
          lessons_passed: pattern,
          lessons_correct: pattern,
          current_combo: pattern,
          current_level: pattern));

      Navigator.of(context).pushNamed('/');
      await auth.sendVerification();
      showDialog(context: context, builder: (BuildContext context) => const EmailNotificator(type: "verify"));
    } else if (user[0] == 1) {
      log("Ошибка ${user[1]}");
      showModalBottomSheet(context: context, builder: (BuildContext context) => AuthDenySheet(type: user[1]));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return Container(
      decoration: BoxDecoration(gradient: BackgroundGrad()),
      child: Stack(
        children: [
          Padding(
              padding: EdgeInsets.only(top: height / 1.6, left: width / 2.3),
              child: Transform.rotate(
                  angle: 5 * math.pi / 12,
                  child: Image.asset("images/triangle.png",
                      scale: 1.2, opacity: const AlwaysStoppedAnimation(0.15), alignment: Alignment.center))),
          Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: (height - width) > 0 ? height / 7 : height / 10),
                    const SizedBox(
                      height: 50,
                      child: Text(
                        "Регистрация",
                        style:
                            TextStyle(fontWeight: FontWeight.w700, fontSize: 40, color: Colors.white, letterSpacing: 2),
                      ),
                    ),
                    SizedBox(height: (height - width) > 0 ? height / 11 : height / 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Ваш никнейм:",
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          height: 40,
                          width: 295,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              Icon(Icons.account_circle_outlined, size: 24, color: Color(CustomColors.bright)),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 250,
                                height: 40,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints.expand(width: AuthSettings().maxUsernameLength * 18),
                                    child: TextField(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black87),
                                      maxLength: AuthSettings().maxUsernameLength,
                                      onChanged: (value) => setState(() {
                                        username = value;
                                      }),
                                      decoration: const InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                        contentPadding: EdgeInsets.only(bottom: 8),
                                        counterText: "",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Почта:",
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          height: 40,
                          width: 295,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              Icon(Icons.mail_outline, size: 24, color: Color(CustomColors.bright)),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 250,
                                height: 40,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints.expand(width: AuthSettings().maxEmailLength * 18),
                                    child: TextField(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black87),
                                      maxLength: AuthSettings().maxEmailLength,
                                      onChanged: (value) => setState(() {
                                        email = value;
                                      }),
                                      decoration: const InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                        contentPadding: EdgeInsets.only(bottom: 12),
                                        counterText: "",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Пароль:",
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                        Container(
                          height: 40,
                          width: 295,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              Icon(Icons.key_outlined, size: 24, color: Color(CustomColors.bright)),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: 210,
                                height: 40,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints.expand(width: AuthSettings().maxPasswordLength * 18),
                                    child: TextField(
                                      obscureText: obscureBool,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w700, fontSize: 18, color: Colors.black87),
                                      maxLength: AuthSettings().maxPasswordLength,
                                      onChanged: (value) => setState(() {
                                        password = value;
                                      }),
                                      decoration: const InputDecoration(
                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                        contentPadding: EdgeInsets.only(bottom: 12),
                                        counterText: "",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                  iconSize: 20,
                                  visualDensity: VisualDensity.compact,
                                  onPressed: () => setState(() {
                                        obscureBool = !obscureBool;
                                      }),
                                  icon: !obscureBool ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off))
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: (height - width) > 0 ? height / 11 : height / 18),
                    Container(
                      height: 40,
                      width: 180,
                      decoration: BoxDecoration(
                          gradient: ButtonGrad(),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(spreadRadius: 1, offset: Offset(0, 2), blurRadius: 2, color: Colors.black26)
                          ]),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: () async {
                          if (username == null || password == null) {
                            showModalBottomSheet(
                                context: context, builder: (BuildContext context) => const AuthDenySheet(type: "none"));
                          } else if (username!.length < 4 || password!.length < 4) {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) => const AuthDenySheet(type: "length"));
                          } else {
                            log("Логин: $username, пароль: $password");
                            signUp(email!, password!);
                          }
                        },
                        child: const Text(
                          "Создать",
                          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//import 'dart:math' as math;

import 'package:ai_app/etc/colors/colors.dart';
import 'package:ai_app/etc/colors/gradients.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class MainShellScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final String currentPath;
  const MainShellScaffold({required this.title, required this.child, required this.currentPath, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65.0),
        child: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))),
          backgroundColor: Colors.white,
          elevation: 5,
          shadowColor: Colors.black,
          leadingWidth: 60,
          leading: Padding(
            padding: const EdgeInsets.only(top: 5, left: 5),
            child: IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu, color: CustomColors.main, size: 30)),
          ),
          title: Center(
              child: Text(title,
                  style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: CustomColors.main))),
          actions: [
            Row(
              children: [
                IconButton(
                    onPressed: () async {
                      ;
                    },
                    icon: const Icon(Icons.settings, color: CustomColors.main, size: 30)),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        width: 270,
        elevation: 20,
        child: Container(
          decoration: const BoxDecoration(gradient: CustomGradients.drawerGrad),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                const Text('AI App', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Container(
                  height: 90,
                  width: 230,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(153, 106, 64, 119),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, offset: Offset(0, 3), spreadRadius: 1, blurRadius: 2)
                      ]),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [CircularProgressIndicator()]),
                ),
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: () {
                    if (currentPath != "/main/home") {
                      context.go("/main/home");
                    }
                  },
                  child: Container(
                    width: 230,
                    height: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: currentPath == "/main/home" ? Colors.white24 : Colors.transparent),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "Главное меню",
                          style: GoogleFonts.nunito(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (currentPath != "/main/tasks") {
                      context.go("/main/tasks");
                    }
                  },
                  child: Container(
                    width: 230,
                    height: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: currentPath == "/main/tasks" ? Colors.white24 : Colors.transparent),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "Задания",
                          style: GoogleFonts.nunito(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (currentPath != "/main/diagnostics") {
                      context.go("/main/diagnostics");
                    }
                  },
                  child: Container(
                    width: 230,
                    height: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: currentPath == "/main/diagnostics" ? Colors.white24 : Colors.transparent),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "Диагностика",
                          style: GoogleFonts.nunito(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (currentPath != "/main/settings") {
                      context.go("/main/settings");
                    }
                  },
                  child: Container(
                    width: 230,
                    height: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: currentPath == "/main/settings" ? Colors.white24 : Colors.transparent),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "Настройки",
                          style: GoogleFonts.nunito(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    if (currentPath != "/main/info") {
                      context.go("/main/info");
                    }
                  },
                  child: Container(
                    width: 230,
                    height: 40,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: currentPath == "/main/info" ? Colors.white24 : Colors.transparent),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.chat_outlined,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "О приложении",
                          style: GoogleFonts.nunito(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Stack(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 40, top: 35),
                        child: Transform.rotate(
                          angle: 0,
                          child: Image.asset("images/hexagon_grad.png",
                              scale: 1.6, opacity: const AlwaysStoppedAnimation(0.5), alignment: Alignment.center),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(right: 0, bottom: 0),
                        child: Transform.rotate(
                          angle: 0,
                          child: Image.asset("images/hexagon_grad.png",
                              scale: 1.9, opacity: const AlwaysStoppedAnimation(0.2), alignment: Alignment.center),
                        )),
                  ],
                ),
                const SizedBox(
                    height: 40,
                    width: 170,
                    child: Text(
                      'Created and designed by Proman2702',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white24),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

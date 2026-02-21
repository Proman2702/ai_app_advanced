import 'package:ai_app/ui/auth/forgot_password_page.dart';
import 'package:ai_app/ui/diagnostics/diag_task_page.dart';
import 'package:ai_app/ui/info/info_page.dart';
import 'package:ai_app/ui/settings/settings_page.dart';
import 'package:ai_app/ui/diagnostics/diag_menu_page.dart';
import 'package:ai_app/ui/auth/register/screen.dart';
import 'package:ai_app/ui/tasks/tasks_menu_page.dart';

import 'package:ai_app/ui/tasks/levels_page.dart';
import 'package:ai_app/ui/wrapper.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:ai_app/ui/tasks/task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

import 'package:media_store_plus/media_store_plus.dart';

void main() async {
  await MediaStore.ensureInitialized();

  MediaStore.appFolder = 'AIApp';
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Wrapper(),
        '/auth/create': (context) => const FirstPage(),
        '/auth/forgot': (context) => const ForgotPasswordPage(),
        '/settings': (context) => const SettingsPage(),
        '/diagnostics': (context) => const DiagnosticsPage(),
        '/diagnostics/level': (context) => const DiagnosticsTaskPage(),
        '/tasks': (context) => const TasksPage(),
        '/tasks/levels': (context) => const LevelsMenu(),
        '/tasks/levels/level': (context) => const TaskPage(),
        '/info': (context) => const InfoPage(),
      },
      theme: ThemeData(fontFamily: "Jura"),
    );
  }
}

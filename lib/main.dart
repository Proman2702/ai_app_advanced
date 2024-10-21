import 'package:ai_app/features/auth/forgot_password_page.dart';
import 'package:ai_app/features/diagnostics/diag_task_page.dart';
import 'package:ai_app/features/info/info_page.dart';
import 'package:ai_app/features/settings/settings_page.dart';
import 'package:ai_app/features/diagnostics/diag_menu_page.dart';
import 'package:ai_app/features/auth/sign_in_page.dart';
import 'package:ai_app/features/tasks/tasks_menu_page.dart';
import 'package:ai_app/features/sandbox/sandbox.dart';
import 'package:ai_app/features/tasks/levels_page.dart';
import 'package:ai_app/features/auth/wrapper.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:ai_app/features/tasks/task_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'firebase_options.dart';

void main() async {
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
        '/sandbox': (context) => const Sandbox()
      },
      theme: ThemeData(fontFamily: "Jura"),
    );
  }
}

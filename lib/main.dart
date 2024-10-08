import 'package:ai_app/features/auth/forgot_password_page.dart';
import 'package:ai_app/features/auth/sign_in_page.dart';
import 'package:ai_app/features/home/home_page.dart';
import 'package:ai_app/features/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:ai_app/features/auth/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => const AuthPage(),
        '/home': (context) => const HomePage(),
        '/auth/create': (context) => const FirstPage(),
        '/auth/forgot': (context) => const ForgotPasswordPage(),
        '/settings': (context) => const SettingsPage()
      },
      theme: ThemeData(fontFamily: "Jura"),
    );
  }
}

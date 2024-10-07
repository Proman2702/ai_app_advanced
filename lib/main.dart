import 'package:flutter/material.dart';
import 'package:ai_app/features/auth/auth_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/auth',
      routes: {'/auth': (context) => const AuthPage()},
      theme: ThemeData(fontFamily: "Jura"),
      home: const AuthPage(),
    );
  }
}

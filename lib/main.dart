import 'package:ai_app/navigation/routes.dart';
import 'package:ai_app/repositories/auth/firebase/firebase_auth_gate.dart';
import 'package:ai_app/repositories/auth/firebase/firebase_auth_service.dart';
import 'package:ai_app/repositories/database/firebase/firebase_users_database.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
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

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => FirebaseAuthService(FirebaseAuth.instance)),
        Provider(create: (_) => FirebaseUserSessionGate(FirebaseAuth.instance)),
        Provider(
            create: (context) =>
                FirebaseUsersDatabase(FirebaseFirestore.instance, context.read<FirebaseUserSessionGate>())),
        Provider<AppRouter>(
          create: (ctx) => AppRouter(ctx.read<UserSessionGate>()),
          dispose: (_, r) => r.dispose(),
        ),
      ],
      child: Consumer(
          builder: (context, _, __) => MaterialApp.router(
                routerConfig: context.read<AppRouter>().router,
              )),
    );
  }
}

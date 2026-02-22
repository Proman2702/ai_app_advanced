import 'package:ai_app/navigation/stream_to_listenable.dart';
import 'package:ai_app/repositories/auth/firebase/firebase_auth_gate.dart';
import 'package:ai_app/ui/auth/main/screen.dart';
import 'package:ai_app/ui/auth/main/view_model.dart';
import 'package:ai_app/ui/auth/recovery/screen.dart';
import 'package:ai_app/ui/auth/recovery/view_model.dart';
import 'package:ai_app/ui/auth/register/screen.dart';
import 'package:ai_app/ui/auth/register/view_model.dart';
import 'package:ai_app/ui/diagnostics/screen.dart';
import 'package:ai_app/ui/diagnostics/view_model.dart';
import 'package:ai_app/ui/home/screen.dart';
import 'package:ai_app/ui/home/view_model.dart';
import 'package:ai_app/ui/info/screen.dart';
import 'package:ai_app/ui/info/view_model.dart';
import 'package:ai_app/ui/main_shell.dart';
import 'package:ai_app/ui/settings/screen.dart';
import 'package:ai_app/ui/settings/view_model.dart';
import 'package:ai_app/ui/tasks/screen.dart';
import 'package:ai_app/ui/tasks/view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  final UserSessionGate _gate;
  final SessionListenable _refresh;

  late final GoRouter router;

  AppRouter(this._gate) : _refresh = SessionListenable(_gate) {
    router = GoRouter(
      initialLocation: "/auth",
      refreshListenable: _refresh,
      redirect: (context, state) {
        final loggedIn = _gate.currentUid != null;
        final path = state.uri.path;

        final inAuthFlow = path == '/auth' || path.startsWith('/auth/');

        if (!loggedIn && !inAuthFlow) return '/auth';
        if (loggedIn && inAuthFlow) return '/main/home';

        return null;
      },
      routes: [
        GoRoute(
          path: "/auth",
          builder: (_, __) => ChangeNotifierProvider(
            create: (_) => AuthPageModel(),
            child: const AuthPage(),
          ),
          routes: [
            GoRoute(
              path: 'register',
              builder: (_, __) => ChangeNotifierProvider(
                create: (_) => RegisterScreenModel(),
                child: const RegisterScreen(),
              ),
            ),
            GoRoute(
              path: 'recovery',
              builder: (_, __) => ChangeNotifierProvider(
                create: (_) => RecoveryScreenModel(),
                child: const RecoveryScreen(),
              ),
            ),
          ],
        ),
        ShellRoute(
          builder: (context, state, child) {
            final path = state.uri.path;
            final title = _maptitleByPath(path);
            return MainShellScaffold(
              currentPath: path,
              title: title,
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: "/main/home",
              builder: (_, __) => ChangeNotifierProvider(
                create: (_) => HomeScreenModel(),
                child: const HomeScreen(),
              ),
            ),
            GoRoute(
              path: "/main/tasks",
              builder: (_, __) => ChangeNotifierProvider(
                create: (_) => TasksMenuScreenModel(),
                child: const TasksMenuScreen(),
              ),
            ),
            GoRoute(
              path: "/main/settings",
              builder: (_, __) => ChangeNotifierProvider(
                create: (_) => SettingsScreenModel(),
                child: const SettingsScreen(),
              ),
            ),
            GoRoute(
              path: "/main/diagnostics",
              builder: (_, __) => ChangeNotifierProvider(
                create: (_) => DiagnosticsMenuScreenModel(),
                child: const DiagnosticsMenuScreen(),
              ),
            ),
            GoRoute(
              path: "/main/info",
              builder: (_, __) => ChangeNotifierProvider(
                create: (_) => InformationScreenModel(),
                child: const InformationScreen(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static String _maptitleByPath(String path) {
    switch (path) {
      case "/main/home":
        return "Главная";
    }
    return 'Приложение';
  }

  void dispose() => _refresh.dispose();
}

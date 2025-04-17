import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/login/login_page.dart';
import '../../features/auth/presentation/views/register/register_page.dart';
import '../../features/home/presentation/views/home_page.dart';
import '../../features/splash/presentation/views/splash_page.dart';

abstract class Routers {
  static const String kHomePageRoute = '/homePage';
  static const String kLoginPageRoute = '/loginPage';
  static const String kRegisterPageRoute = '/registerPage';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: kHomePageRoute,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: kLoginPageRoute,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: kRegisterPageRoute,
        builder: (context, state) => const RegisterPage(),
      ),
    ],
  );
}

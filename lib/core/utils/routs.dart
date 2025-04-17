import 'package:go_router/go_router.dart';
import 'package:nuhoud/features/splash/presentation/views/splash_page.dart';

import '../../features/home/presentation/views/home_page.dart';

abstract class Routers {
  static const String kHomePageRoute = '/homePage';
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
    ],
  );
}

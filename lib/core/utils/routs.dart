import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/views/login/login_page.dart';
import '../../features/auth/presentation/views/register/register_page.dart';
import '../../features/auth/presentation/views/reset_password/reset_password_page.dart';
import '../../features/auth/presentation/views/verification/verification_page.dart';
import '../../features/home/presentation/views/home_page.dart';
import '../../features/onboarding/presentation/views/onboarding_intro_page.dart';
import '../../features/onboarding/presentation/views/onboarding_upload_page.dart';
import '../../features/splash/presentation/views/splash_page.dart';

abstract class Routers {
  static const String kHomePageRoute = '/homePage';
  static const String kLoginPageRoute = '/loginPage';
  static const String kRegisterPageRoute = '/registerPage';
  static const String kVerificationPageRoute = '/verificationPage';
  static const String kRestPasswordPage = '/restPasswPage';
  static const String kOndboardingIntroPage = '/onboardingIntroPage';
  static const String kOndboardingUploadPage = '/onboardingUploadPage';

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
      GoRoute(
        path: kVerificationPageRoute,
        builder: (context, state) {
          final args = state.extra as VerificationArgs;
          return VerificationPage(
            email: args.emailOrPhone,
            isFromRegiter: args.isFromRegister,
            selectedAuthType: args.selectedAuthType,
          );
        },
      ),
      GoRoute(
        path: kRestPasswordPage,
        builder: (context, state) => const ResetPasswordPage(),
      ),
      GoRoute(
        path: kOndboardingIntroPage,
        builder: (context, state) => const OnboardingIntroPage(),
      ),
      GoRoute(
        path: kOndboardingUploadPage,
        builder: (context, state) => const OnboardingUploadPage(),
      ),
    ],
  );
}

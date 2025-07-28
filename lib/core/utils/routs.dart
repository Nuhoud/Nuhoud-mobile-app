import 'package:go_router/go_router.dart';
import 'package:nuhoud/features/auth/presentation/views/reset_password/request_reset_password_page.dart';
import 'package:nuhoud/features/home/data/models/job_model.dart';
import 'package:nuhoud/features/home/presentation/views/filter_page.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/filter_result_screen.dart';
import 'package:nuhoud/features/job_applications/presentation/views/job_applications_page.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';
import 'package:nuhoud/features/profile/presentation/views/profile_basic_info_page.dart';
import 'package:nuhoud/features/profile/presentation/views/profile_certifications_page.dart';
import 'package:nuhoud/features/profile/presentation/views/profile_experince_page.dart';
import 'package:nuhoud/features/profile/presentation/views/profile_goals_page.dart';
import 'package:nuhoud/features/profile/presentation/views/profile_job_preferences_page.dart';
import 'package:nuhoud/features/profile/presentation/views/profile_skils_page.dart';
import 'package:nuhoud/features/profile/presentation/views/proflie_page.dart';

import '../../features/auth/presentation/views/login/login_page.dart';
import '../../features/auth/presentation/views/register/register_page.dart';
import '../../features/auth/presentation/views/reset_password/reset_password_page.dart';
import '../../features/auth/presentation/views/verification/verification_page.dart';
import '../../features/home/presentation/views/home_layout.dart';
import '../../features/home/presentation/views/jobe_details_page.dart';
import '../../features/onboarding/presentation/views/onboarding_intro_page.dart';
import '../../features/onboarding/presentation/views/onboarding_job_preferences_page.dart';
import '../../features/onboarding/presentation/views/onboarding_ueser_experince_page.dart';
import '../../features/onboarding/presentation/views/onboarding_upload_page.dart';
import '../../features/onboarding/presentation/views/onboarding_user_basic_info_page.dart';
import '../../features/onboarding/presentation/views/onboarding_user_certifications_page.dart';
import '../../features/onboarding/presentation/views/onboarding_user_education_info_page.dart';
import '../../features/onboarding/presentation/views/onboarding_user_goals_page.dart';
import '../../features/onboarding/presentation/views/onboarding_user_skills_page.dart';
import '../../features/profile/presentation/views/profile_eduction_page.dart';
import '../../features/splash/presentation/views/splash_page.dart';

abstract class Routers {
  //auth pages
  static const String kHomePageRoute = '/homePage';
  static const String kLoginPageRoute = '/loginPage';
  static const String kRegisterPageRoute = '/registerPage';
  static const String kVerificationPageRoute = '/verificationPage';
  static const String kRestPasswordPage = '/restPasswPage';
  static const String kRequestResetPassowrdPage = "/RequestResetPassowrdPage";

  //onboarding pages
  static const String kOndboardingIntroPage = '/onboardingIntroPage';
  static const String kOndboardingUploadPage = '/onboardingUploadPage';
  static const String kOndboardingUserInfoPage = '/onboardingUserInfoPage';
  static const String kOndboardingUserEducationPage = '/onboardingUserEducationPage';
  static const String kOndboardingUserExperiencePage = '/onboardingUserExperiencePage';
  static const String kOndboardingUserBasicPage = '/onboardingUserBasicPage';
  static const String kOndboardingUserGoalsPage = '/onboardingUserGoalsPage';
  static const String kOndboardingJobPreferencesPage = '/onboardingJobPreferencesPage';
  static const String kOndboardingUserCertificationsPage = '/onboardingUserCertificationsPage';
  static const String kOndboardingUserSkillsPage = '/onboardingUserSkillsPage';

  static const String kJobDetailsPage = '/jobDetailsPage';

  //profile pages
  static const String kProfilePage = '/profilePage';
  static const String kProfileBasicInfoPage = '/profileBasicInfoPage';
  static const String kProfileEducationPage = '/profileEducationPage';
  static const String kProfileExperiencePage = '/profileExperiencePage';
  static const String kProfileCertificationsPage = '/profileCertificationsPage';
  static const String kProfileGoalsPage = "/ProfileGoalsPage";
  static const String kProfileJobPreferencesPage = '/profileJobPreferencesPage';
  static const String kProfileSkillsPage = '/profileSkillsPage';
  static const String kFilterPage = '/filterPage';
  static const String kFilterResultScreen = '/filterResultScreen';

  //job applications
  static const String kJobApplicationsScreen = '/ApplicationsScreen';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: kHomePageRoute,
        builder: (context, state) => const HomeLayout(),
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
        path: kRequestResetPassowrdPage,
        builder: (context, state) => const RequestResetPasswordPage(),
      ),
      GoRoute(
        path: kOndboardingIntroPage,
        builder: (context, state) => const OnboardingIntroPage(),
      ),
      GoRoute(
        path: kOndboardingUploadPage,
        builder: (context, state) => const OnboardingUploadPage(),
      ),
      GoRoute(
        path: kOndboardingUserEducationPage,
        builder: (context, state) => const OnboardingUserEducationInfoPage(),
      ),
      GoRoute(
        path: kOndboardingUserBasicPage,
        builder: (context, state) => const OnboardingUserBasicInfoPage(),
      ),
      GoRoute(
        path: kOndboardingUserExperiencePage,
        builder: (context, state) => const OnboardingUserExperiencePage(),
      ),
      GoRoute(
        path: kOndboardingUserGoalsPage,
        builder: (context, state) => const OnboardingUserGoalsPage(),
      ),
      GoRoute(
        path: kOndboardingJobPreferencesPage,
        builder: (context, state) => const OnboardingJobPreferencesPage(),
      ),
      GoRoute(
        path: kOndboardingUserCertificationsPage,
        builder: (context, state) => const OnboardingUserCertificationsPage(),
      ),
      GoRoute(
        path: kOndboardingUserSkillsPage,
        builder: (context, state) => const OnboardingUserSkillsPage(),
      ),
      GoRoute(
        path: kJobDetailsPage,
        builder: (context, state) => JobDetailsPage(job: state.extra as JobModel),
      ),
      GoRoute(
        path: kProfilePage,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: kProfileBasicInfoPage,
        builder: (context, state) => ProfileBasicInfoPage(
          basicInfo: state.extra as BasicInfo,
        ),
      ),
      GoRoute(
        path: kProfileEducationPage,
        builder: (context, state) => ProfileEducationPage(
          initialEducations: state.extra as List<Education>,
        ),
      ),
      GoRoute(
        path: kProfileExperiencePage,
        builder: (context, state) => ProfileExperiencePage(
          initialExperiences: state.extra as List<Experience>,
        ),
      ),
      GoRoute(
        path: kProfileCertificationsPage,
        builder: (context, state) => ProfileCertificationPage(
          initialCertifications: state.extra as List<Certification>,
        ),
      ),
      GoRoute(
        path: kProfileGoalsPage,
        builder: (context, state) => ProfileGoalsPage(
          initialGoals: state.extra as Goals,
        ),
      ),
      GoRoute(
        path: kProfileJobPreferencesPage,
        builder: (context, state) => ProfileJobPreferencesPage(
          initialPreferences: state.extra as JobPreferences,
        ),
      ),
      GoRoute(
        path: kProfileSkillsPage,
        builder: (context, state) => ProfileSkillsPage(
          initialSkills: state.extra as Skills,
        ),
      ),
      GoRoute(
        path: kFilterPage,
        builder: (context, state) => const FilterPage(),
      ),
      GoRoute(
        path: kFilterResultScreen,
        builder: (context, state) => const FilterResultScreen(),
      ),
      GoRoute(
        path: kJobApplicationsScreen,
        builder: (context, state) => const JobApplicationsPage(),
      ),
    ],
  );
}

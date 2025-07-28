import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nuhoud/core/api_services/urls.dart';
import 'package:nuhoud/core/shared/cubits/refresh_cubit/refresh_cubit.dart';
import 'package:nuhoud/core/shared/cubits/skills_cubit/skills_cubit.dart';
import 'package:nuhoud/core/shared/repos/skills_repo/skills_repo.dart';
import 'package:nuhoud/core/shared/repos/skills_repo/skills_repo_iplm.dart';
import 'package:nuhoud/features/home/data/repos/appliction_repo.dart';
import 'package:nuhoud/features/home/data/repos/appliction_repo_iplm.dart';
import 'package:nuhoud/features/home/data/repos/home_repo.dart';
import 'package:nuhoud/features/home/data/repos/home_repo_iplm.dart';
import 'package:nuhoud/features/home/presentation/view-model/appliction_cubit/appliction_cubit.dart';
import 'package:nuhoud/features/home/presentation/view-model/home_cubit/home_cubit.dart';
import 'package:nuhoud/features/job_applications/data/repos/job_applications_repo.dart';
import 'package:nuhoud/features/job_applications/data/repos/job_applications_repo_iplm.dart';
import 'package:nuhoud/features/job_applications/presentation/veiw_model/job_application_cubit.dart';
import 'package:nuhoud/features/onboarding/data/repo/onboarding_repo.dart';
import 'package:nuhoud/features/onboarding/data/repo/onboarding_rpeo_iplm.dart';
import 'package:nuhoud/features/onboarding/presentation/view-model/onboarding_cuibt/onboarding_cubit.dart';
import 'package:nuhoud/features/profile/data/repos/profile_repo.dart';
import 'package:nuhoud/features/profile/data/repos/profile_repo_iplm.dart';
import 'package:nuhoud/features/profile/presentation/view-model/cubit/profile_cubit.dart';
import 'package:nuhoud/features/user_plan/data/repos/user_plan_repo.dart';
import 'package:nuhoud/features/user_plan/data/repos/user_plan_repo_iplm.dart';
import 'package:nuhoud/features/user_plan/presentation/viwe-model/cubit/user_plan_cubit.dart';

import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/data/repo/auth_repo_iplm.dart';
import '../../features/auth/presentation/view-model/auth_cubit.dart';
import '../api_services/api_services.dart';

final getit = GetIt.instance;

void setupLocatorServices() {
  // Dio for main server
  getit.registerLazySingleton<Dio>(() => Dio(BaseOptions(
      baseUrl: Urls.mainBaseUrl,
      connectTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1))));

  // Dio for jobs server
  getit.registerLazySingleton<Dio>(
      () => Dio(BaseOptions(
          baseUrl: Urls.jobsBaseUrl,
          connectTimeout: const Duration(minutes: 1),
          sendTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1))),
      instanceName: 'jobsDio');

  // ApiServices
  getit.registerLazySingleton<ApiServices>(() => ApiServices(getit<Dio>()));
  getit.registerLazySingleton<ApiServices>(() => ApiServices(getit<Dio>(instanceName: 'jobsDio')),
      instanceName: 'jobsApiServices');

  //repos
  getit.registerLazySingleton<AuthRepo>(() => AuthRepoImpl(getit.get<ApiServices>()));
  getit.registerLazySingleton<OnboardingRepo>(() => OnboardingRepoImpl(apiServices: getit.get<ApiServices>()));
  getit.registerLazySingleton<HomeRepo>(() => HomeRepoImpl(getit.get<ApiServices>(instanceName: 'jobsApiServices')));
  getit.registerLazySingleton<ApplicationRepo>(() => ApplicationRepoImpl(getit.get<ApiServices>()));
  getit.registerLazySingleton<ProfileRepo>(() => ProfileRepoImpl(getit.get<ApiServices>()));
  getit.registerLazySingleton<UserPlanRepo>(() => UserPlanRepoImpl(getit.get<ApiServices>()));
  getit.registerLazySingleton<SkillsRepo>(() => SkillsRepoImpl(getit.get<ApiServices>()));
  getit.registerLazySingleton<JobApplicationsRepo>(
      () => JobApplicationsRepoImpl(getit.get<ApiServices>(instanceName: 'jobsApiServices')));

  //cubits
  getit.registerLazySingleton<RefreshCubit>(() => RefreshCubit());
  getit.registerFactory<AuthCubit>(() => AuthCubit(getit.get<AuthRepo>()));
  getit.registerFactory<OnboardingCubit>(() => OnboardingCubit(onboardingRepo: getit.get<OnboardingRepo>()));
  getit.registerFactory<HomeCubit>(() => HomeCubit(getit.get<HomeRepo>()));
  getit.registerFactory<ApplictionCubit>(() => ApplictionCubit(getit.get<ApplicationRepo>()));
  getit.registerFactory<ProfileCubit>(() => ProfileCubit(getit.get<ProfileRepo>()));
  getit.registerFactory<UserPlanCubit>(() => UserPlanCubit(getit.get<UserPlanRepo>()));
  getit.registerFactory<SkillsCubit>(() => SkillsCubit(getit.get<SkillsRepo>()));
  getit.registerFactory<JobApplicationCubit>(() => JobApplicationCubit(getit.get<JobApplicationsRepo>()));
}

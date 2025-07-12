import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nuhoud/core/api_services/urls.dart';
import 'package:nuhoud/core/shared/cubits/refresh_cubit/refresh_cubit.dart';
import 'package:nuhoud/features/home/data/repos/appliction_repo.dart';
import 'package:nuhoud/features/home/data/repos/appliction_repo_iplm.dart';
import 'package:nuhoud/features/home/data/repos/home_repo.dart';
import 'package:nuhoud/features/home/data/repos/home_repo_iplm.dart';
import 'package:nuhoud/features/home/presentation/view-model/appliction_cubit/appliction_cubit.dart';
import 'package:nuhoud/features/home/presentation/view-model/home_cubit/home_cubit.dart';
import 'package:nuhoud/features/onboarding/data/repo/onboarding_repo.dart';
import 'package:nuhoud/features/onboarding/data/repo/onboarding_rpeo_iplm.dart';
import 'package:nuhoud/features/onboarding/presentation/view-model/onboarding_cuibt/onboarding_cubit.dart';

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

  //cubits
  getit.registerLazySingleton<RefreshCubit>(() => RefreshCubit());
  getit.registerFactory<AuthCubit>(() => AuthCubit(getit.get<AuthRepo>()));
  getit.registerFactory<OnboardingCubit>(() => OnboardingCubit(onboardingRepo: getit.get<OnboardingRepo>()));
  getit.registerFactory<HomeCubit>(() => HomeCubit(getit.get<HomeRepo>()));
  getit.registerFactory<ApplictionCubit>(() => ApplictionCubit(getit.get<ApplicationRepo>()));
}

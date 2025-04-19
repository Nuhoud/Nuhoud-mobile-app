import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repo/auth_repo.dart';
import '../../features/auth/data/repo/auth_repo_iplm.dart';
import '../../features/auth/presentation/view-model/auth_cubit.dart';
import '../api_services/api_services.dart';

final getit = GetIt.instance;

void setupLocatorServices() {
  //Dio
  getit.registerLazySingleton<Dio>(() => Dio(BaseOptions(
      connectTimeout: const Duration(minutes: 1),
      sendTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1))));

  // API Services
  getit.registerLazySingleton<ApiServices>(() => ApiServices(getit()));

  //Auth Repo
  getit.registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(getit.get<ApiServices>()));

  // Auth Cubit (factory registration)
  getit.registerFactory<AuthCubit>(() => AuthCubit(getit.get<AuthRepo>()));
}

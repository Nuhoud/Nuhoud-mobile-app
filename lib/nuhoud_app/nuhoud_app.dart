import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/shared/cubits/refresh_cubit/refresh_cubit.dart';
import 'package:nuhoud/core/shared/cubits/skills_cubit/skills_cubit.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'package:nuhoud/features/home/presentation/view-model/appliction_cubit/appliction_cubit.dart';
import 'package:nuhoud/features/home/presentation/view-model/home_cubit/home_cubit.dart';
import 'package:nuhoud/features/profile/presentation/view-model/cubit/profile_cubit.dart';
import 'package:nuhoud/features/user_plan/presentation/viwe-model/cubit/user_plan_cubit.dart';

import '../core/locale/locale_cubit.dart';
import '../features/onboarding/presentation/view-model/onboarding_cuibt/onboarding_cubit.dart';
import 'widgets/nuhoud_material_app.dart';

class NuhoudApp extends StatelessWidget {
  const NuhoudApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()..getSaveLanguage()),
        BlocProvider(create: (context) => getit.get<OnboardingCubit>()),
        BlocProvider(create: (context) => getit.get<RefreshCubit>()),
        BlocProvider(create: (context) => getit.get<HomeCubit>()..getJobs(loadMore: false)),
        BlocProvider(create: (context) => getit.get<ApplictionCubit>()),
        BlocProvider(create: (context) => getit.get<ProfileCubit>()),
        BlocProvider(create: (context) => getit.get<SkillsCubit>()),
        BlocProvider(create: (context) => getit.get<UserPlanCubit>()),
      ],
      child: const NuhoudMaterialApp(),
    );
  }
}

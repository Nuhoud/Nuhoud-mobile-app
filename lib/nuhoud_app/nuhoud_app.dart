import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        BlocProvider(create: (context) => OnboardingCubit()),
      ],
      child: const NuhoudMaterialApp(),
    );
  }
}

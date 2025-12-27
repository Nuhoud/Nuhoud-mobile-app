import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nuhoud/core/notification_services/firebase_service.dart';

import '../../core/locale/locale_cubit.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_localizations.dart';
import '../../core/utils/routs.dart';

class NuhoudMaterialApp extends StatelessWidget {
  final FirebaseMessagingService firebaseMessagingService;
  const NuhoudMaterialApp({
    super.key,
    required this.firebaseMessagingService,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          locale: const Locale("ar"),
          supportedLocales: const [
            Locale("en"),
            Locale("ar"),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (deviceLocal, supportedLocales) {
            for (var locale in supportedLocales) {
              if (deviceLocal != null && deviceLocal.languageCode == locale.languageCode) {
                return deviceLocal;
              }
            }
            return supportedLocales.first;
          },
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.backgroundColor,
              fontFamily: "Ubuntu"),
          routerConfig: Routers.router,
          builder: (context, child) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              try {
                await firebaseMessagingService.initialize();
                await firebaseMessagingService.handlePendingNavigation();
              } catch (e) {
                print('FCM initialization error: $e');
              }
            });
            return child!;
          },
        );
      },
    );
  }
}

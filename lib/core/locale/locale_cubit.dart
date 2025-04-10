import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../utils/cache_helper.dart';
import '../utils/app_constats.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<ChangeLocaleState> {
  LocaleCubit() : super(ChangeLocaleState(locale: const Locale("ar")));

  Future<void> getSaveLanguage() async {
    final String? cachedLanguageCode = CacheHelper.getData(key: "LOCALE");
    cachedLanguageCode;
    lang = cachedLanguageCode ?? 'ar';
    emit(ChangeLocaleState(locale: Locale(cachedLanguageCode ?? 'ar')));
  }

  Future<void> changeLanguage(String languageCode) async {
    await CacheHelper.setString(key: "LOCALE", value: languageCode);
    lang = languageCode;
    emit(ChangeLocaleState(locale: Locale(languageCode)));
  }
}

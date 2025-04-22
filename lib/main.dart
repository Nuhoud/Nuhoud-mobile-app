import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/cache_helper.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'nuhoud_app/nuhoud_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocatorServices();
  await CacheHelper.init();
  runApp(const NuhoudApp());
}

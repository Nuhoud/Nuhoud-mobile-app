import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nuhoud/core/notification_services/firebase_service.dart';

import 'package:nuhoud/core/utils/cache_helper.dart';
import 'package:nuhoud/core/utils/routs.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'nuhoud_app/nuhoud_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  setupLocatorServices();
  await CacheHelper.init();

  try {
    await FirebaseMessagingService(Routers.router).initialize();
  } catch (e) {
    log(e.toString());
  }

  runApp(const NuhoudApp());
}

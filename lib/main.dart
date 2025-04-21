import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/cache_helper.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'nuhoud_app/nuhoud_app.dart';

void main() {
  setupLocatorServices();
  CacheHelper.init();
  runApp(const NuhoudApp());
}

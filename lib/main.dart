import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'nuhoud_app/nuhoud_app.dart';

void main() {
  setupLocatorServices();
  runApp(const NuhoudApp());
}

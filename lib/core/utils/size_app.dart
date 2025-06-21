import 'package:flutter/material.dart';

double width(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

double height(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

double response(context, double size) {
  double s = (height(context) + width(context)) * (size / (932 + 430));
  return s.floorToDouble();
}

import 'package:flutter/material.dart';

class EducationFormItem {
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController fieldController = TextEditingController();
  final TextEditingController universityController = TextEditingController();
  final TextEditingController endYearController = TextEditingController();
  final TextEditingController gpaController = TextEditingController();

  void clear() {
    degreeController.clear();
    fieldController.clear();
    universityController.clear();
    endYearController.clear();
    gpaController.clear();
  }
}

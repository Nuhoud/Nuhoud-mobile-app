import 'package:flutter/material.dart';

class ExperinceFormItem {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final TextEditingController jobStartDateController = TextEditingController();
  final TextEditingController jobEndDateController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  void clear() {
    jobTitleController.clear();
    companyController.clear();
    jobDescriptionController.clear();
    jobStartDateController.clear();
    jobEndDateController.clear();
    jobLocationController.clear();
  }
}

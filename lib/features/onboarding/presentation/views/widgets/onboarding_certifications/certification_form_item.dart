import 'package:flutter/material.dart';

class CertificationFormItem {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController issueDateController = TextEditingController();
  final TextEditingController issuerController = TextEditingController();
  void clear() {
    nameController.clear();
    issueDateController.clear();
    issuerController.clear();
  }
}

import 'package:flutter/material.dart';

import 'widgets/reset_password_page_body.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RestPasswordPageBody(),
    );
  }
}

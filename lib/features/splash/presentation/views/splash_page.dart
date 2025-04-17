import 'package:flutter/material.dart';
import 'package:nuhoud/features/splash/presentation/views/widgets/splash_page_body.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashPageBody(),
    );
  }
}

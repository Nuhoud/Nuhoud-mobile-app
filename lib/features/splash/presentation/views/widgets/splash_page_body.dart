import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/cache_helper.dart';

import '../../../../../core/utils/assets_data.dart';
import '../../../../../core/utils/routs.dart';
import '../../../../../core/widgets/gradient_container.dart';

class SplashPageBody extends StatefulWidget {
  const SplashPageBody({super.key});

  @override
  State<SplashPageBody> createState() => _SplashPageBodyState();
}

class _SplashPageBodyState extends State<SplashPageBody> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInCirc),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });

    Timer(const Duration(seconds: 3), () {
      //_checkUser();
      GoRouter.of(context).pushReplacement(Routers.kLoginPageRoute);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GradientContainer(
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              ),
            );
          },
          child: Image.asset(
            AssetsData.logo,
            width: size.width * 0.35,
            height: size.height * 0.35,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  // _checkUser() {
  //   final token = CacheHelper.getData(key: "token");
  //   if (token == null) {
  //     GoRouter.of(context).pushReplacement(Routers.kLoginPageRoute);
  //   } else {
  //     GoRouter.of(context).pushReplacement(Routers.kHomePageRoute);
  //   }
  // }
}

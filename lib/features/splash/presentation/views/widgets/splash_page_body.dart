import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/cache_helper.dart';
import 'package:nuhoud/core/utils/routs.dart';
import 'package:nuhoud/core/widgets/gradient_container.dart';
import 'package:nuhoud/features/profile/presentation/view-model/cubit/profile_cubit.dart';
import '../../../../../core/utils/assets_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _checkUser();
      }
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  void _checkUser() {
    final token = CacheHelper.getData(key: "token");
    if (token == null) {
      GoRouter.of(context).pushReplacement(Routers.kLoginPageRoute);
      return;
    }
    context.read<ProfileCubit>().getProfile();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is GetProfileSuccess) {
          GoRouter.of(context).pushReplacement(Routers.kHomePageRoute);
        } else if (state is GetProfileError) {
          GoRouter.of(context).pushReplacement(Routers.kLoginPageRoute);
        }
      },
      builder: (context, state) {
        return GradientContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
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
              if (state is GetProfileLoading && _controller.status == AnimationStatus.completed) ...[
                const SizedBox(height: 20),
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ]
            ],
          ),
        );
      },
    );
  }
}

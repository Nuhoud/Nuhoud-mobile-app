import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_colors.dart';

import 'package:nuhoud/core/utils/size_app.dart';

import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/core/widgets/custom_error_widget.dart';
import 'package:nuhoud/core/widgets/skeletonizer_helper.dart';
import 'package:nuhoud/core/widgets/waiting_message_with_dots.dart';

import 'package:nuhoud/features/user_plan/presentation/views/user_plan_body.dart';
import 'package:nuhoud/features/user_plan/presentation/viwe-model/cubit/user_plan_cubit.dart';

class UserPlanPage extends StatefulWidget {
  const UserPlanPage({super.key});

  @override
  State<UserPlanPage> createState() => _UserPlanPageState();
}

class _UserPlanPageState extends State<UserPlanPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserPlanCubit>().getUserPlan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(response(context, 60)),
        child: const SafeArea(
          child: CustomAppBar(
            title: 'خطة التطوير',
            backBtn: false,
            backgroundColor: AppColors.primaryColor,
          ),
        ),
      ),
      body: BlocBuilder<UserPlanCubit, UserPlanState>(
        builder: (context, state) {
          if (state is GetPlanFromAI) {
            return const Center(
              child: WaitingMessageWithDots(
                message: "جاري إنشاء خطة التطوير بناءً على معلوماتك",
              ),
            );
          }
          if (state is UserPlanLoading || state is UserPlanInitial) {
            return SkeletonizerHelper.userPlanSkeletonizer();
          } else if (state is UserPlanSuccess) {
            return UserPlanPageBody(userPlanModel: state.userPlanModel);
          } else if (state is UserPlanError) {
            return CustomErrorWidget(
              errorMessage: state.message,
              onRetry: () => context.read<UserPlanCubit>().getUserPlan(),
            );
          }
          return Container();
        },
      ),
    );
  }
}

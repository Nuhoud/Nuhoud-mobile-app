import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/widgets/custom_error_widget.dart';
import 'package:nuhoud/core/widgets/empty_widget.dart';
import 'package:nuhoud/core/widgets/skeletonizer_helper.dart';
import 'package:nuhoud/features/home/presentation/view-model/home_cubit/home_cubit.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/job_appliction.dart';

import 'widgets/custom_home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: CustomHomeAppBar(height: MediaQuery.sizeOf(context).height * 0.13),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final homeCubit = context.read<HomeCubit>();
            if ((state is GetJobsLoading && state.isFirstLoading) || state is HomeInitial) {
              return SkeletonizerHelper.homeSkeletonizer();
            }
            if (state is GetJobsFailure) {
              return Center(
                  child: CustomErrorWidget(
                errorMessage: state.message,
                textColor: AppColors.headingTextColor,
                onRetry: () {
                  homeCubit.getJobs(loadMore: false);
                },
              ));
            }
            if (state is GetJobsSuccess && state.jobs.isEmpty) {
              return const Center(child: EmptyWidget());
            }
            return JobApplication(jobs: homeCubit.jobs);
          },
        ),
      ),
    );
  }
}

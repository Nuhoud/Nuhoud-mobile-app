import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/widgets/custom_error_widget.dart';
import 'package:nuhoud/core/widgets/loading_widget.dart';
import 'package:nuhoud/features/home/presentation/view-model/home_cubit/home_cubit.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/custom_job_details_appbar.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/job_details/job_details_bottom_nav_bar.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/job_details/jobe_details_page_body.dart';

class JobDetailsPage extends StatelessWidget {
  final String jobId;
  const JobDetailsPage({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
        bloc: context.read<HomeCubit>()..getJobDetails(jobId),
        builder: (context, state) {
          return Scaffold(
            bottomNavigationBar: state is GetJobDetailsSuccess ? JobDetailsBottomNavBar(job: state.job) : null,
            backgroundColor: Colors.white,
            extendBodyBehindAppBar: true,
            appBar: customAppBar(
              text: "",
              onPressed: () {
                Navigator.pop(context);
              },
              context: context,
            ),
            body: state is GetJobDetailsSuccess
                ? JobDetailsPageBody(job: state.job)
                : state is GetJobDetailsFailure
                    ? Center(
                        child: CustomErrorWidget(
                        errorMessage: state.message,
                        textColor: AppColors.headingTextColor,
                        onRetry: () {
                          context.read<HomeCubit>().getJobDetails(jobId);
                        },
                      ))
                    : const LoadingWidget(),
          );
        });
  }
}

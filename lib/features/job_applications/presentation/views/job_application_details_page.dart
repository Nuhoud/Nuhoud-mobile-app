import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'package:nuhoud/core/widgets/custom_error_widget.dart';
import 'package:nuhoud/core/widgets/loading_widget.dart';
import 'package:nuhoud/features/home/presentation/views/widgets/custom_job_details_appbar.dart';
import 'package:nuhoud/features/job_applications/presentation/veiw_model/job_application_cubit.dart';
import 'package:nuhoud/features/job_applications/presentation/views/job_applications_page.dart';

class JobApplicationDetailsPage extends StatelessWidget {
  final String applicationId;
  const JobApplicationDetailsPage({super.key, required this.applicationId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit.get<JobApplicationCubit>()..getJobApplicationDetails(applicationId),
      child: Scaffold(
          appBar: customAppBar(text: "حالت طلبك", context: context),
          body: BlocBuilder<JobApplicationCubit, JobApplicationState>(builder: (context, state) {
            if (state is JobApplicationDetailsSuccess) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  children: [
                    JobApplicationCard(application: state.jobApplication, shouldNavigate: false),
                  ],
                ),
              );
            } else if (state is JobApplicationDetailsError) {
              return CustomErrorWidget(
                  errorMessage: state.message,
                  onRetry: () => context.read<JobApplicationCubit>().getJobApplicationDetails(applicationId));
            } else if (state is JobApplicationDetailsLoading) {
              return const LoadingWidget();
            }
            return const SizedBox.shrink();
          })),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/size_app.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/core/widgets/custom_error_widget.dart';
import 'package:nuhoud/core/widgets/skeletonizer_helper.dart';
import 'package:nuhoud/features/job_applications/data/models/job_application_model.dart';
import 'package:nuhoud/features/job_applications/presentation/veiw_model/job_application_cubit.dart';
import 'package:nuhoud/core/utils/services_locater.dart';

class JobApplicationsPage extends StatelessWidget {
  const JobApplicationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit.get<JobApplicationCubit>()..getMyJobApplications(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(response(context, 60)),
          child: const SafeArea(
            child: CustomAppBar(
              backBtn: true,
              backgroundColor: AppColors.primaryColor,
              title: 'طلبات التوظيف المقدمة',
            ),
          ),
        ),
        body: BlocBuilder<JobApplicationCubit, JobApplicationState>(
          builder: (context, state) {
            if (state is JobApplicationLoading) {
              return _buildLoadingState();
            } else if (state is JobApplicationError) {
              return CustomErrorWidget(
                errorMessage: state.message,
                onRetry: () => context.read<JobApplicationCubit>().getMyJobApplications(),
              );
            } else if (state is JobApplicationSuccess) {
              return _buildSuccessState(state.jobApplication);
            }
            return _buildLoadingState();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return SkeletonizerHelper.homeSkeletonizer();
  }

  Widget _buildSuccessState(List<JobApplication> applications) {
    if (applications.isEmpty) {
      return const Center(
        child: Text(
          'لا توجد طلبات مقدمة',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      itemCount: applications.length,
      itemBuilder: (context, index) {
        return JobApplicationCard(application: applications[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }
}

class JobApplicationCard extends StatelessWidget {
  final JobApplication application;

  const JobApplicationCard({super.key, required this.application});

  (Color, Color, String) _getStatusData(String status) {
    switch (status.toLowerCase()) {
      case 'قيد المراجعة':
        return (Colors.orange[100]!, Colors.orange[800]!, 'قيد المراجعة');
      case 'مقبول':
        return (Colors.green[100]!, Colors.green[800]!, 'مقبول');
      case 'مرفوض':
        return (Colors.red[100]!, Colors.red[800]!, 'مرفوض');
      case 'تمت المراجعة':
        return (Colors.blue[100]!, Colors.blue[800]!, 'تمت المراجعة');
      default:
        return (Colors.grey[300]!, Colors.grey[800]!, status);
    }
  }

  @override
  Widget build(BuildContext context) {
    final (bgColor, textColor, statusText) = _getStatusData(application.status ?? 'pending');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job Title and Company
          Row(
            children: [
              const Icon(Icons.business_center, color: AppColors.primaryColor, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      application.jobTitle ?? 'عنوان الوظيفة غير متوفر',
                      style: Styles.textStyle18.copyWith(
                        color: AppColors.headingTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      application.companyName ?? 'شركة غير معروفة',
                      style: Styles.textStyle16.copyWith(
                        color: AppColors.subHeadingTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Status and Application Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Status
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText,
                  style: Styles.textStyle16.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Application Date
              if (application.postedAt != null)
                Text(
                  'تقدمت: ${DateTime.parse(application.postedAt!).day}/${DateTime.parse(application.postedAt!).month}/${DateTime.parse(application.postedAt!).year}',
                  style: Styles.textStyle15.copyWith(
                    color: AppColors.subHeadingTextColor,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // Employer Note
          if (application.employerNote?.isNotEmpty == true) ...[
            const Divider(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ملاحظة صاحب العمل:',
                  style: Styles.textStyle16.copyWith(
                    color: AppColors.headingTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  application.employerNote!,
                  style: Styles.textStyle16.copyWith(
                    color: AppColors.subHeadingTextColor,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

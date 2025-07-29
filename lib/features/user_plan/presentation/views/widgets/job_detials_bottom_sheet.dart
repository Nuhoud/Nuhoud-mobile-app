import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/functions.dart';
import 'package:nuhoud/core/utils/routs.dart';
import 'package:nuhoud/core/widgets/custom_snak_bar.dart';
import 'package:nuhoud/features/home/presentation/params/appliction_params.dart';
import 'package:nuhoud/features/home/presentation/view-model/appliction_cubit/appliction_cubit.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../data/models/user_plan_model.dart';

class JobDetailsBottomSheet extends StatelessWidget {
  final Job job;

  const JobDetailsBottomSheet({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 60,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // First container: Job title, company, and score
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.work_outline,
                                  size: 20,
                                  color: AppColors.primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Text(job.title, style: _headingTextStyle),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.business_outlined,
                                  size: 20,
                                  color: AppColors.primaryColor,
                                ),
                                const SizedBox(width: 8),
                                Text(job.company, style: _subHeadingTextStyle),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${job.matchScore}%',
                                style: Styles.textStyle16.copyWith(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'نسبة التطابق',
                            style: Styles.textStyle13.copyWith(
                              color: AppColors.subHeadingTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Second container: Match reason
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderColor),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.emoji_events_outlined,
                                size: 20,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'سبب التطابق:',
                                style: Styles.textStyle16.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.headingTextColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            job.match,
                            style: _subHeadingTextStyle.copyWith(height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                BlocConsumer<ApplictionCubit, ApplictionState>(
                  listener: (context, state) {
                    if (state is SubmitApplictionError) {
                      CustomSnackBar.showSnackBar(
                          context: context, title: "خطأ", message: state.message, contentType: ContentType.failure);
                    }
                    if (state is SubmitApplictionSuccess) {
                      showCustomDialog(
                        context: context,
                        icon: Icons.check,
                        withAvatar: true,
                        iconColor: Colors.green[400],
                        title: "تم تقديم الطلب",
                        description: "تم تقديم طلبك بنجاح سيتم التحقق من طلبك في اقرب وقت",
                        primaryButtonText: "اذهب الى طلباتي",
                        onPrimaryAction: () {
                          Navigator.pop(context);
                          GoRouter.of(context).push(Routers.kJobApplicationsScreen);
                        },
                        onSecondaryAction: () {
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      isLoading: state is SubmitApplictionLoading,
                      onPressed: () {
                        context.read<ApplictionCubit>().submitOffer(
                              OfferParams(
                                title: job.title,
                                employerId: job.employerId,
                                companyName: job.company,
                              ),
                              job.id,
                            );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.send_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'تقديم على العمل',
                            style: Styles.textStyle16.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  TextStyle get _headingTextStyle => Styles.textStyle18.copyWith(
        color: AppColors.headingTextColor,
        fontWeight: FontWeight.bold,
      );

  TextStyle get _subHeadingTextStyle => Styles.textStyle16.copyWith(
        color: AppColors.subHeadingTextColor,
      );
}

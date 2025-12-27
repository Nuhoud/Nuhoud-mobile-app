import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/utils/functions.dart';
import 'package:nuhoud/core/utils/routs.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/core/widgets/custom_button.dart';
import 'package:nuhoud/core/widgets/custom_snak_bar.dart';
import 'package:nuhoud/features/home/presentation/params/appliction_params.dart';
import 'package:nuhoud/features/home/presentation/view-model/appliction_cubit/appliction_cubit.dart';
import '../../../../data/models/job_model.dart';

class JobDetailsBottomNavBar extends StatelessWidget {
  const JobDetailsBottomNavBar({
    super.key,
    required this.job,
  });

  final JobModel job;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ApplictionCubit, ApplictionState>(
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
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: CustomButton(
            isLoading: state is SubmitApplictionLoading,
            onPressed: () {
              context.read<ApplictionCubit>().submitOffer(
                    OfferParams(
                      title: job.title,
                      employerId: job.employerId,
                      companyName: job.companyName,
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
          ),
        );
      },
    );
  }
}

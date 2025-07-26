import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/core/widgets/custom_error_widget.dart';
import 'package:nuhoud/core/widgets/skeletonizer_helper.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';
import 'package:nuhoud/features/profile/presentation/view-model/cubit/profile_cubit.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/routs.dart';
import '../../../../core/utils/size_app.dart';
import '../../../../core/utils/styles.dart';
import '../../../../core/widgets/custom_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    // Profile items data
    final List<Map<String, dynamic>> profileItems = [
      {
        'title': 'المعلومات الشخصية',
        'icon': Icons.person_outline,
      },
      {
        'title': 'التعليم',
        'icon': Icons.school_outlined,
      },
      {
        'title': 'الخبرات',
        'icon': Icons.work_outline,
      },
      {
        'title': 'المهارات',
        'icon': Icons.workspace_premium_outlined,
      },
      {
        'title': 'الشهادات',
        'icon': Icons.badge_outlined,
      },
      {
        'title': 'الاهداف',
        'icon': Icons.golf_course_rounded,
      },
      {
        'title': 'تفضيلات العمل',
        'icon': Icons.workspace_premium_outlined,
      },
      {
        'title': 'تسجيل الخروج',
        'icon': Icons.logout,
      },
    ];

    return SafeArea(
      bottom: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(response(context, 60)),
          child: const CustomAppBar(
            backBtn: false,
            backgroundColor: AppColors.primaryColor,
            title: 'الملف الشخصي',
          ),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is GetProfileError) {
              return CustomErrorWidget(
                errorMessage: state.message,
                onRetry: () {
                  context.read<ProfileCubit>().getProfile();
                },
              );
            }
            if (state is GetProfileSuccess) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: profileItems.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = profileItems[index];
                          return _buildProfileItem(
                            context: context,
                            title: item['title'],
                            icon: item['icon'],
                            onTap: () {
                              if (item['title'] == 'تسجيل الخروج') {
                                _showLogoutConfirmation(context);
                              }
                              if (item['title'] == 'التعليم') {
                                GoRouter.of(context)
                                    .push(Routers.kProfileEducationPage, extra: state.profile.education);
                              }
                              if (item['title'] == 'المعلومات الشخصية') {
                                GoRouter.of(context)
                                    .push(Routers.kProfileBasicInfoPage, extra: state.profile.basicInfo);
                              }
                              if (item['title'] == 'الخبرات') {
                                GoRouter.of(context)
                                    .push(Routers.kProfileExperiencePage, extra: state.profile.experiences);
                              }
                              if (item['title'] == 'الشهادات') {
                                GoRouter.of(context)
                                    .push(Routers.kProfileCertificationsPage, extra: state.profile.certifications);
                              }
                              if (item['title'] == 'الاهداف') {
                                GoRouter.of(context).push(Routers.kProfileGoalsPage, extra: state.profile.goals);
                              }
                              if (item['title'] == 'تفضيلات العمل') {
                                GoRouter.of(context)
                                    .push(Routers.kProfileJobPreferencesPage, extra: state.profile.jobPreferences);
                              }
                              if (item['title'] == 'المهارات') {
                                GoRouter.of(context).push(
                                  Routers.kProfileSkillsPage,
                                  extra: state.profile.skills,
                                );
                              }
                              if (item['title'] == 'تسجيل الخروج') {
                                _showLogoutConfirmation(context);
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
            return SkeletonizerHelper.profileSkeletonizer();
          },
        ),
      ),
    );
  }

  Widget _buildProfileItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return ProfileItem(
      title: title,
      icon: icon,
      onTap: onTap,
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CustomDialog(
        primaryButtonColor: AppColors.textAlert,
        icon: Icons.warning_rounded,
        title: "تسجيل الخروج",
        description: "هل أنت متأكد أنك تريد تسجيل الخروج؟",
        primaryButtonText: "تسجيل الخروج",
        secondaryButtonText: "إلغاء",
        onPrimaryAction: () {
          GoRouter.of(context).pushReplacement(Routers.kLoginPageRoute);
        },
        onSecondaryAction: () => Navigator.pop(context),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          children: [
            // Circle avatar with icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primaryColor,
                size: 20,
              ),
            ),

            const SizedBox(width: 16),

            // Item title
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.textGrayDark,
              ),
            ),

            const Spacer(),

            // Trailing icon
            const Icon(
              Icons.chevron_right,
              color: AppColors.iconNavBarColor,
            ),
          ],
        ),
      ),
    );
  }
}

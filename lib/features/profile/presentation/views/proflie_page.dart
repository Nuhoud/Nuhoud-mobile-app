import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/routs.dart';
import '../../../../core/utils/size_app.dart';
import '../../../../core/utils/styles.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile items list
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
                        // Handle item tap
                        if (item['title'] == 'تسجيل الخروج') {
                          _showLogoutConfirmation(context);
                        }
                        if (item['title'] == 'التعليم') {
                          List<Education> educations = [];
                          educations.add(Education(
                            degree: "بكالوريوس",
                            field: "علوم",
                            university: "جامعة القاهرة",
                            endYear: 2022,
                            gpa: 4.0,
                          ));
                          educations.add(Education(
                            degree: "ماستر",
                            field: "علوم",
                            university: "جامعة القاهرة",
                            endYear: 2022,
                            gpa: 4.0,
                          ));
                          GoRouter.of(context).push(Routers.kProfileEducationPage, extra: educations);
                        }
                        if (item['title'] == 'المعلومات الشخصية') {
                          GoRouter.of(context).push(Routers.kProfileBasicInfoPage, extra: {
                            BasicInfo(
                                gender: "ذكر",
                                dateOfBirth: "1990-01-01",
                                location: "القاهرة",
                                languages: ["العربية", "الإنجليزية"])
                          });
                        }
                        if (item['title'] == 'الخبرات') {
                          List<Experience> experiences = [];
                          experiences.add(Experience(
                            company: "شركة",
                            jobTitle: "وظيفة",
                            startDate: "2022-01-01",
                            endDate: "2022-01-01",
                            description: "وصف",
                            location: "القاهرة",
                            isCurrent: false,
                          ));
                          experiences.add(Experience(
                            company: "شركة",
                            jobTitle: "وظيفة",
                            startDate: "2022-01-01",
                            endDate: "2022-01-01",
                            description: "وصف",
                            location: "القاهرة",
                            isCurrent: true,
                          ));
                          GoRouter.of(context).push(Routers.kProfileExperiencePage, extra: experiences);
                        }
                        if (item['title'] == 'الشهادات') {}
                        if (item['title'] == 'الاهداف') {
                          //GoRouter.of(context).push(Routers.kProfileGoalsPage);
                        }
                        if (item['title'] == 'تفضيلات العمل') {
                          //GoRouter.of(context).push(Routers.kProfileJobPreferencesPage);
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

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Icon(Icons.warning_amber_outlined, color: AppColors.textAlert, size: 50),
        content: Text('هل أنت متأكد أنك تريد تسجيل الخروج؟',
            style: Styles.textStyle16.copyWith(color: AppColors.textGrayDark)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: Styles.textStyle16),
          ),
          TextButton(
            onPressed: () {
              GoRouter.of(context).push(
                Routers.kLoginPageRoute,
              );
            },
            child: Text(
              'تسجيل الخروج',
              style: Styles.textStyle16.copyWith(color: AppColors.textAlert),
            ),
          ),
        ],
      ),
    );
  }
}

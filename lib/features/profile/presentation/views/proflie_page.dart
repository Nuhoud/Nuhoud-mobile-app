import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';

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
        'title': 'الشروط والاحكام',
        'icon': Icons.description_outlined,
      },
      {
        'title': 'سياسة الخصوصية',
        'icon': Icons.privacy_tip_outlined,
      },
      {
        'title': 'تسجيل الخروج',
        'icon': Icons.logout,
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header text
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(
                    'الملف الشخصي',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.headingTextColor,
                    ),
                  ),
                ),

                // Profile items list
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profileItems.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = profileItems[index];
                    return _buildProfileItem(
                      context: context,
                      title: item['title'],
                      icon: item['icon'],
                      onTap: () {
                        // Handle item tap
                        print('Tapped on: ${item['title']}');
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
        title: const Text('تأكيد تسجيل الخروج'),
        content: const Text('هل أنت متأكد أنك تريد تسجيل الخروج؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'تسجيل الخروج',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

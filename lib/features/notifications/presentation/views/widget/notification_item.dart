import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/styles.dart';
import 'package:nuhoud/features/notifications/data/models/notification_model.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.notification, this.onTap});

  final NotificationModel notification;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black.withValues(alpha: 0.03),
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title.isNotEmpty ? notification.title : 'اشعار',
                    style: Styles.textStyle16
                        .copyWith(color: AppColors.headingTextColor, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notification.body,
                    style: Styles.textStyle15.copyWith(color: AppColors.subHeadingTextColor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _formatTimestamp(notification.createdAt),
                    style: Styles.textStyle13.copyWith(color: AppColors.textGrayLight),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textGrayLight,
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime dateTime) {
    final localDate = dateTime.toLocal();
    final now = DateTime.now();
    final diff = now.difference(localDate);

    if (diff.isNegative) {
      return DateFormat('yyyy/MM/dd  HH:mm').format(localDate);
    }

    if (diff.inDays == 0) {
      if (diff.inMinutes < 1) return 'الآن';
      if (diff.inMinutes < 60) return _formatArabicPlural(diff.inMinutes, 'دقيقة', 'دقيقتين', 'دقائق');
      return _formatArabicPlural(diff.inHours, 'ساعة', 'ساعتين', 'ساعات');
    }

    if (diff.inDays == 1) return 'الأمس';
    if (diff.inDays < 7) return _formatArabicPlural(diff.inDays, 'يوم', 'يومين', 'أيام');

    return DateFormat('yyyy/MM/dd  HH:mm').format(localDate);
  }

  String _formatArabicPlural(int value, String one, String two, String many) {
    if (value == 1) return 'منذ $one';
    if (value == 2) return 'منذ $two';
    return 'منذ $value $many';
  }
}

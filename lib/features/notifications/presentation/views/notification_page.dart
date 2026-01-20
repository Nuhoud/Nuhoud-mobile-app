import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/utils/services_locater.dart';
import 'package:nuhoud/core/utils/size_app.dart';
import 'package:nuhoud/core/widgets/custom_app_bar.dart';
import 'package:nuhoud/features/notifications/presentation/view-model/notification_cubit.dart';
import 'package:nuhoud/features/notifications/presentation/views/widget/notification_page_body.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getit.get<NotificationCubit>()..getNotifications(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(response(context, 60)),
          child: const SafeArea(
            child: CustomAppBar(
              backBtn: true,
              backgroundColor: AppColors.primaryColor,
              title: 'الاشعارات',
            ),
          ),
        ),
        body: const NotificationPageBody(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nuhoud/core/notification_services/notification_navigation_helper.dart';
import 'package:nuhoud/core/utils/app_colors.dart';
import 'package:nuhoud/core/widgets/custom_error_widget.dart';
import 'package:nuhoud/core/widgets/loading_widget.dart';
import 'package:nuhoud/features/notifications/data/models/notification_model.dart';
import 'package:nuhoud/features/notifications/presentation/view-model/notification_cubit.dart';
import 'package:nuhoud/features/notifications/presentation/views/widget/notification_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationPageBody extends StatefulWidget {
  const NotificationPageBody({super.key});

  @override
  State<NotificationPageBody> createState() => _NotificationPageBodyState();
}

class _NotificationPageBodyState extends State<NotificationPageBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final threshold = 200;
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - threshold) {
      context.read<NotificationCubit>().getNotifications(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotificationCubit>();
    return BlocBuilder<NotificationCubit, NotificationState>(
      builder: (context, state) {
        final isInitialLoading =
            state is NotificationInitial || (state is GetNotificationsLoading && state.isFirstFetch);
        if (isInitialLoading) {
          return _buildSkeleton();
        }

        if (state is GetNotificationsFailure) {
          return CustomErrorWidget(
            errorMessage: state.message,
            onRetry: () => cubit.getNotifications(loadMore: false),
          );
        }

        final notifications = state is GetNotificationsSuccess ? state.notifications : cubit.notifications;
        if (notifications.isEmpty) {
          return const Center(
            child: Text(
              'لا توجد اشعارات حالياً',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        final isLoadingMore = state is GetNotificationsLoading && !state.isFirstFetch;

        return RefreshIndicator(
          onRefresh: () => cubit.getNotifications(loadMore: false),
          color: AppColors.primaryColor,
          backgroundColor: AppColors.backgroundColor,
          child: ListView.separated(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: notifications.length + (isLoadingMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= notifications.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: LoadingWidget(),
                );
              }
              final notification = notifications[index];
              return NotificationItem(
                notification: notification,
                onTap: () => _handleNotificationTap(notification),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 12),
          ),
        );
      },
    );
  }

  void _handleNotificationTap(NotificationModel notification) {
    final payload = notification.data;
    if (payload?.screen != null && payload!.screen!.isNotEmpty) {
      NotificationNavigationHelper.handle(router: GoRouter.of(context), data: payload.toJson());
    }
  }

  Widget _buildSkeleton() {
    return Skeletonizer(
      enabled: true,
      justifyMultiLineText: true,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: 6,
        itemBuilder: (context, index) => NotificationItem(
          notification: NotificationModel(
            id: '$index',
            title: 'عنوان الإشعار',
            body: 'هذا نص اشعار تجريبي للتأكد من شكل التصميم',
            data: NotificationPayload(),
            createdAt: DateTime.now(),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
      ),
    );
  }
}

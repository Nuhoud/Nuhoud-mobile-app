import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nuhoud/features/notifications/data/models/notification_model.dart';
import 'package:nuhoud/features/notifications/data/repos/notification_repo.dart';
import 'package:nuhoud/features/notifications/presentation/params/notification_params.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.notificationRepo) : super(NotificationInitial());

  final NotificationRepo notificationRepo;
  final List<NotificationModel> notifications = [];
  final int _limit = 10;

  String? _nextCursor;
  bool _hasMore = true;
  bool _isFetching = false;

  bool get hasMore => _hasMore;

  Future<void> getNotifications({bool loadMore = false}) async {
    if (_isFetching || isClosed) return;
    if (loadMore && !_hasMore) return;

    _isFetching = true;
    if (!loadMore) {
      _nextCursor = null;
      _hasMore = true;
      notifications.clear();
    }

    emit(GetNotificationsLoading(isFirstFetch: !loadMore));

    try {
      final result = await notificationRepo
          .getNotifications(NotificationParams(limit: _limit, nextCursor: _nextCursor));
      if (isClosed) return;
      result.fold((failure) {
        emit(GetNotificationsFailure(message: failure.message));
      }, (notificationResponse) {
        notifications.addAll(notificationResponse.notifications);
        _nextCursor = notificationResponse.nextCursor;
        _hasMore = notificationResponse.hasMore && notificationResponse.nextCursor != null;
        emit(GetNotificationsSuccess(notifications: List.unmodifiable(notifications), hasMore: _hasMore));
      });
    } finally {
      _isFetching = false;
    }
  }
}

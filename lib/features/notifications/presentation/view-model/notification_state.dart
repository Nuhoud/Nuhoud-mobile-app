part of 'notification_cubit.dart';

sealed class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

final class GetNotificationsLoading extends NotificationState {
  final bool isFirstFetch;

  const GetNotificationsLoading({required this.isFirstFetch});

  @override
  List<Object> get props => [isFirstFetch];
}

final class GetNotificationsSuccess extends NotificationState {
  final List<NotificationModel> notifications;
  final bool hasMore;

  const GetNotificationsSuccess({required this.notifications, required this.hasMore});

  @override
  List<Object> get props => [notifications, hasMore];
}

final class GetNotificationsFailure extends NotificationState {
  final String message;

  const GetNotificationsFailure({required this.message});

  @override
  List<Object> get props => [message];
}

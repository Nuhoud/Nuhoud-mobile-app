part of 'user_plan_cubit.dart';

sealed class UserPlanState extends Equatable {
  const UserPlanState();

  @override
  List<Object> get props => [];
}

final class UserPlanInitial extends UserPlanState {}

final class UserPlanLoading extends UserPlanState {}

final class UserPlanSuccess extends UserPlanState {
  final UserPlanModel userPlanModel;
  const UserPlanSuccess({required this.userPlanModel});

  @override
  List<Object> get props => [userPlanModel];
}

final class UserPlanError extends UserPlanState {
  final String message;
  const UserPlanError({required this.message});

  @override
  List<Object> get props => [message];
}

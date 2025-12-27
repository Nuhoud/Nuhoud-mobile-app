part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class GetJobsLoading extends HomeState {
  final bool isFirstLoading;
  const GetJobsLoading({required this.isFirstLoading});
}

final class GetJobsSuccess extends HomeState {
  final List<JobModel> jobs;
  const GetJobsSuccess({required this.jobs});
}

final class GetJobsFailure extends HomeState {
  final String message;
  const GetJobsFailure({required this.message});
}

final class GetJobDetailsLoading extends HomeState {
  const GetJobDetailsLoading();
}

final class GetJobDetailsSuccess extends HomeState {
  final JobModel job;
  const GetJobDetailsSuccess({required this.job});
}

final class GetJobDetailsFailure extends HomeState {
  final String message;
  const GetJobDetailsFailure({required this.message});
}

final class UpdateFcmTokenSuccess extends HomeState {
  const UpdateFcmTokenSuccess();
}

final class UpdateFcmTokenFailure extends HomeState {
  final String message;
  const UpdateFcmTokenFailure({required this.message});
}

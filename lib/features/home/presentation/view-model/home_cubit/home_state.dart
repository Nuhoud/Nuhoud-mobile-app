part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class FilterUpdated extends HomeState {}

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

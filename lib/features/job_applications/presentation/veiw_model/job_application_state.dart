part of 'job_application_cubit.dart';

sealed class JobApplicationState extends Equatable {
  const JobApplicationState();

  @override
  List<Object> get props => [];
}

final class JobApplicationInitial extends JobApplicationState {}

final class JobApplicationSuccess extends JobApplicationState {
  final List<JobApplication> jobApplication;

  const JobApplicationSuccess(this.jobApplication);
}

final class JobApplicationError extends JobApplicationState {
  final String message;

  const JobApplicationError(this.message);
}

final class JobApplicationLoading extends JobApplicationState {}

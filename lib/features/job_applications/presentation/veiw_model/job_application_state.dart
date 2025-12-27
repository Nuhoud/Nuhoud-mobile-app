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

final class JobApplicationDetailsSuccess extends JobApplicationState {
  final JobApplication jobApplication;

  const JobApplicationDetailsSuccess(this.jobApplication);
}

final class JobApplicationDetailsError extends JobApplicationState {
  final String message;

  const JobApplicationDetailsError(this.message);
}

final class JobApplicationDetailsLoading extends JobApplicationState {}

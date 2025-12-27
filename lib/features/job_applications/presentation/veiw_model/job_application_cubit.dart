import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nuhoud/core/shared/params/paginations_params.dart';
import 'package:nuhoud/features/job_applications/data/models/job_application_model.dart';
import 'package:nuhoud/features/job_applications/data/repos/job_applications_repo.dart';

part 'job_application_state.dart';

class JobApplicationCubit extends Cubit<JobApplicationState> {
  final JobApplicationsRepo jobApplicationsRepo;
  JobApplicationCubit(this.jobApplicationsRepo) : super(JobApplicationInitial());
  Future<void> getMyJobApplications() async {
    emit(JobApplicationLoading());
    final result = await jobApplicationsRepo.getMyJobApplications(PaginationsParams(page: 1, perPage: 50));
    result.fold((f) => emit(JobApplicationError(f.message)), (data) {
      emit(JobApplicationSuccess(data.data ?? []));
    });
  }

  Future<void> getJobApplicationDetails(String applicationId) async {
    emit(JobApplicationLoading());
    final result = await jobApplicationsRepo.getJobApplicationDetails(applicationId);
    result.fold((f) => emit(JobApplicationError(f.message)), (data) {
      emit(JobApplicationDetailsSuccess(data));
    });
  }
}

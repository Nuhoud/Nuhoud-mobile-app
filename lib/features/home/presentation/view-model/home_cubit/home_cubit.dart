import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nuhoud/features/home/data/models/job_model.dart';
import 'package:nuhoud/features/home/data/repos/home_repo.dart';
import 'package:nuhoud/features/home/presentation/params/job_params.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());
  final HomeRepo homeRepo;
  String? filterLocation;
  String? filterCompany;
  String? filterMinSalary;
  String? filterMaxSalary;
  String? filterCurrency;
  String? filterJobType;
  String? filterWorkPlaceType;
  String? filterExperienceLevel;
  String? filterSortBy;
  String? filterSortOrder;
  String? search;
  List<String> filterSkills = [];

  List<JobModel> jobs = [];
  bool isFetchingJobs = false;
  bool hasReachedMax = false;
  int _currentPage = 1;

  Future<void> getJobs({bool loadMore = false}) async {
    try {
      if (isFetchingJobs || isClosed || (hasReachedMax && loadMore)) return;
      isFetchingJobs = true;
      if (!loadMore) {
        _currentPage = 1;
        hasReachedMax = false;
        jobs.clear();
      }
      if (!isClosed) {
        emit(GetJobsLoading(isFirstLoading: !loadMore));
      }
      final result = await homeRepo.getJobs(
          JobParams(
            page: _currentPage,
            search: search,
            workPlaceType: filterWorkPlaceType,
            jobType: filterJobType,
            jobLocation: filterLocation,
            companyName: filterCompany,
            experienceLevel: filterExperienceLevel,
            skillsRequired: filterSkills,
            salaryMin: filterMinSalary,
            salaryMax: filterMaxSalary,
            currency: filterCurrency,
            sortBy: filterSortBy,
            orderBy: filterSortOrder,
          ),
          isSearch: search != null);
      if (isClosed) return;
      result.fold((failure) {
        emit(GetJobsFailure(message: failure.message));
      }, (jobDataModel) {
        _currentPage++;
        hasReachedMax = jobDataModel.currentPage == jobDataModel.totalPages;
        jobs = [...jobs, ...jobDataModel.jobs];
        emit(GetJobsSuccess(jobs: jobs));
      });
    } finally {
      isFetchingJobs = false;
    }
  }

  Future<void> getJobDetails(String jobId) async {
    emit(const GetJobDetailsLoading());
    final result = await homeRepo.getJobDetails(jobId);
    result.fold((failure) {
      emit(GetJobDetailsFailure(message: failure.message));
    }, (jobModel) {
      emit(GetJobDetailsSuccess(job: jobModel));
    });
  }

  void resetFilter() {
    filterLocation = null;
    filterCompany = null;
    filterMinSalary = null;
    filterMaxSalary = null;
    filterCurrency = null;
    filterJobType = null;
    filterWorkPlaceType = null;
    filterExperienceLevel = null;
    filterSortBy = null;
    filterSortOrder = null;
    search = null;
    filterSkills.clear();
    emit(HomeInitial());
  }

  void addSkill() {
    filterSkills.add('');
  }

  void removeSkill(int index) {
    if (index >= 0 && index < filterSkills.length) {
      filterSkills.removeAt(index);
    }
  }

  void updateSkill(int index, String value) {
    if (index >= 0 && index < filterSkills.length) {
      filterSkills[index] = value;
    }
  }
}

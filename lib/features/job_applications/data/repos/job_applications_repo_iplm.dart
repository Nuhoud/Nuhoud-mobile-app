import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nuhoud/core/api_services/api_services.dart';
import 'package:nuhoud/core/api_services/urls.dart';
import 'package:nuhoud/core/errors/error_handler.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/core/shared/params/paginations_params.dart';
import 'package:nuhoud/features/job_applications/data/models/job_application_model.dart';
import 'package:nuhoud/features/job_applications/data/repos/job_applications_repo.dart';

class JobApplicationsRepoImpl implements JobApplicationsRepo {
  final ApiServices apiServices;

  JobApplicationsRepoImpl(this.apiServices);
  @override
  Future<Either<Failure, JobApplicationModel>> getMyJobApplications(PaginationsParams paginationsParams) async {
    try {
      final response = await apiServices.get(
          endPoint: Urls.getMyJobApplications,
          queryParameters: {"limit": paginationsParams.perPage, "page": paginationsParams.page});
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jobApplication = JobApplicationModel.fromJson(response.data);
        return Right(jobApplication);
      }
      return Left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint("get user plan error:${e.toString()}");
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, JobApplication>> getJobApplicationDetails(String applicationId) async {
    try {
      final response = await apiServices.get(
        endPoint: "${Urls.getJobApplicationDetails}/$applicationId",
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final jobApplication = JobApplication.fromJson(response.data);
        return Right(jobApplication);
      }
      return Left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint("get user plan error:${e.toString()}");
      return Left(ErrorHandler.handle(e));
    }
  }
}

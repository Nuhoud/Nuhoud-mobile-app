import 'package:dartz/dartz.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/core/shared/params/paginations_params.dart';
import 'package:nuhoud/features/job_applications/data/models/job_application_model.dart';

abstract class JobApplicationsRepo {
  Future<Either<Failure, JobApplicationModel>> getMyJobApplications(PaginationsParams paginationsParams);
  Future<Either<Failure, JobApplication>> getJobApplicationDetails(String applicationId);
}

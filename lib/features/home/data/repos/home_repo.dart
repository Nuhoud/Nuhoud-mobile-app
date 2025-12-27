import 'package:dartz/dartz.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/features/home/data/models/job_data_model.dart';
import 'package:nuhoud/features/home/data/models/job_model.dart';
import 'package:nuhoud/features/home/presentation/params/job_params.dart';

abstract class HomeRepo {
  Future<Either<Failure, JobDataModel>> getJobs(JobParams params, {bool isSearch = false});
  Future<Either<Failure, JobModel>> getJobDetails(String jobId);
}

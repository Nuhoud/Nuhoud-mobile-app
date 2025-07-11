import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:nuhoud/core/api_services/api_services.dart';
import 'package:nuhoud/core/api_services/urls.dart';
import 'package:nuhoud/core/errors/error_handler.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/features/home/data/models/job_data_model.dart';
import 'package:nuhoud/features/home/data/repos/home_repo.dart';
import 'package:nuhoud/features/home/presentation/params/job_params.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiServices apiServices;
  HomeRepoImpl(this.apiServices);
  @override
  Future<Either<Failure, JobDataModel>> getJobs(JobParams params, {bool isSearch = false}) async {
    Urls.isJobUrl = true;
    try {
      final response = await apiServices.get(
          endPoint: isSearch ? Urls.getSearchJobs : Urls.getJobs, queryParameters: params.toMap());
      final jobDataModel = JobDataModel.fromJson(response.data);
      if (_isSuccess(response.statusCode)) {
        return Right(jobDataModel);
      } else {
        return Left(ServerFailure(ErrorHandler.defaultMessage()));
      }
    } catch (e) {
      debugPrint("get jobs error: ${e.toString()}");
      return Left(ErrorHandler.handle(e));
    } finally {
      Urls.isJobUrl = false;
    }
  }

  bool _isSuccess(int? statusCode) => (statusCode == 200 || statusCode == 201);
}

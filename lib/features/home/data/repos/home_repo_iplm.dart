import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nuhoud/core/api_services/api_services.dart';
import 'package:nuhoud/core/api_services/urls.dart';
import 'package:nuhoud/core/errors/error_handler.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/core/utils/cache_helper.dart';
import 'package:nuhoud/features/home/data/models/job_data_model.dart';
import 'package:nuhoud/features/home/data/models/job_model.dart';
import 'package:nuhoud/features/home/data/repos/home_repo.dart';
import 'package:nuhoud/features/home/presentation/params/fcm_params.dart';
import 'package:nuhoud/features/home/presentation/params/job_params.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiServices apiServices;
  HomeRepoImpl(this.apiServices);
  @override
  Future<Either<Failure, JobDataModel>> getJobs(JobParams params, {bool isSearch = false}) async {
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
    }
  }

  @override
  Future<Either<Failure, JobModel>> getJobDetails(String jobId) async {
    try {
      final response = await apiServices.get(endPoint: "${Urls.getJobDetails}/$jobId");
      final jobModel = JobModel.fromJson(response.data);
      if (_isSuccess(response.statusCode)) {
        return Right(jobModel);
      } else {
        return Left(ServerFailure(ErrorHandler.defaultMessage()));
      }
    } catch (e) {
      debugPrint("get job details error: ${e.toString()}");
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> updateFcmToken(FcmParams params) async {
    try {
      Map<String, String> headers() {
        return {
          'Authorization': "Bearer ${CacheHelper.getData(key: 'token')}",
          'Content-Type': 'application/json',
          "Accept": 'application/json',
          "Accept-Charset": "application/json",
        };
      }

      final Dio dio = Dio(BaseOptions(
          baseUrl: Urls.mainBaseUrl,
          connectTimeout: const Duration(minutes: 1),
          sendTimeout: const Duration(minutes: 1),
          receiveTimeout: const Duration(minutes: 1)));
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          request: true,
          compact: true,
          maxWidth: 10000));
      final response = await dio.post(Urls.updateFcmToken, data: params.toJson(), options: Options(headers: headers()));
      if (response.statusCode == 204) {
        return const Right(null);
      } else {
        return Left(ServerFailure(ErrorHandler.defaultMessage()));
      }
    } catch (e) {
      debugPrint("update fcm token error: ${e.toString()}");
      return Left(ErrorHandler.handle(e));
    }
  }

  bool _isSuccess(int? statusCode) => (statusCode == 200 || statusCode == 201);
}

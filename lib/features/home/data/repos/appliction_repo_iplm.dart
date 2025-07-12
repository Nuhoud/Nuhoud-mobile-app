import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:nuhoud/core/api_services/api_services.dart';
import 'package:nuhoud/core/api_services/urls.dart';
import 'package:nuhoud/core/errors/error_handler.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/features/home/data/repos/appliction_repo.dart';
import 'package:nuhoud/features/home/presentation/params/appliction_params.dart';

class ApplicationRepoImpl implements ApplicationRepo {
  final ApiServices apiServices;
  ApplicationRepoImpl(this.apiServices);

  @override
  Future<Either<Failure, void>> submitOffer(OfferParams params, String jobId) async {
    try {
      final response = await apiServices.post(endPoint: "${Urls.submitOffer}/$jobId", data: params.toJson());
      if (_isSuccess(response.statusCode)) {
        return const Right(null);
      } else {
        return Left(ServerFailure(ErrorHandler.defaultMessage()));
      }
    } catch (e) {
      debugPrint("submit offer error: ${e.toString()}");
      return Left(ErrorHandler.handle(e));
    }
  }

  bool _isSuccess(int? statusCode) => (statusCode == 200 || statusCode == 201);
}

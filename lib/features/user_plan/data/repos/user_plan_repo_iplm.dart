import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nuhoud/core/api_services/api_services.dart';
import 'package:nuhoud/core/api_services/urls.dart';
import 'package:nuhoud/core/errors/error_handler.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/features/user_plan/data/models/user_plan_model.dart';
import 'package:nuhoud/features/user_plan/data/repos/user_plan_repo.dart';

class UserPlanRepoImpl implements UserPlanRepo {
  final ApiServices apiServices;
  UserPlanRepoImpl(this.apiServices);
  @override
  Future<Either<Failure, UserPlanModel>> getUserPlan() async {
    try {
      final response = await apiServices.get(endPoint: Urls.getUserPlan);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final userPlanModel = UserPlanModel.fromJson(response.data);
        return Right(userPlanModel);
      }
      return Left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint("get user plan error:${e.toString()}");
      return Left(ErrorHandler.handle(e));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/features/user_plan/data/models/user_plan_model.dart';

abstract class UserPlanRepo {
  Future<Either<Failure, UserPlanModel>> getUserPlan();
}

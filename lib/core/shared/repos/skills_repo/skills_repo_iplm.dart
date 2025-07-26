import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nuhoud/core/api_services/api_services.dart';
import 'package:nuhoud/core/api_services/urls.dart';
import 'package:nuhoud/core/errors/error_handler.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/core/shared/repos/skills_repo/skills_repo.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';

class SkillsRepoImpl implements SkillsRepo {
  final ApiServices apiServices;

  SkillsRepoImpl(this.apiServices);
  @override
  Future<Either<Failure, Skills>> getSkills() async {
    try {
      final response = await apiServices.get(endPoint: Urls.getSkills);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final skills = Skills.fromJson(response.data['data']);
        return Right(skills);
      }
      return Left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint("get user plan error:${e.toString()}");
      return Left(ErrorHandler.handle(e));
    }
  }
}

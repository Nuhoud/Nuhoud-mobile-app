import 'package:dartz/dartz.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';

abstract class SkillsRepo {
  Future<Either<Failure, Skills>> getSkills();
}

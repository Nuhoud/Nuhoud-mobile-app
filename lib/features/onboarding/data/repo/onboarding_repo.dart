import 'package:dartz/dartz.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';

abstract class OnboardingRepo {
  Future<Either<Failure, void>> saveUserInfo(Map<String, dynamic> data);
  Future<Either<Failure, void>> saveUserSkills(Skills skills);
}

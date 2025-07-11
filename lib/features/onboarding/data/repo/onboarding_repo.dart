import 'package:dartz/dartz.dart';
import 'package:nuhoud/core/errors/failuer.dart';

abstract class OnboardingRepo {
  Future<Either<Failure, void>> saveUserInfo(Map<String, dynamic> data);
}

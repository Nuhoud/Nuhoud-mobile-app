import 'package:dartz/dartz.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileModel>> getProfile();
  Future<Either<Failure, ProfileModel>> updateProfile(ProfileModel profile);
}

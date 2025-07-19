import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nuhoud/core/api_services/api_services.dart';
import 'package:nuhoud/core/api_services/urls.dart';
import 'package:nuhoud/core/errors/error_handler.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';
import 'package:nuhoud/features/profile/data/repos/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepo {
  final ApiServices apiServices;
  ProfileRepoImpl(this.apiServices);
  @override
  Future<Either<Failure, ProfileModel>> getProfile() async {
    try {
      final response = await apiServices.get(endPoint: Urls.getProfile);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final profileModel = ProfileModel.fromJson(response.data);
        return Right(profileModel);
      }
      return Left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint("get profile error:${e.toString()}");
      return Left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, ProfileModel>> updateProfile(ProfileModel profile) async {
    try {
      final response = await apiServices.patch(endPoint: Urls.getProfile, data: profile.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final profileModel = ProfileModel.fromJson(response.data);
        return Right(profileModel);
      }
      return Left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint("update profile error:${e.toString()}");
      return Left(ErrorHandler.handle(e));
    }
  }
}

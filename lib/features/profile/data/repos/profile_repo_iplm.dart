import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nuhoud/core/api_services/api_services.dart';
import 'package:nuhoud/core/api_services/urls.dart';
import 'package:nuhoud/core/errors/error_handler.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/core/utils/cache_helper.dart';
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

  @override
  Future<Either<Failure, String>> updateProfilePhoto(File photo) async {
    try {
      final fileName = photo.uri.pathSegments.isNotEmpty ? photo.uri.pathSegments.last : 'profile_photo.jpg';
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(photo.path, filename: fileName),
      });
      final response = await apiServices.postMultipart(endPoint: Urls.updateProfilePhoto, data: formData);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final rawUrl = response.data['url'] as String?;
        if (rawUrl != null) {
          final uri = Uri.parse(rawUrl);
          final normalized = uri.host == 'localhost' ? uri.replace(host: '10.0.2.2').toString() : rawUrl;
          await CacheHelper.setString(key: profilePhotoCacheKey, value: normalized);
          return Right(normalized);
        }
      }
      return Left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint("update profile photo error:${e.toString()}");
      return Left(ErrorHandler.handle(e));
    }
  }
}

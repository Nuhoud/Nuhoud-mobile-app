import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:nuhoud/core/api_services/api_services.dart';
import 'package:nuhoud/core/api_services/urls.dart' show Urls;
import 'package:nuhoud/core/errors/error_handler.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/features/onboarding/data/repo/onboarding_repo.dart';

class OnboardingRepoImpl implements OnboardingRepo {
  final ApiServices apiServices;
  OnboardingRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, void>> saveUserInfo(Map<String, dynamic> data) async {
    try {
      final response = await apiServices.post(
        endPoint: Urls.saveUserInfoStepOne,
        data: data,
      );
      if (_isSuccessResponse(response)) {
        return const Right(null);
      }
      return Left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint('Save user info error: $e');
      return Left(ErrorHandler.handle(e));
    }
  }

  bool _isSuccessResponse(dynamic response) {
    return (response.statusCode == 200 || response.statusCode == 201) && response.data['success'] as bool;
  }
}

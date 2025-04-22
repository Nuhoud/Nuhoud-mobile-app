import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:nuhoud/core/utils/cache_helper.dart';
import 'package:nuhoud/features/auth/data/repo/auth_repo.dart';

import '../../../../core/api_services/api_services.dart';
import '../../../../core/api_services/urls.dart';
import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failuer.dart';
import '../../../../core/utils/enums.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiServices _apiServices;

  AuthRepoImpl(this._apiServices);

  @override
  Future<Either<Failure, void>> login({
    required String emailOrPhone,
    required String password,
    required AuthType authType,
  }) async {
    try {
      final response = await _apiServices.post(endPoint: Urls.login, data: {
        'identifier': emailOrPhone,
        'password': password,
      }, queryParameters: {
        "isMobile": _getAuthType(authType)
      });
      if (_isSuccessResponse(response.statusCode)) {
        final token = response.data['access_token'] as String;
        _saveUserInfo(token);
        return right(null);
      }
      return left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint('Login error: $e');
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, String>> register({
    required String name,
    required String emailOrPhone,
    required String password,
    required AuthType authType,
  }) async {
    try {
      final response = await _apiServices.post(endPoint: Urls.register, data: {
        'name': name,
        'identifier': emailOrPhone,
        'password': password,
      }, queryParameters: {
        "isMobile": _getAuthType(authType)
      });
      if (_isSuccessResponse(response.statusCode)) {
        final identifier = response.data['identifier'] as String;
        return right(identifier);
      }
      return left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint('Register error: $e');
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp({
    required String identifier,
    required String otp,
    required AuthType authType,
  }) async {
    try {
      final response = await _apiServices.post(
        endPoint: Urls.verifyOtp,
        data: {
          'identifier': identifier,
          'otp': otp,
        },
        queryParameters: {
          "isMobile": _getAuthType(authType),
        },
      );
      if (_isSuccessResponse(response.statusCode)) {
        final token = response.data['access_token'] as String;
        _saveUserInfo(token);
        return right(null);
      }
      return left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint('Verify OTP error: $e');
      return left(ErrorHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, void>> resendOtp({
    required String identifier,
    required AuthType authType,
  }) async {
    try {
      final response = await _apiServices.post(
        endPoint: Urls.resendOtp,
        data: {
          'identifier': identifier,
        },
        queryParameters: {
          "isMobile": _getAuthType(authType),
        },
      );
      if (_isSuccessResponse(response.statusCode)) {
        return right(null);
      }
      return left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint('Resend OTP error: $e');
      return left(ErrorHandler.handle(e));
    }
  }

  bool _getAuthType(AuthType authType) {
    return authType == AuthType.phone;
  }

  bool _isSuccessResponse(int? statusCode) {
    return statusCode == 200 || statusCode == 201;
  }

  void _saveUserInfo(String token) async {
    await CacheHelper.setString(key: 'token', value: token);
  }
}

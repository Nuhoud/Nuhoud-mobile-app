import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
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
  Future<Either<Failure, String>> login({
    required String emailOrPhone,
    required String password,
    required AuthType authType,
  }) async {
    try {
      final response = await _apiServices.post(
        endPoint: Urls.login,
        data: {
          _getAuthType(authType): emailOrPhone,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        final token = response.data['access_token'] as String;
        return right(token);
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
      final response = await _apiServices.post(
        endPoint: Urls.register,
        data: {
          'name': name,
          _getAuthType(authType): emailOrPhone,
          'password': password,
          'userType': 'normal'
        },
      );
      if (response.statusCode == 200) {
        final registeredEmail = response.data['email'] as String;
        return right(registeredEmail);
      }
      return left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint('Register error: $e');
      return left(ErrorHandler.handle(e));
    }
  }

  String _getAuthType(AuthType authType) {
    return authType == AuthType.email ? "email" : "phone";
  }
}

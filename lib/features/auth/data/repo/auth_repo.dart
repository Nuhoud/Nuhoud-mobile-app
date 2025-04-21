import 'package:dartz/dartz.dart';

import '../../../../core/errors/failuer.dart';
import '../../../../core/utils/enums.dart';

abstract class AuthRepo {
  Future<Either<Failure, void>> login({
    required String emailOrPhone,
    required String password,
    required AuthType authType,
  });

  Future<Either<Failure, void>> register({
    required String name,
    required String emailOrPhone,
    required String password,
    required AuthType authType,
  });

  Future<Either<Failure, void>> verifyOtp({
    required String identifier,
    required String otp,
    required AuthType authType,
  });

  Future<Either<Failure, void>> resendOtp({
    required String identifier,
    required AuthType authType,
  });
}

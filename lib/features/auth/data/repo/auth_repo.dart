import 'package:dartz/dartz.dart';

import '../../../../core/errors/failuer.dart';
import '../../../../core/utils/enums.dart';

abstract class AuthRepo {
  /// Performs login and returns either a [Failure] or the access token string
  Future<Either<Failure, String>> login({
    required String emailOrPhone,
    required String password,
    required AuthType authType,
  });

  /// Performs registration and returns either a [Failure] or the registered email
  Future<Either<Failure, String>> register({
    required String name,
    required String emailOrPhone,
    required String password,
    required AuthType authType,
  });
}

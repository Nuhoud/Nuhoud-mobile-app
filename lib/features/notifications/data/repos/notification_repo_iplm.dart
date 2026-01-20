import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:nuhoud/core/api_services/api_services.dart';
import 'package:nuhoud/core/api_services/urls.dart';
import 'package:nuhoud/core/errors/error_handler.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/features/notifications/data/models/notification_model.dart';
import 'package:nuhoud/features/notifications/data/repos/notification_repo.dart';
import 'package:nuhoud/features/notifications/presentation/params/notification_params.dart';

class NotificationRepoImpl implements NotificationRepo {
  final ApiServices apiServices;

  NotificationRepoImpl(this.apiServices);

  @override
  Future<Either<Failure, NotificationResponseModel>> getNotifications(NotificationParams params) async {
    try {
      final response = await apiServices.get(endPoint: Urls.getNotifications, queryParameters: params.toMap());
      if (_isSuccess(response.statusCode)) {
        final notifications = NotificationResponseModel.fromJson(response.data);
        return Right(notifications);
      }
      return Left(ServerFailure(ErrorHandler.defaultMessage()));
    } catch (e) {
      debugPrint("get notifications error: ${e.toString()}");
      return Left(ErrorHandler.handle(e));
    }
  }

  bool _isSuccess(int? statusCode) => (statusCode == 200 || statusCode == 201);
}

import 'package:dartz/dartz.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/features/notifications/data/models/notification_model.dart';
import 'package:nuhoud/features/notifications/presentation/params/notification_params.dart';

abstract class NotificationRepo {
  Future<Either<Failure, NotificationResponseModel>> getNotifications(NotificationParams params);
}

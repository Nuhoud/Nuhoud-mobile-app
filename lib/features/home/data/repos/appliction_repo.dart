import 'package:dartz/dartz.dart';
import 'package:nuhoud/core/errors/failuer.dart';
import 'package:nuhoud/features/home/presentation/params/appliction_params.dart';

abstract class ApplicationRepo {
  Future<Either<Failure, void>> submitOffer(OfferParams params, String jobId);
}

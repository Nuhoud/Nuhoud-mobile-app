import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nuhoud/features/home/data/repos/appliction_repo.dart';
import 'package:nuhoud/features/home/presentation/params/appliction_params.dart';

part 'appliction_state.dart';

class ApplictionCubit extends Cubit<ApplictionState> {
  ApplictionCubit(this.applicationRepo) : super(ApplictionInitial());
  final ApplicationRepo applicationRepo;
  Future<void> submitOffer(OfferParams params, String jobId) async {
    emit(SubmitApplictionLoading());
    final result = await applicationRepo.submitOffer(params, jobId);
    result.fold((l) => emit(SubmitApplictionError(message: l.message)), (r) => emit(SubmitApplictionSuccess()));
  }
}

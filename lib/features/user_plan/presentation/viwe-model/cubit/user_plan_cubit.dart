import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nuhoud/features/user_plan/data/models/user_plan_model.dart';
import 'package:nuhoud/features/user_plan/data/repos/user_plan_repo.dart';

part 'user_plan_state.dart';

class UserPlanCubit extends Cubit<UserPlanState> {
  final UserPlanRepo userPlanRepo;
  UserPlanCubit(this.userPlanRepo) : super(UserPlanInitial());

  Future<void> getUserPlan() async {
    emit(UserPlanLoading());
    final result = await userPlanRepo.getUserPlan();
    result.fold((failure) => emit(UserPlanError(message: failure.message)),
        (userPlanModel) => emit(UserPlanSuccess(userPlanModel: userPlanModel)));
  }
}

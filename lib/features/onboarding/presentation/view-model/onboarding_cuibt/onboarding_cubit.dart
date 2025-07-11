import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nuhoud/features/onboarding/data/repo/onboarding_repo.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit({required this.onboardingRepo}) : super(OnboardingInitial());
  Map<String, dynamic> onboardingData = {};
  final OnboardingRepo onboardingRepo;

  void addUserInfo(String key, dynamic value) {
    onboardingData[key] = value;
  }

  Future<void> saveUserInfo() async {
    emit(SaveUserInfoLoading());
    final result = await onboardingRepo.saveUserInfo(onboardingData);
    result.fold((failure) {
      emit(SaveUserInfoError(message: failure.message));
    }, (success) {
      emit(SaveUserInfoSuccess());
    });
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  Map<String, dynamic> onboardingData = {};
  void addBasicInfo(String key, dynamic value) {
    onboardingData[key] = value;
  }
}

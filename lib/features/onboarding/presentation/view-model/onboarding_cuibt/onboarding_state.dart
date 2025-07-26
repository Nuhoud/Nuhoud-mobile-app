part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

final class OnboardingInitial extends OnboardingState {}

final class SaveUserInfoLoading extends OnboardingState {}

final class SaveUserInfoSuccess extends OnboardingState {}

final class SaveUserInfoError extends OnboardingState {
  final String message;

  const SaveUserInfoError({required this.message});
}

final class SaveUserSkillsLoading extends OnboardingState {}

final class SaveUserSkillsSuccess extends OnboardingState {}

final class SaveUserSkillsError extends OnboardingState {
  final String message;

  const SaveUserSkillsError({required this.message});
}

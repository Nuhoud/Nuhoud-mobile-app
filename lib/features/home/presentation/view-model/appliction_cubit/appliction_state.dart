part of 'appliction_cubit.dart';

sealed class ApplictionState extends Equatable {
  const ApplictionState();

  @override
  List<Object> get props => [];
}

final class ApplictionInitial extends ApplictionState {}

final class SubmitApplictionLoading extends ApplictionState {}

final class SubmitApplictionSuccess extends ApplictionState {}

final class SubmitApplictionError extends ApplictionState {
  final String message;
  const SubmitApplictionError({required this.message});
}

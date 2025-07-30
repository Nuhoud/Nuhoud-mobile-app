part of 'skills_cubit.dart';

sealed class SkillsState extends Equatable {
  const SkillsState();

  @override
  List<Object> get props => [];
}

final class SkillsInitial extends SkillsState {}

final class SkillsError extends SkillsState {
  final String message;

  const SkillsError(this.message);
}

final class SkillsSuccess extends SkillsState {
  final Skills skills;

  const SkillsSuccess(this.skills);
}

final class SkillsLoading extends SkillsState {}

final class GetSkillsFromAI extends SkillsState {}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nuhoud/core/shared/repos/skills_repo/skills_repo.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';

part 'skills_state.dart';

class SkillsCubit extends Cubit<SkillsState> {
  final SkillsRepo skillsRepo;
  SkillsCubit(this.skillsRepo) : super(SkillsInitial());

  Future<void> getSkills() async {
    emit(SkillsLoading());
    final result = await skillsRepo.getSkills();
    result.fold((failure) => emit(SkillsError(failure.message)), (skills) => emit(SkillsSuccess(skills)));
  }
}

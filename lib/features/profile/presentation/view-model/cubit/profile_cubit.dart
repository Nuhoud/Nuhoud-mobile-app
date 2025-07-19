import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';
import 'package:nuhoud/features/profile/data/repos/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  void getProfile() async {
    emit(GetProfileLoading());
    final result = await profileRepo.getProfile();
    result.fold((failure) => emit(GetProfileError(failure.message)), (profile) => emit(GetProfileSuccess(profile)));
  }

  void updateProfile(ProfileModel profile) async {
    emit(UpdateProfileLoading());
    final result = await profileRepo.updateProfile(profile);
    result.fold(
        (failure) => emit(UpdateProfileError(failure.message)), (profile) => emit(UpdateProfileSuccess(profile)));
  }
}

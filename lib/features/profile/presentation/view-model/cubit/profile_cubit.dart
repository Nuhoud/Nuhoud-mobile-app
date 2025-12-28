import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nuhoud/core/utils/cache_helper.dart';
import 'package:nuhoud/features/profile/data/models/profile_model.dart';
import 'package:nuhoud/features/profile/data/repos/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  ProfileCubit(this.profileRepo) : super(ProfileInitial());
  ProfileModel? profile;
  String? profilePhotoUrl = CacheHelper.getData(key: profilePhotoCacheKey) as String?;
  void getProfile() async {
    emit(GetProfileLoading());
    final result = await profileRepo.getProfile();
    result.fold((failure) => emit(GetProfileError(failure.message)), (profile) {
      this.profile = profile;
      emit(GetProfileSuccess(profile));
    });
  }

  void updateProfile(ProfileModel profile) async {
    emit(UpdateProfileLoading());
    final result = await profileRepo.updateProfile(profile);
    result.fold(
        (failure) => emit(UpdateProfileError(failure.message)), (profile) => emit(UpdateProfileSuccess(profile)));
  }

  void updateProfilePhoto(File photo) async {
    emit(UpdateProfilePhotoLoading());
    final result = await profileRepo.updateProfilePhoto(photo);
    result.fold(
      (failure) => emit(UpdateProfilePhotoError(failure.message)),
      (url) {
        profilePhotoUrl = url;
        emit(UpdateProfilePhotoSuccess(url));
      },
    );
  }
}

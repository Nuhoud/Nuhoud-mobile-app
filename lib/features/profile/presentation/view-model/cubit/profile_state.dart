part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class GetProfileLoading extends ProfileState {}

final class GetProfileSuccess extends ProfileState {
  final ProfileModel profile;
  const GetProfileSuccess(this.profile);
}

final class GetProfileError extends ProfileState {
  final String message;
  const GetProfileError(this.message);
}

final class UpdateProfileLoading extends ProfileState {}

final class UpdateProfileSuccess extends ProfileState {
  final ProfileModel profile;
  const UpdateProfileSuccess(this.profile);
}

final class UpdateProfileError extends ProfileState {
  final String message;
  const UpdateProfileError(this.message);
}

final class UpdateProfilePhotoLoading extends ProfileState {}

final class UpdateProfilePhotoSuccess extends ProfileState {
  final String photoUrl;
  const UpdateProfilePhotoSuccess(this.photoUrl);
}

final class UpdateProfilePhotoError extends ProfileState {
  final String message;
  const UpdateProfilePhotoError(this.message);
}

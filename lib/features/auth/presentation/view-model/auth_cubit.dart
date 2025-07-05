import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<void> login({
    required String emailOrPhone,
    required String password,
    required AuthType authType,
  }) async {
    emit(AuthLoading());
    final result = await _authRepo.login(
      emailOrPhone: emailOrPhone,
      password: password,
      authType: authType,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> register({
    required String name,
    required String emailOrPhone,
    required String password,
    required AuthType authType,
  }) async {
    emit(AuthLoading());
    final result = await _authRepo.register(
      name: name,
      emailOrPhone: emailOrPhone,
      password: password,
      authType: authType,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> verifyOtp({
    required String identifier,
    required String otp,
    required AuthType authType,
  }) async {
    emit(AuthLoading());
    final result = await _authRepo.verifyOtp(
      identifier: identifier,
      otp: otp,
      authType: authType,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> resendOtp({
    required String identifier,
    required AuthType authType,
  }) async {
    final result = await _authRepo.resendOtp(
      identifier: identifier,
      authType: authType,
    );
    result.fold(
      (failure) => emit(OptError(failure.message)),
      (_) => emit(OptSendSuccess()),
    );
  }

  Future<void> requestResetPassword({
    required String identifier,
    required AuthType authType,
  }) async {
    emit(AuthLoading());
    final result = await _authRepo.requestResetPassword(
      identifier: identifier,
      authType: authType,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> verifyResetPasswordOtp({
    required String identifier,
    required String otp,
    required AuthType authType,
  }) async {
    emit(AuthLoading());
    final result = await _authRepo.verifyResetPasswordOtp(
      identifier: identifier,
      otp: otp,
      authType: authType,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> resetPassword({
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await _authRepo.resetPassword(
      password: password,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> logout({
    required String identifier,
    required AuthType authType,
  }) async {
    emit(AuthLoading());
    final result = await _authRepo.logout(
      identifier: identifier,
      authType: authType,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  resetState() {
    emit(AuthInitial());
  }
}

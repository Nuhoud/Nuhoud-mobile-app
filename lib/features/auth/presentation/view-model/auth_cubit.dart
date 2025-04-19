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
      (token) => emit(AuthLoginSuccess(token)),
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
      (email) => emit(AuthRegisterSuccess(email)),
    );
  }
}

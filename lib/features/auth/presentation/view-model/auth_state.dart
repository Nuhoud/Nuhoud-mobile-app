part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

class AuthLoginSuccess extends AuthState {
  final String token;
  const AuthLoginSuccess(this.token);
}

class AuthRegisterSuccess extends AuthState {
  final String email;
  const AuthRegisterSuccess(this.email);
}

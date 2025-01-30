part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFailure extends AuthState {
  final String message;
  final String code;

  AuthFailure({required this.message, required this.code});
}

final class AuthSuccess extends AuthState {
  final UserEntity userEntity;

  AuthSuccess({required this.userEntity});
}

final class AuthSuccessVoid extends AuthState {}

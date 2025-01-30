part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

final class RegisterWithEmailPasswordEvent extends AuthBlocEvent {
  final String email;
  final String password;
  final String name;

  RegisterWithEmailPasswordEvent({
    required this.email,
    required this.password,
    required this.name,
  });
}

final class LoginWithEmailPasswordEvent extends AuthBlocEvent {
  final String email;
  final String password;

  LoginWithEmailPasswordEvent({required this.email, required this.password});
}

final class GetLoggedInUserEvent extends AuthBlocEvent {}

final class ForgotPasswordEvent extends AuthBlocEvent {
  final String email;

  ForgotPasswordEvent({required this.email});
}

final class ChangePasswordEvent extends AuthBlocEvent {
  final String email;
  final String resetCode;
  final String password;

  ChangePasswordEvent({
    required this.email,
    required this.resetCode,
    required this.password,
  });
}

final class VerifyCodeEvent extends AuthBlocEvent {
  final String email;
  final String resetCode;

  VerifyCodeEvent({
    required this.email,
    required this.resetCode,
  });
}

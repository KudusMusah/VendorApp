part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final UserEntity user;

  AppUserLoggedIn({required this.user});
}

final class AppTestLoggedIn extends AppUserState {

  AppTestLoggedIn();
}

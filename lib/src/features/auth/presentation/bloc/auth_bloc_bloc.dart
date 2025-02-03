import 'package:didi/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:didi/src/core/common/entities/user_entity.dart';
import 'package:didi/src/core/usecase/usecase.dart';
import 'package:didi/src/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:didi/src/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:didi/src/features/auth/domain/usecases/get_logged_in_user_usecase.dart';
import 'package:didi/src/features/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:didi/src/features/auth/domain/usecases/logout.dart';
import 'package:didi/src/features/auth/domain/usecases/register_with_email_usecase.dart';
import 'package:didi/src/features/auth/domain/usecases/verify_code_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthState> {
  final RegisterWithEmailUsecase _registerWithEmailUsecase;
  final LoginWithEmailUsecase _loginWithEmailUsecase;
  final ForgotPasswordUsecase _forgotPasswordUsecase;
  final VerifyCodeUsecase _verifyCodeUsecase;
  final ChangePasswordUsecase _changePasswordUsecase;
  final GetLoggedInUserUsecase _getLoggedInUserUsecase;
  final LogoutUsecase _logoutUsecase;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required RegisterWithEmailUsecase registerWithEmailUsecase,
    required LoginWithEmailUsecase loginWithEmailUsecase,
    required ForgotPasswordUsecase forgotPasswordUsecase,
    required VerifyCodeUsecase verifyCodeUsecase,
    required ChangePasswordUsecase changePasswordUsecase,
    required AppUserCubit appUserCubit,
    required GetLoggedInUserUsecase getLoggedInUserUsecase,
    required LogoutUsecase logoutUsecase,
  })  : _registerWithEmailUsecase = registerWithEmailUsecase,
        _loginWithEmailUsecase = loginWithEmailUsecase,
        _forgotPasswordUsecase = forgotPasswordUsecase,
        _verifyCodeUsecase = verifyCodeUsecase,
        _changePasswordUsecase = changePasswordUsecase,
        _appUserCubit = appUserCubit,
        _getLoggedInUserUsecase = getLoggedInUserUsecase,
        _logoutUsecase = logoutUsecase,
        super(AuthInitial()) {
    on<AuthBlocEvent>((event, emit) => emit(AuthLoading()));
    on<RegisterWithEmailPasswordEvent>(_onRegisterWithEmailPassword);
    on<LoginWithEmailPasswordEvent>(_loginWithEmailpassword);
    on<ForgotPasswordEvent>(_forgotpassword);
    on<VerifyCodeEvent>(_verifyCode);
    on<ChangePasswordEvent>(_changePassword);
    on<GetLoggedInUserEvent>(_getLoggedInUser);
    on<LogoutUserEvent>(_logout);
  }

  void _onRegisterWithEmailPassword(
    RegisterWithEmailPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _registerWithEmailUsecase(RegisterWithEmailParams(
      email: event.email,
      password: event.password,
      name: event.name,
      phone: event.phone,
      role: event.role,
    ));

    res.fold(
      (l) => emit(AuthFailure(message: l.message, code: l.errorCode)),
      (r) => emit(LogoutSuccess()),
    );
  }

  void _loginWithEmailpassword(
    LoginWithEmailPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _loginWithEmailUsecase(LoginWithEmailParams(
      email: event.email,
      password: event.password,
    ));

    res.fold(
      (l) => emit(AuthFailure(message: l.message, code: l.errorCode)),
      (r) {
        _appUserCubit.userLoggedIn(r);
        emit(AuthSuccess(userEntity: r));
      },
    );
  }

  void _forgotpassword(
    ForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _forgotPasswordUsecase(ForgotPasswordParams(
      email: event.email,
    ));

    res.fold(
      (l) => emit(AuthFailure(message: l.message, code: l.errorCode)),
      (r) => emit(AuthSuccessVoid()),
    );
  }

  void _verifyCode(
    VerifyCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _verifyCodeUsecase(VerifyCodeParams(
      email: event.email,
      resetCode: event.resetCode,
    ));

    res.fold(
      (l) => emit(AuthFailure(message: l.message, code: l.errorCode)),
      (r) => emit(AuthSuccess(userEntity: r)),
    );
  }

  void _changePassword(
    ChangePasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _changePasswordUsecase(ChangePasswordParams(
      email: event.email,
      resetCode: event.resetCode,
      password: event.password,
    ));

    res.fold(
      (l) => emit(AuthFailure(message: l.message, code: l.errorCode)),
      (r) => emit(AuthSuccess(userEntity: r)),
    );
  }

  void _getLoggedInUser(
    GetLoggedInUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _getLoggedInUserUsecase(NoParams());

    res.fold(
      (l) => emit(AuthFailure(message: l.message, code: l.errorCode)),
      (r) {
        _appUserCubit.userLoggedIn(r);
        emit(AuthSuccess(userEntity: r));
      },
    );
  }

  void _logout(
    LogoutUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _logoutUsecase(NoParams());

    res.fold(
      (l) => emit(AuthFailure(message: l.message, code: l.errorCode)),
      (r) {
        _appUserCubit.userLoggedOut();
        emit(LogoutSuccess());
      },
    );
  }
}

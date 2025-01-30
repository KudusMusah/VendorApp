import 'package:didi/src/core/errors/failures/failure.dart';
import 'package:didi/src/core/usecase/usecase.dart';
import 'package:didi/src/core/common/entities/user_entity.dart';
import 'package:didi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LoginWithEmailUsecase
    implements Usecase<UserEntity, LoginWithEmailParams> {
  final AuthRepository _authRepository;
  LoginWithEmailUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(
    LoginWithEmailParams params,
  ) async {
    return await _authRepository.loginWithEmailPassword(
      params.email,
      params.password,
    );
  }
}

class LoginWithEmailParams {
  final String email;
  final String password;

  LoginWithEmailParams({required this.email, required this.password});
}

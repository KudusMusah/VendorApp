import 'package:didi/src/core/errors/failures/failure.dart';
import 'package:didi/src/core/usecase/usecase.dart';
import 'package:didi/src/core/common/entities/user_entity.dart';
import 'package:didi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RegisterWithEmailUsecase
    implements Usecase<UserEntity, RegisterWithEmailParams> {
  final AuthRepository _authRepository;
  RegisterWithEmailUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(
    RegisterWithEmailParams params,
  ) async {
    return await _authRepository.registerWithEmailPassword(
      params.email,
      params.password,
      params.name,
    );
  }
}

class RegisterWithEmailParams {
  final String email;
  final String password;
  final String name;

  RegisterWithEmailParams({
    required this.email,
    required this.password,
    required this.name,
  });
}

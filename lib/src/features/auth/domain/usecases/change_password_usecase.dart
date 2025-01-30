import 'package:didi/src/core/errors/failures/failure.dart';
import 'package:didi/src/core/usecase/usecase.dart';
import 'package:didi/src/core/common/entities/user_entity.dart';
import 'package:didi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class ChangePasswordUsecase
    implements Usecase<UserEntity, ChangePasswordParams> {
  final AuthRepository _authRepository;
  ChangePasswordUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(
    ChangePasswordParams params,
  ) async {
    return await _authRepository.changePassword(
      params.email,
      params.resetCode,
      params.password,
    );
  }
}

class ChangePasswordParams {
  final String email;
  final String resetCode;
  final String password;

  ChangePasswordParams({
    required this.email,
    required this.resetCode,
    required this.password,
  });
}

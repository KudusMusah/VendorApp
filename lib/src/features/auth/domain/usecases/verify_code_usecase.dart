import 'package:didi/src/core/common/entities/user_entity.dart';
import 'package:didi/src/core/errors/failures/failure.dart';
import 'package:didi/src/core/usecase/usecase.dart';
import 'package:didi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class VerifyCodeUsecase implements Usecase<UserEntity, VerifyCodeParams> {
  final AuthRepository _authRepository;
  VerifyCodeUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(
    VerifyCodeParams params,
  ) async {
    return await _authRepository.verifyCode(params.email, params.resetCode);
  }
}

class VerifyCodeParams {
  final String email;
  final String resetCode;

  VerifyCodeParams({required this.email, required this.resetCode});
}

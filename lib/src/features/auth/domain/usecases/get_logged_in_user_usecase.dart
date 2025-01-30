import 'package:didi/src/core/errors/failures/failure.dart';
import 'package:didi/src/core/usecase/usecase.dart';
import 'package:didi/src/core/common/entities/user_entity.dart';
import 'package:didi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetLoggedInUserUsecase implements Usecase<UserEntity, NoParams> {
  final AuthRepository _authRepository;
  GetLoggedInUserUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, UserEntity>> call(
    NoParams params,
  ) async {
    return await _authRepository.getLoggedInuser();
  }
}

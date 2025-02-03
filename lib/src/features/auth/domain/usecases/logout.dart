import 'package:didi/src/core/errors/failures/failure.dart';
import 'package:didi/src/core/usecase/usecase.dart';
import 'package:didi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class LogoutUsecase implements Usecase<void, NoParams> {
  final AuthRepository _authRepository;
  LogoutUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(
    NoParams params,
  ) async {
    return await _authRepository.logout();
  }
}

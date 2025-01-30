import 'package:didi/src/core/errors/failures/failure.dart';
import 'package:didi/src/core/usecase/usecase.dart';
import 'package:didi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class ForgotPasswordUsecase implements Usecase<void, ForgotPasswordParams> {
  final AuthRepository _authRepository;
  ForgotPasswordUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(
    ForgotPasswordParams params,
  ) async {
    return await _authRepository.forgotPassword(params.email);
  }
}

class ForgotPasswordParams {
  final String email;

  ForgotPasswordParams({required this.email});
}

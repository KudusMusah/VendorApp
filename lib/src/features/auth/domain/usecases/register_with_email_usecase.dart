import 'package:didi/src/core/errors/failures/failure.dart';
import 'package:didi/src/core/usecase/usecase.dart';
import 'package:didi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class RegisterWithEmailUsecase
    implements Usecase<void, RegisterWithEmailParams> {
  final AuthRepository _authRepository;
  RegisterWithEmailUsecase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, void>> call(
    RegisterWithEmailParams params,
  ) async {
    return await _authRepository.registerWithEmailPassword(
      params.email,
      params.password,
      params.name,
      params.phone,
    );
  }
}

class RegisterWithEmailParams {
  final String email;
  final String password;
  final String name;
  final String phone;

  RegisterWithEmailParams({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });
}

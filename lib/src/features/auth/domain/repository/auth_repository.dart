import 'package:didi/src/core/errors/failures/auth_failure.dart';
import 'package:didi/src/core/common/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<AuthFailure, void>> registerWithEmailPassword(
    String email,
    String password,
    String name,
    String phone,
    String role,
  );
  Future<Either<AuthFailure, UserEntity>> loginWithEmailPassword(
    String email,
    String password,
  );
  Future<Either<AuthFailure, void>> forgotPassword(String email);
  Future<Either<AuthFailure, UserEntity>> verifyCode(
    String email,
    String resetCode,
  );
  Future<Either<AuthFailure, UserEntity>> changePassword(
    String email,
    String resetCode,
    String password,
  );
  Future<Either<AuthFailure, UserEntity>> getLoggedInuser();
  Future<Either<AuthFailure, void>> logout();
}

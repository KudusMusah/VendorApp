import 'package:didi/src/core/common/entities/user_entity.dart';
import 'package:didi/src/core/errors/exceptions/auth_exception.dart';
import 'package:didi/src/core/errors/failures/auth_failure.dart';
import 'package:didi/src/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:didi/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:didi/src/features/auth/data/models/user_model.dart';
import 'package:didi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;

  AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required AuthLocalDataSource authLocalDataSource,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _authLocalDataSource = authLocalDataSource;

  @override
  Future<Either<AuthFailure, UserModel>> changePassword(
    String email,
    String resetCode,
    String password,
  ) async {
    try {
      final user = await _authRemoteDataSource.changePassword(
        email,
        resetCode,
        password,
      );
      return right(user);
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<AuthFailure, void>> forgotPassword(String email) async {
    try {
      await _authRemoteDataSource.forgotPassword(
        email,
      );
      return right(null);
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> loginWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final user = await _authRemoteDataSource.loginWithEmailPassword(
        email,
        password,
      );
      _authLocalDataSource.storeLoggedInUserInfo(user);
      return right(user);
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> registerWithEmailPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      final user = await _authRemoteDataSource.registerWithEmailPassword(
        email,
        password,
        name,
      );
      return right(user);
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<AuthFailure, UserModel>> verifyCode(
    String email,
    String resetCode,
  ) async {
    try {
      final user = await _authRemoteDataSource.verifyCode(
        email,
        resetCode,
      );
      return right(user);
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> getLoggedInuser() async {
    try {
      final user = await _authLocalDataSource.getLoggedInUserInfo();
      return right(user);
    } on AuthException catch (e) {
      return left(AuthFailure(message: e.message));
    }
  }
}

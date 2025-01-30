part of 'dp_imports.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton(() => http.Client());
  // Hive default directory
  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;

  sl.registerLazySingleton(
    () => Hive.box(),
  );
  _initAuth();
}

void _initAuth() {
  sl
    // Datasources
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(httpClient: sl()),
    )
    ..registerFactory<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(hiveBox: sl()),
    )

    // Repositories
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: sl(),
        authLocalDataSource: sl(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => RegisterWithEmailUsecase(authRepository: sl()),
    )
    ..registerFactory(
      () => LoginWithEmailUsecase(authRepository: sl()),
    )
    ..registerFactory(
      () => ForgotPasswordUsecase(authRepository: sl()),
    )
    ..registerFactory(
      () => VerifyCodeUsecase(authRepository: sl()),
    )
    ..registerFactory(
      () => ChangePasswordUsecase(authRepository: sl()),
    )
    ..registerFactory(
      () => GetLoggedInUserUsecase(authRepository: sl()),
    )
    // Cubits
    ..registerLazySingleton(
      () => AppUserCubit(),
    )
    // Blocs
    ..registerFactory(
      () => AuthBloc(
        registerWithEmailUsecase: sl(),
        loginWithEmailUsecase: sl(),
        forgotPasswordUsecase: sl(),
        verifyCodeUsecase: sl(),
        changePasswordUsecase: sl(),
        getLoggedInUserUsecase: sl(),
        appUserCubit: sl(),
      ),
    );
}

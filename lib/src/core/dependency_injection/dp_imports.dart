import 'package:didi/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:didi/src/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:didi/src/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:didi/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:didi/src/features/auth/domain/repository/auth_repository.dart';
import 'package:didi/src/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:didi/src/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:didi/src/features/auth/domain/usecases/get_logged_in_user_usecase.dart';
import 'package:didi/src/features/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:didi/src/features/auth/domain/usecases/register_with_email_usecase.dart';
import 'package:didi/src/features/auth/domain/usecases/verify_code_usecase.dart';
import 'package:didi/src/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

part 'dependency_injection.dart';

import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:unigate/core/network/dio_client.dart';
import 'package:unigate/core/network/network_info.dart';
import 'package:unigate/features/auth/data/datasource/remote_data_source/auth_remote_data_source.dart';
import 'package:unigate/features/auth/data/repository/auth_repository_impl.dart';
import 'package:unigate/features/auth/domain/repositories/auth_repository.dart';
import 'package:unigate/features/auth/domain/use_cases/signup_usecase.dart';
import 'package:unigate/features/auth/data/datasource/local_data_source/auth_local_data_source.dart';
import 'package:unigate/features/auth/domain/use_cases/login_usecase.dart';
import 'package:unigate/features/auth/domain/use_cases/verify_email_usecase.dart';
import 'package:unigate/features/auth/domain/use_cases/resend_code_usecase.dart';
import 'package:unigate/features/auth/domain/use_cases/forgot_password_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unigate/features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:unigate/core/services/app_prefs.dart';

final sl = GetIt.instance;

Future<void> initInjection() async {
  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
  sl.registerLazySingleton<AppPrefs>(() => AppPrefs(sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
        localDataSource: sl(),
      ));

  // Use cases
  sl.registerFactory<SignupUseCase>(() => SignupUseCase(sl()));
  sl.registerFactory<LoginUseCase>(() => LoginUseCase(sl()));
  sl.registerFactory<VerifyEmailUseCase>(() => VerifyEmailUseCase(sl()));
  sl.registerFactory<ResendCodeUseCase>(() => ResendCodeUseCase(sl()));
  sl.registerFactory<ForgotPasswordUseCase>(() => ForgotPasswordUseCase(sl()));

  // Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(
        loginUseCase: sl(),
        signupUseCase: sl(),
        verifyEmailUseCase: sl(),
        resendCodeUseCase: sl(),
        forgotPasswordUseCase: sl(),
      ));
}

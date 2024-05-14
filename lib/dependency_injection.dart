import 'package:berkania/data/repositories_impl/auth_repository_impl.dart';
import 'package:berkania/data/repositories_impl/user_repository_impl.dart';
import 'package:berkania/domain/repositories/auth_repository.dart';
import 'package:berkania/domain/repositories/user_repository.dart';
import 'package:berkania/presentation/auth/forget_password/forget_password_cubit.dart';
import 'package:berkania/presentation/auth/login/login_cubit.dart';
import 'package:berkania/presentation/auth/register/register_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

class DependencyInjection{
  DependencyInjection._();

  static final getIt = GetIt.instance;

  static void setup(){

    // - - - - - - - - - - - - - - - - - - UTILS - - - - - - - - - - - - - - - - - -  //
    getIt.registerSingleton<GetStorage>(GetStorage());
    getIt.registerSingleton<Connectivity>(Connectivity());

    // - - - - - - - - - - - - - - - - - - REPOSITORIES - - - - - - - - - - - - - - - - - -  //
    getIt.registerSingleton<AuthRepository>(AuthRepositoryImpl());
    getIt.registerSingleton<UserRepository>(UserRepositoryImpl());

    // - - - - - - - - - - - - - - - - - - CUBITS - - - - - - - - - - - - - - - - - -  //
    getIt.registerSingleton<RegisterCubit>(RegisterCubit(authRepository: getIt(), userRepository: getIt(), storage: getIt(), connectivity: getIt()));
    getIt.registerSingleton<LoginCubit>(LoginCubit(authRepository: getIt()));
    getIt.registerSingleton<ForgetPasswordCubit>(ForgetPasswordCubit());

  }

}
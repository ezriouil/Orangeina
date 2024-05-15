import 'package:berkania/data/repositories_impl/auth_repository_impl.dart';
import 'package:berkania/data/repositories_impl/user_repository_impl.dart';
import 'package:berkania/domain/repositories/auth_repository.dart';
import 'package:berkania/domain/repositories/user_repository.dart';
import 'package:berkania/presentation/auth/forget_password/forget_password_cubit.dart';
import 'package:berkania/presentation/auth/login/login_cubit.dart';
import 'package:berkania/presentation/auth/register/register_cubit.dart';
import 'package:berkania/presentation/home/home_cubit.dart';
import 'package:berkania/presentation/index/index_cubit.dart';
import 'package:berkania/presentation/notification/notification_cubit.dart';
import 'package:berkania/presentation/profile/profile_cubit.dart';
import 'package:berkania/presentation/wishlist/wishlist_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

class DependencyInjection{
  DependencyInjection._();

  static final getIt = GetIt.instance;

  static void setup(){

    // - - - - - - - - - - - - - - - - - - UTILS - - - - - - - - - - - - - - - - - -  //
    getIt.registerLazySingleton<GetStorage>( () => GetStorage());
    getIt.registerLazySingleton<Connectivity>( () => Connectivity());

    // - - - - - - - - - - - - - - - - - - REPOSITORIES - - - - - - - - - - - - - - - - - -  //
    getIt.registerLazySingleton<AuthRepository>( () => AuthRepositoryImpl());
    getIt.registerLazySingleton<UserRepository>( () => UserRepositoryImpl());

    // - - - - - - - - - - - - - - - - - - CUBITS - - - - - - - - - - - - - - - - - -  //
    getIt.registerLazySingleton<RegisterCubit>( () =>RegisterCubit(authRepository: getIt(), userRepository: getIt(), storage: getIt(), connectivity: getIt()));
    getIt.registerLazySingleton<LoginCubit>( () => LoginCubit(authRepository: getIt(), userRepository: getIt(), storage: getIt(), connectivity: getIt()));
    getIt.registerLazySingleton<ForgetPasswordCubit>( () => ForgetPasswordCubit(authRepository: getIt(), connectivity: getIt()));
    getIt.registerLazySingleton<IndexCubit>( () => IndexCubit());
    getIt.registerLazySingleton<HomeCubit>( () => HomeCubit());
    getIt.registerLazySingleton<WishlistCubit>( () => WishlistCubit());
    getIt.registerLazySingleton<NotificationCubit>( () => NotificationCubit());
    getIt.registerLazySingleton<ProfileCubit>( () => ProfileCubit());

  }

}
import 'package:berkania/data/repositories_impl/auth_repository_impl.dart';
import 'package:berkania/data/repositories_impl/user_repository_impl.dart';
import 'package:berkania/data/repositories_impl/vendor_repository_impl.dart';
import 'package:berkania/domain/repositories/auth_repository.dart';
import 'package:berkania/domain/repositories/user_repository.dart';
import 'package:berkania/domain/repositories/vendor_repository.dart';
import 'package:berkania/presentation/auth/forget_password/forget_password_cubit.dart';
import 'package:berkania/presentation/auth/login/login_cubit.dart';
import 'package:berkania/presentation/auth/register/register_cubit.dart';
import 'package:berkania/presentation/home/home_cubit.dart';
import 'package:berkania/presentation/index/index_cubit.dart';
import 'package:berkania/presentation/notification/notification_cubit.dart';
import 'package:berkania/presentation/settings/settings_cubit.dart';
import 'package:berkania/presentation/vendor_details/vendor_details_cubit.dart';
import 'package:berkania/presentation/vendor_new_order/vendor_new_order_cubit.dart';
import 'package:berkania/presentation/vendor_orders/vendor_orders_cubit.dart';
import 'package:berkania/presentation/wishlist/wishlist_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import 'data/repositories_impl/wishList_repository_impl.dart';
import 'domain/repositories/wishList_repository.dart';

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
    getIt.registerLazySingleton<VendorRepository>( () => VendorRepositoryImpl());
    getIt.registerLazySingleton<WishListRepository>( () => WishListRepositoryImpl());

    // - - - - - - - - - - - - - - - - - - CUBITS - - - - - - - - - - - - - - - - - -  //
    getIt.registerFactory<RegisterCubit>( () =>RegisterCubit(authRepository: getIt(), userRepository: getIt(), storage: getIt(), connectivity: getIt()));
    getIt.registerFactory<LoginCubit>( () => LoginCubit(authRepository: getIt(), userRepository: getIt(), storage: getIt(), connectivity: getIt()));
    getIt.registerFactory<ForgetPasswordCubit>( () => ForgetPasswordCubit(authRepository: getIt(), connectivity: getIt()));
    getIt.registerFactory<IndexCubit>( () => IndexCubit());
    getIt.registerFactory<HomeCubit>( () => HomeCubit(vendorRepository: getIt()));
    getIt.registerFactory<WishlistCubit>( () => WishlistCubit(storage: getIt(), wishListRepository: getIt()));
    getIt.registerFactory<NotificationCubit>( () => NotificationCubit());
    getIt.registerFactory<SettingsCubit>( () => SettingsCubit());
    getIt.registerFactory<VendorDetailsCubit>( () => VendorDetailsCubit());
    getIt.registerFactory<VendorNewOrderCubit>( () => VendorNewOrderCubit(vendorRepository: getIt(), connectivity: getIt(), storage: getIt()));
    getIt.registerFactory<VendorOrdersCubit>( () => VendorOrdersCubit(storage: getIt(), vendorRepository: getIt()));
  }

}
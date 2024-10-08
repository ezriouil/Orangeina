import 'package:berkania/data/repositories_impl/notification_repository_impl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

import 'data/repositories_impl/auth_repository_impl.dart';
import 'data/repositories_impl/report_repository_impl.dart';
import 'data/repositories_impl/review_repository_impl.dart';
import 'data/repositories_impl/user_repository_impl.dart';
import 'data/repositories_impl/vendor_repository_impl.dart';
import 'data/repositories_impl/wishList_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/notification_repository.dart';
import 'domain/repositories/report_repository.dart';
import 'domain/repositories/review_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/repositories/vendor_repository.dart';
import 'domain/repositories/wishList_repository.dart';

class DependencyInjection{
  DependencyInjection._();

  static final getIt = GetIt.instance;

  static void setupUtils(){
    getIt.registerLazySingleton<GetStorage>( () => GetStorage());
    getIt.registerLazySingleton<FlutterLocalization>( () => FlutterLocalization.instance);
    getIt.registerLazySingleton<Connectivity>( () => Connectivity());
  }

  static void setupRepository(){
    getIt.registerLazySingleton<AuthRepository>( () => AuthRepositoryImpl());
    getIt.registerLazySingleton<UserRepository>( () => UserRepositoryImpl());
    getIt.registerLazySingleton<VendorRepository>( () => VendorRepositoryImpl());
    getIt.registerLazySingleton<WishListRepository>( () => WishListRepositoryImpl());
    getIt.registerLazySingleton<NotificationRepository>( () => NotificationRepositoryImpl());
    getIt.registerLazySingleton<ReviewRepository>( () => ReviewRepositoryImpl());
    getIt.registerLazySingleton<ReportRepository>( () => ReportRepositoryImpl());
  }

  // static OnBoardingCubit onBoardingCubit = OnBoardingCubit(storage: DependencyInjection.getIt<GetStorage>());
  // static RegisterCubit registerCubit = RegisterCubit(authRepository: DependencyInjection.getIt(), userRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt());
  // static LoginCubit loginCubit = LoginCubit(authRepository: DependencyInjection.getIt(), userRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt());
  // static ForgetPasswordCubit forgetPasswordCubit = ForgetPasswordCubit(authRepository: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt());
  // static IndexCubit indexCubit = IndexCubit(connectivity: DependencyInjection.getIt());
  // static HomeCubit homeCubit = HomeCubit(vendorRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt());
  // static WishlistCubit wishlistCubit = WishlistCubit(storage: DependencyInjection.getIt(), wishListRepository: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt());
  // static NotificationCubit notificationCubit = NotificationCubit(notificationRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt());
  // static SettingsCubit settingsCubit = SettingsCubit(storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt(), userRepository: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt(), authRepository: DependencyInjection.getIt());
  // static VendorDetailsCubit vendorDetailsCubit = VendorDetailsCubit(userRepository: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt(), reviewRepository: DependencyInjection.getIt(), wishListRepository: DependencyInjection.getIt(), reportRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt());
  // static VendorNewOrderCubit vendorNewOrderCubit = VendorNewOrderCubit(storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt(), notificationRepository: DependencyInjection.getIt());
  // static VendorOrdersCubit vendorOrdersCubit = VendorOrdersCubit(storage: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt());
  // static BeVendorCubit beVendorCubit = BeVendorCubit(notificationRepository: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt(), userRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt());

}
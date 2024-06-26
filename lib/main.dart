import 'package:berkania/dependency_injection.dart';
import 'package:berkania/presentation/auth/forget_password/forget_password_cubit.dart';
import 'package:berkania/presentation/auth/login/login_cubit.dart';
import 'package:berkania/presentation/auth/register/register_cubit.dart';
import 'package:berkania/presentation/be_vendor/be_vendor_cubit.dart';
import 'package:berkania/presentation/home/home_cubit.dart';
import 'package:berkania/presentation/index/index_cubit.dart';
import 'package:berkania/presentation/notification/notification_cubit.dart';
import 'package:berkania/presentation/on_boarding/on_boarding_cubit.dart';
import 'package:berkania/presentation/settings/settings_cubit.dart';
import 'package:berkania/presentation/vendor_details/vendor_details_cubit.dart';
import 'package:berkania/presentation/vendor_new_order/vendor_new_order_cubit.dart';
import 'package:berkania/presentation/vendor_orders/vendor_orders_cubit.dart';
import 'package:berkania/presentation/wishlist/wishlist_cubit.dart';
import 'package:berkania/utils/local/storage/local_storage.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:berkania/utils/theme/theme_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';
import 'utils/localisation/custom_locale.dart';

void main() async {

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // - - - - - - - - - - - - - - - - - - SPLASH SCREEN - - - - - - - - - - - - - - - - - -  //
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // - - - - - - - - - - - - - - - - - - INIT FIREBASE - - - - - - - - - - - - - - - - - -  //
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // - - - - - - - - - - - - - - - - - - DI - - - - - - - - - - - - - - - - - -  //
  DependencyInjection.setup();

  // - - - - - - - - - - - - - - - - - - INIT LOCAL STORAGE - - - - - - - - - - - - - - - - - -  //
  await GetStorage.init();
  String? initLocation;
  final GetStorage storage = DependencyInjection.getIt<GetStorage>();
  initLocation = await LocalStorage.read(key: "INIT_LOCATION", storage: storage);

  // - - - - - - - - - - - - - - - - - - HIDE THE TOP STATUS BAR AND SYSTEM BOTTOM BAR - - - - - - - - - - - - - - - - - -  //
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // - - - - - - - - - - - - - - - - - - SETUP FIREBASE CRASHLYTICS - - - - - - - - - - - - - - - - - -  //
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // - - - - - - - - - - - - - - - - - - REMOVE SPLASH SCREEN - - - - - - - - - - - - - - - - - -  //
  FlutterNativeSplash.remove();

  // - - - - - - - - - - - - - - - - - - RUN APP - - - - - - - - - - - - - - - - - -  //
  runApp(App(initLocation: initLocation));

}

class App extends StatefulWidget {

  final String? initLocation;
  const App({super.key, this.initLocation});

  @override
  State<App> createState() => _IndexState();
}

class _IndexState extends State<App> {

  final FlutterLocalization localization = DependencyInjection.getIt<FlutterLocalization>();
  String? initLocation;
  @override
  void initState() {
    initLocation = widget.initLocation;
    initLocalization();
    super.initState();
  }

  // - - - - - - - - - - - - - - - - - - INIT LOCALISATION - - - - - - - - - - - - - - - - - -  //
  initLocalization() async{
    await localization.init(mapLocales: CustomLocale.LOCALS, initLanguageCode: CustomLocale.EN);
    localization.onTranslatedLanguage = (Locale? locale) async{
      initLocation ??= "INDEX";
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        // providers: [
        //   BlocProvider(create: (_) => DependencyInjection.getIt<OnBoardingCubit>()),
        //   BlocProvider(create: (_) => DependencyInjection.getIt<RegisterCubit>()),
        //   BlocProvider(create: (_) => DependencyInjection.getIt<LoginCubit>()),
        //   BlocProvider(create: (_) => DependencyInjection.getIt<ForgetPasswordCubit>()),
        //   BlocProvider(create: (_) => DependencyInjection.getIt<IndexCubit>()),
        //   BlocProvider(create: (_) => DependencyInjection.getIt<HomeCubit>()),
        //   BlocProvider(create: (_) => DependencyInjection.getIt<WishlistCubit>()),
        //   BlocProvider(create: (_) => DependencyInjection.getIt<NotificationCubit>()),
        //   BlocProvider(create: (_) => DependencyInjection.getIt<SettingsCubit>()),
        //   BlocProvider(create: (_) => DependencyInjection.getIt<VendorDetailsCubit>()),
        //   BlocProvider(create: (_) => DependencyInjection.getIt<VendorNewOrderCubit>()),
        //   BlocProvider(create: (_) => DependencyInjection.getIt<VendorOrdersCubit>()),
        //   BlocProvider(create: (_) => DependencyInjection.getIt<BeVendorCubit>()),
        // ],
        providers: [
          BlocProvider(create: (_) => OnBoardingCubit(storage: DependencyInjection.getIt())),
          BlocProvider(create: (_) => RegisterCubit(storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt(), userRepository: DependencyInjection.getIt(), authRepository: DependencyInjection.getIt())),
          BlocProvider(create: (_) => LoginCubit(authRepository: DependencyInjection.getIt(), userRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt())),
          BlocProvider(create: (_) => ForgetPasswordCubit(authRepository: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt())),
          BlocProvider(create: (_) => IndexCubit()),
          BlocProvider(create: (_) => HomeCubit(vendorRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt())),
          BlocProvider(create: (_) => WishlistCubit(storage: DependencyInjection.getIt(), wishListRepository: DependencyInjection.getIt())),
          BlocProvider(create: (_) => NotificationCubit(notificationRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt())),
          BlocProvider(create: (_) => SettingsCubit(storage: DependencyInjection.getIt(), userRepository: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt(), authRepository: DependencyInjection.getIt())),
          BlocProvider(create: (_) => VendorDetailsCubit(userRepository: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt(), reviewRepository: DependencyInjection.getIt(), wishListRepository: DependencyInjection.getIt(), reportRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt())),
          BlocProvider(create: (_) => VendorNewOrderCubit(connectivity: DependencyInjection.getIt(), storage: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt(), notificationRepository: DependencyInjection.getIt())),
          BlocProvider(create: (_) => VendorOrdersCubit(storage: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt())),
          BlocProvider(create: (_) => BeVendorCubit(notificationRepository: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt(), userRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt())),
        ],
        child: MaterialApp.router(
            themeMode: ThemeMode.system,
            theme: ThemeApp.lightTheme,
            darkTheme: ThemeApp.darkTheme,
            debugShowCheckedModeBanner: false,
            supportedLocales: localization.supportedLocales,
            localizationsDelegates: localization.localizationsDelegates,
            routerConfig: CustomRouter.router(initialLocation: initLocation)));
  }
}
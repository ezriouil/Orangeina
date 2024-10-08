import 'package:berkania/dependency_injection.dart';
import 'package:berkania/presentation/auth/forget_password/forget_password_cubit.dart';
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
import 'package:berkania/utils/helpers/network.dart';
import 'package:berkania/utils/local/storage/local_storage.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:berkania/utils/theme/theme_app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';
import 'presentation/auth/login/login_cubit.dart';
import 'utils/localisation/custom_locale.dart';

void main() async {

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // - - - - - - - - - - - - - - - - - - SPLASH SCREEN - - - - - - - - - - - - - - - - - -  //
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // - - - - - - - - - - - - - - - - - - INIT FIREBASE - - - - - - - - - - - - - - - - - -  //
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // - - - - - - - - - - - - - - - - - - DI - - - - - - - - - - - - - - - - - -  //
  DependencyInjection.setupUtils();
  DependencyInjection.setupRepository();

  // - - - - - - - - - - - - - - - - - - INIT LOCAL STORAGE - - - - - - - - - - - - - - - - - -  //
  String? initLocation, initLanguage;
  await GetStorage.init();
  final GetStorage storage = DependencyInjection.getIt<GetStorage>();
  final Connectivity connectivity = DependencyInjection.getIt<Connectivity>();
  final hasConnectionNetwork = await Network.hasConnection(connectivity);
  if(!hasConnectionNetwork)  await LocalStorage.upsert(key: "INIT_LOCATION", value: "LOGIN", storage: storage);
  initLocation = await LocalStorage.read(key: "INIT_LOCATION", storage: storage);
  initLanguage = await LocalStorage.read(key: "LANGUAGE", storage: storage);

  // - - - - - - - - - - - - - - - - - - HIDE THE TOP STATUS BAR AND SYSTEM BOTTOM BAR - - - - - - - - - - - - - - - - - -  //
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // - - - - - - - - - - - - - - - - - - SETUP FIREBASE CRASHLYTICS - - - - - - - - - - - - - - - - - -  //
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  //   return true;
  // };

  // - - - - - - - - - - - - - - - - - - REMOVE SPLASH SCREEN - - - - - - - - - - - - - - - - - -  //
  FlutterNativeSplash.remove();

  // - - - - - - - - - - - - - - - - - - RUN APP - - - - - - - - - - - - - - - - - -  //
  runApp(App(initLocation: initLocation, initLanguage: initLanguage));

}

class App extends StatefulWidget {

  final String? initLocation, initLanguage;
  const App({super.key, this.initLocation, this.initLanguage});

  @override
  State<App> createState() => Application();
}

class Application extends State<App> {

  final FlutterLocalization localization = DependencyInjection.getIt<FlutterLocalization>();
  String? initLocation, initLanguage;
  @override
  void initState() {
    initLocation = widget.initLocation;
    initLanguage = widget.initLanguage;
    initLocalization();
    super.initState();
  }

  // - - - - - - - - - - - - - - - - - - INIT LOCALISATION - - - - - - - - - - - - - - - - - -  //
  initLocalization() async{
    await localization.init(mapLocales: CustomLocale.LOCALS, initLanguageCode: initLanguage ?? CustomLocale.FR);
    final GetStorage storage = DependencyInjection.getIt<GetStorage>();
    localization.onTranslatedLanguage = (_) async{
      initLocation = await LocalStorage.read(key: "INIT_LOCATION", storage: storage);
      setState(() {});
    };
    setState(() {
      localization.translate(initLanguage ?? CustomLocale.FR);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => OnBoardingCubit(storage: DependencyInjection.getIt<GetStorage>())),
          BlocProvider(create: (_) => RegisterCubit(context: context, authRepository: DependencyInjection.getIt(), userRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt())),
          BlocProvider(create: (_) => LoginCubit(context: context, authRepository: DependencyInjection.getIt(), userRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt())),
          BlocProvider(create: (_) => ForgetPasswordCubit(context: context, authRepository: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt())),
          BlocProvider(create: (_) => IndexCubit(context: context, connectivity: DependencyInjection.getIt())),
          BlocProvider(create: (_) => HomeCubit(context: context, vendorRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt())),
          BlocProvider(create: (_) => WishlistCubit(context: context, storage: DependencyInjection.getIt(), wishListRepository: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt())),
          BlocProvider(create: (_) => NotificationCubit(context: context, notificationRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt())),
          BlocProvider(create: (_) => SettingsCubit(context: context, storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt(), userRepository: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt(), authRepository: DependencyInjection.getIt())),
          BlocProvider(create: (_) => VendorDetailsCubit(context: context, userRepository: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt(), reviewRepository: DependencyInjection.getIt(), wishListRepository: DependencyInjection.getIt(), reportRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt())),
          BlocProvider(create: (_) => VendorNewOrderCubit(context: context, storage: DependencyInjection.getIt(), connectivity: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt(), notificationRepository: DependencyInjection.getIt())),
          BlocProvider(create: (_) => VendorOrdersCubit(context: context, storage: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt())),
          BlocProvider(create: (_) => BeVendorCubit(context: context, notificationRepository: DependencyInjection.getIt(), vendorRepository: DependencyInjection.getIt(), userRepository: DependencyInjection.getIt(), storage: DependencyInjection.getIt())),
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
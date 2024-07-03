import 'package:berkania/dependency_injection.dart';
import 'package:berkania/utils/helpers/network.dart';
import 'package:berkania/utils/local/storage/local_storage.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:berkania/utils/theme/theme_app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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

  // - - - - - - - - - - - - - - - - - - SETUP FIREBASE CRASHLYTICS - - - - - - - - - - - - - - - - - -  //
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
    localization.translate(initLanguage ?? CustomLocale.FR);
    final GetStorage storage = DependencyInjection.getIt<GetStorage>();
    localization.onTranslatedLanguage = (_) async{
      initLocation = await LocalStorage.read(key: "INIT_LOCATION", storage: storage);
      setState(() {});
    };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DependencyInjection.onBoardingCubit),
          BlocProvider(create: (_) => DependencyInjection.registerCubit),
          BlocProvider(create: (_) => DependencyInjection.loginCubit),
          BlocProvider(create: (_) => DependencyInjection.forgetPasswordCubit),
          BlocProvider(create: (_) => DependencyInjection.indexCubit),
          BlocProvider(create: (_) => DependencyInjection.homeCubit),
          BlocProvider(create: (_) => DependencyInjection.wishlistCubit),
          BlocProvider(create: (_) => DependencyInjection.notificationCubit),
          BlocProvider(create: (_) => DependencyInjection.settingsCubit),
          BlocProvider(create: (_) => DependencyInjection.vendorDetailsCubit),
          BlocProvider(create: (_) => DependencyInjection.vendorNewOrderCubit),
          BlocProvider(create: (_) => DependencyInjection.vendorOrdersCubit),
          BlocProvider(create: (_) => DependencyInjection.beVendorCubit),
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
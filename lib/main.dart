import 'package:berkania/dependency_injection.dart';
import 'package:berkania/presentation/auth/forget_password/forget_password_cubit.dart';
import 'package:berkania/presentation/auth/login/login_cubit.dart';
import 'package:berkania/presentation/auth/register/register_cubit.dart';
import 'package:berkania/presentation/home/home_cubit.dart';
import 'package:berkania/presentation/index/index_cubit.dart';
import 'package:berkania/presentation/notification/notification_cubit.dart';
import 'package:berkania/presentation/profile/profile_cubit.dart';
import 'package:berkania/presentation/wishlist/wishlist_cubit.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:berkania/utils/theme/theme_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';
import 'utils/localisation/custom_locale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // - - - - - - - - - - - - - - - - - - INIT FIREBASE - - - - - - - - - - - - - - - - - -  //
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // - - - - - - - - - - - - - - - - - - DI - - - - - - - - - - - - - - - - - -  //
  DependencyInjection.setup();

  // - - - - - - - - - - - - - - - - - - INIT LOCAL STORAGE - - - - - - - - - - - - - - - - - -  //
  await GetStorage.init();

  // - - - - - - - - - - - - - - - - - - HIDE THE TOP STATUS BAR AND SYSTEM BOTTOM BAR - - - - - - - - - - - - - - - - - -  //
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  // - - - - - - - - - - - - - - - - - - RUN APP - - - - - - - - - - - - - - - - - -  //
  runApp(const App());
}

class App extends StatefulWidget {

  const App({super.key});

  @override
  State<App> createState() => _IndexState();
}

class _IndexState extends State<App> {

  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    initLocalization();
    super.initState();
  }

  // - - - - - - - - - - - - - - - - - - INIT LOCALISATION - - - - - - - - - - - - - - - - - -  //
  initLocalization() async{
    await localization.init(mapLocales: CustomLocale.LOCALS, initLanguageCode: CustomLocale.EN);
    localization.onTranslatedLanguage = (Locale? locale) { setState(() {}); };
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DependencyInjection.getIt<RegisterCubit>()),
          BlocProvider(create: (_) => DependencyInjection.getIt<LoginCubit>()),
          BlocProvider(create: (_) => DependencyInjection.getIt<ForgetPasswordCubit>()),
          BlocProvider(create: (_) => DependencyInjection.getIt<IndexCubit>()),
          BlocProvider(create: (_) => DependencyInjection.getIt<HomeCubit>()),
          BlocProvider(create: (_) => DependencyInjection.getIt<WishlistCubit>()),
          BlocProvider(create: (_) => DependencyInjection.getIt<NotificationCubit>()),
          BlocProvider(create: (_) => DependencyInjection.getIt<ProfileCubit>()),
        ],
        child: MaterialApp.router(
            themeMode: ThemeMode.system,
            theme: ThemeApp.lightTheme,
            darkTheme: ThemeApp.darkTheme,
            debugShowCheckedModeBanner: false,
            supportedLocales: localization.supportedLocales,
            localizationsDelegates: localization.localizationsDelegates,
            routerConfig: CustomRouter.CONFIG_ROUTER)
    );
  }
}
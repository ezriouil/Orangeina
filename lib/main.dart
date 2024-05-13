import 'package:berkania/dependency_injection.dart';
import 'package:berkania/presentation/auth/forget_password/forget_password_cubit.dart';
import 'package:berkania/presentation/auth/login/login_cubit.dart';
import 'package:berkania/presentation/auth/register/register_cubit.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:berkania/utils/theme/theme_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'firebase_options.dart';
import 'utils/localisation/custom_locale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // - - - - - - - - - - - - - - - - - - INIT FIREBASE - - - - - - - - - - - - - - - - - -  //
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // - - - - - - - - - - - - - - - - - - FLUTTER LOCALISATION - - - - - - - - - - - - - - - - - -  //
  final FlutterLocalization localization = FlutterLocalization.instance;
  await localization.init(mapLocales: CustomLocale.LOCALS, initLanguageCode: CustomLocale.EN);

  // - - - - - - - - - - - - - - - - - - DI - - - - - - - - - - - - - - - - - -  //
  DependencyInjection.setup();

  // - - - - - - - - - - - - - - - - - - INIT LOCAL STORAGE - - - - - - - - - - - - - - - - - -  //
  await GetStorage.init();

  // - - - - - - - - - - - - - - - - - - RUN APP - - - - - - - - - - - - - - - - - -  //
  runApp(Index(localization: localization));
}

class Index extends StatelessWidget {
  final FlutterLocalization localization;

  const Index({super.key, required this.localization});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => DependencyInjection.getIt<RegisterCubit>()),
          BlocProvider(create: (_) => DependencyInjection.getIt<LoginCubit>()),
          BlocProvider(create: (_) => DependencyInjection.getIt<ForgetPasswordCubit>()),
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

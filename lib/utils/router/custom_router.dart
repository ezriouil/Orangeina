import 'package:berkania/presentation/auth/forget_password/forget_password_screen.dart';
import 'package:berkania/presentation/auth/login/login_screen.dart';
import 'package:berkania/presentation/home/home_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/auth/register/register_screen.dart';

class CustomRouter{
  CustomRouter._();


  // - - - - - - - - - - - - - - - - - - CONFIG ROUTER - - - - - - - - - - - - - - - - - -  //
  static final GoRouter CONFIG_ROUTER = GoRouter(
    initialLocation: LOGIN,
    routes: <RouteBase>[

      // - - -  LOGIN - - -  //
      GoRoute(
        name: LOGIN,
        path: LOGIN,
        builder: (BuildContext context, GoRouterState state) => const LoginScreen(),
      ),

      // - - -  REGISTER - - -  //
      GoRoute(
          name: REGISTER,
          path: REGISTER,
          builder: (BuildContext context, GoRouterState state) => const RegisterScreen()),

      // - - -  FORGET PASSWORD - - -  //
      GoRoute(
          name: FORGET_PASSWORD,
          path: FORGET_PASSWORD,
          builder: (BuildContext context, GoRouterState state) => const ForgetPasswordScreen()),

      // - - -  HOME - - -  //
      GoRoute(
          name: HOME,
          path: HOME,
          builder: (BuildContext context, GoRouterState state) => const HomeScreen()),

    ],
  );


  // - - - - - - - - - - - - - - - - - -  NAMES + PATHS - - - - - - - - - - - - - - - - - -  //
  static const String REGISTER = "/register";
  static const String LOGIN = "/login";
  static const String FORGET_PASSWORD = "/forget_password";
  static const String HOME = "/home";

}
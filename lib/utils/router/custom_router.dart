import 'package:berkania/presentation/auth/forget_password/forget_password_screen.dart';
import 'package:berkania/presentation/auth/login/login_screen.dart';
import 'package:berkania/presentation/vendor_details/vendor_details_screen.dart';
import 'package:berkania/presentation/vendor_new_order/vendor_new_order_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/auth/register/register_screen.dart';
import '../../presentation/index/index_screen.dart';
import '../../presentation/vendor_orders/vendor_orders_screen.dart';

class CustomRouter{
  CustomRouter._();


  // - - - - - - - - - - - - - - - - - - CONFIG ROUTER - - - - - - - - - - - - - - - - - -  //
  static final GoRouter CONFIG_ROUTER = GoRouter(

    initialLocation: INDEX,
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

      // - - -  INDEX - - -  //
      GoRoute(
        name: INDEX,
        path: INDEX,
        builder: (BuildContext context, GoRouterState state) => const IndexScreen(),
      ),

      // - - -  VENDOR_DETAILS - - -  //
      GoRoute(
        name: VENDOR_DETAILS,
        path: VENDOR_DETAILS,
        builder: (BuildContext context, GoRouterState state) => const VendorDetailsScreen(),
      ),

      // - - -  VENDOR_NEW_ORDER - - -  //
      GoRoute(
        name: VENDOR_NEW_ORDER,
        path: VENDOR_NEW_ORDER,
        builder: (BuildContext context, GoRouterState state) => const VendorNewOrderScreen(),
      ),

      // - - -  VENDOR_ORDERS - - -  //
      GoRoute(
        name: VENDOR_ORDERS,
        path: VENDOR_ORDERS,
        builder: (BuildContext context, GoRouterState state) => const VendorOrdersScreen(),
      ),

    ],
  );


  // - - - - - - - - - - - - - - - - - -  NAMES + PATHS - - - - - - - - - - - - - - - - - -  //
  static const String REGISTER = "/register";
  static const String LOGIN = "/login";
  static const String FORGET_PASSWORD = "/forget_password";
  static const String INDEX = "/index";
  static const String VENDOR_DETAILS = "/vendorDetails";
  static const String VENDOR_NEW_ORDER = "/vendorNewOrder";
  static const String VENDOR_ORDERS = "/vendorOrders";

}
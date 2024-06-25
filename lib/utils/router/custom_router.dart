import 'package:berkania/presentation/auth/forget_password/forget_password_screen.dart';
import 'package:berkania/presentation/auth/login/login_screen.dart';
import 'package:berkania/presentation/be_vendor/be_vendor_screen.dart';
import 'package:berkania/presentation/on_boarding/on_boarding_screen.dart';
import 'package:berkania/presentation/vendor_details/vendor_details_screen.dart';
import 'package:berkania/presentation/vendor_new_order/vendor_new_order_screen.dart';
import 'package:berkania/presentation/widgets/faq_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/auth/register/register_screen.dart';
import '../../presentation/index/index_screen.dart';
import '../../presentation/vendor_orders/vendor_orders_screen.dart';

class CustomRouter{
  CustomRouter._();

  static GoRouter router({required String? initialLocation}) {

    return GoRouter(
      initialLocation: initialLocation == null ? ON_BOARDING : initialLocation == "LOGIN"  ? LOGIN : INDEX,
      routes: <RouteBase>[

        // - - -  ON BOARDING - - -  //
        GoRoute(
          name: ON_BOARDING,
          path: ON_BOARDING,
          builder: (BuildContext context, GoRouterState state) =>
              const OnBoardingScreen(),
        ),

        // - - -  LOGIN - - -  //
        GoRoute(
          name: LOGIN,
          path: LOGIN,
          builder: (BuildContext context, GoRouterState state) =>
              const LoginScreen(),
        ),

        // - - -  REGISTER - - -  //
        GoRoute(
            name: REGISTER,
            path: REGISTER,
            builder: (BuildContext context, GoRouterState state) =>
                const RegisterScreen()),

        // - - -  FORGET PASSWORD - - -  //
        GoRoute(
            name: FORGET_PASSWORD,
            path: FORGET_PASSWORD,
            builder: (BuildContext context, GoRouterState state) =>
                const ForgetPasswordScreen()),

        // - - -  INDEX - - -  //
        GoRoute(
          name: INDEX,
          path: INDEX,
          builder: (BuildContext context, GoRouterState state) =>
              const IndexScreen(),
        ),

        // - - -  VENDOR_DETAILS - - -  //
        GoRoute(
          name: VENDOR_DETAILS,
          path: "$VENDOR_DETAILS/:id",
          builder: (BuildContext context, GoRouterState state) =>
              VendorDetailsScreen(id: state.pathParameters['id']!),
        ),

        // - - -  VENDOR_NEW_ORDER - - -  //
        GoRoute(
          name: VENDOR_NEW_ORDER,
          path: VENDOR_NEW_ORDER,
          builder: (BuildContext context, GoRouterState state) =>
              const VendorNewOrderScreen(),
        ),

        // - - -  VENDOR_ORDERS - - -  //
        GoRoute(
          name: VENDOR_ORDERS,
          path: VENDOR_ORDERS,
          builder: (BuildContext context, GoRouterState state) =>
              const VendorOrdersScreen(),
        ),

        // - - -  BE_VENDOR - - -  //
        GoRoute(
          name: BE_VENDOR,
          path: BE_VENDOR,
          builder: (BuildContext context, GoRouterState state) =>
              const BeVendorScreen(),
        ),
        // - - -  BE_VENDOR - - -  //
        GoRoute(
          name: FAQ,
          path: FAQ,
          builder: (BuildContext context, GoRouterState state) =>
              const FAQScreen(),
        ),
      ],
    );
  }

  static const String ON_BOARDING = "/on_boarding";
  static const String LOGIN = "/login";
  static const String REGISTER = "/register";
  static const String FORGET_PASSWORD = "/forget_password";
  static const String INDEX = "/index";
  static const String VENDOR_DETAILS = "/vendorDetails";
  static const String VENDOR_NEW_ORDER = "/vendorNewOrder";
  static const String VENDOR_ORDERS = "/vendorOrders";
  static const String BE_VENDOR = "/beVendor";
  static const String FAQ = "/faq";

}
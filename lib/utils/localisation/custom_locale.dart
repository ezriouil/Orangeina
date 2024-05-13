import 'package:berkania/utils/localisation/languages/arabic.dart';
import 'package:berkania/utils/localisation/languages/english.dart';
import 'package:berkania/utils/localisation/languages/french.dart';
import 'package:flutter_localization/flutter_localization.dart';

mixin CustomLocale{

  static const List<MapLocale> LOCALS = [
    MapLocale(EN, English.EN),
    MapLocale(FR, French.FR),
    MapLocale(AR, Arabic.AR),
  ];

  static const String EN = "en";
  static const String FR = "fr";
  static const String AR = "ar";

  // - - - - - - - - - - - - - - - - - - LOGIN SCREEN - - - - - - - - - - - - - - - - - -  //
  static const String LOGIN_TITLE = "title";
  static const String LOGIN_SUB_TITLE = "sub title";
  static const String LOGIN_FORGET_THE_PASSWORD = "Forget Password ?";
  static const String LOGIN_LOGIN = "login";
  static const String LOGIN_CREATE_NEW_ACCOUNT = "Create new account";
  static const String LOGIN_LOGIN_WITH_GOOGLE = "Log in with Google";
  static const String LOGIN_CHANGE_THE_LANGUAGE = "Change the language (en)";

  // - - - - - - - - - - - - - - - - - - REGISTER SCREEN - - - - - - - - - - - - - - - - - -  //
  static const String REGISTER_TITLE = "Let's create your account";
  static const String REGISTER_FIRST_NAME = "First Name";
  static const String REGISTER_LAST_NAME = "Last Name";
  static const String REGISTER_CONFIRM_PASSWORD = "Confirm Password";
  static const String REGISTER_FIRST_NAME_VALIDATOR = "First Name Validator";
  static const String REGISTER_LAST_NAME_VALIDATOR = "Last Name Validator";
  static const String REGISTER_CONFIRM_PASSWORD_VALIDATOR = "Confirm Password Validator";
  static const String REGISTER_IM_AGREE = "I'm agree";
  static const String REGISTER_TERMS_OF_USE = "Terms of Use";
  static const String REGISTER_PRIVACY_POLICY = "Privacy Policy";
  static const String REGISTER_CREATE_ACCOUNT = "Create account";
  static const String REGISTER_WITH_GOOGLE = "Register with Google";

  // - - - - - - - - - - - - - - - - - - FORGET PASSWORD SCREEN - - - - - - - - - - - - - - - - - -  //
  static const String FORGET_PASSOWRD_TITLE = "Forget password";
  static const String FORGET_PASSOWRD_SUB_TITLE = "Don't worry sometimes people can forget too, entre your email and we will send you a password reset link.";
  static const String FORGET_PASSOWRD_EMAIL = "Email";
  static const String FORGET_PASSOWRD_SEND = "Send";

  // - - - - - - - - - - - - - - - - - - REUSABLE  - - - - - - - - - - - - - - - - - -  //
  static const String EMAIL = "Email";
  static const String PASSWORD = "Password";
  static const String EMAIL_VALIDATOR = "Email Validator";
  static const String PASSWORD_VALIDATOR = "Password Validator";
  static const String OR = "Or";

}
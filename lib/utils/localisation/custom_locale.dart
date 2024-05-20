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
  static const String REGISTER_CHECK_BOX_TITLE_ERROR = "register check box title error";
  static const String REGISTER_PASSWORD_NOT_MATCHED_TITLE_ERROR = "register password not matched title error";
  static const String REGISTER_CHECK_BOX_SUB_TITLE_ERROR = "register check box sub title error";
  static const String REGISTER_PASSWORD_NOT_MATCHED_SUB_TITLE_ERROR = "register password not matched sub title error";

  // - - - - - - - - - - - - - - - - - - FORGET PASSWORD SCREEN - - - - - - - - - - - - - - - - - -  //
  static const String FORGET_PASSOWRD_TITLE = "Forget password";
  static const String FORGET_PASSOWRD_SUB_TITLE = "Don't worry sometimes people can forget too, entre your email and we will send you a password reset link.";
  static const String FORGET_PASSOWRD_EMAIL = "Email";
  static const String FORGET_PASSOWRD_EMAIL_TITLE_INVALID = "Email invalid title";
  static const String FORGET_PASSOWRD_EMAIL_SUB_TITLE_INVALID = "Email invalid sub title";
  static const String FORGET_PASSOWRD_SEND = "Send";

  // - - - - - - - - - - - - - - - - - - INDEX - - - - - - - - - - - - - - - - - -  //
  static const String INDEX_EXPLORE_TITLE = "Index Explore Title";
  static const String INDEX_WISHLIST_TITLE= "Index Wishlist Title";
  static const String INDEX_NOTIFICATION_TITLE = "Index Notification Title";
  static const String INDEX_SETTINGS_TITLE = "Index Settings Title";

  // - - - - - - - - - - - - - - - - - - HOME SCREEN - - - - - - - - - - - - - - - - - -  //
  static const String HOME_PERMISSION_TITLE = "Home Permission Title";
  static const String HOME_PERMISSION_SUB_TITLE = "Home Permission Sub Title";
  static const String HOME_PERMISSION_BUTTON_ENABLE = "Home Permission Button Enable";

  // - - - - - - - - - - - - - - - - - - SETTINGS SCREEN - - - - - - - - - - - - - - - - - -  //
  static const String SETTINGS_PROFILE_TITLE = "Settings Profile Title";
  static const String SETTINGS_UPDATE_FULL_NAME_TITLE = "Settings Update Full Name Title";
  static const String SETTINGS_UPDATE_FULL_NAME_SUB_TITLE = "Settings Update Full Name Sub Title";
  static const String SETTINGS_UPDATE_EMAIL_TITLE = "Settings Update Email Title";
  static const String SETTINGS_UPDATE_EMAIL_SUB_TITLE = "Settings Update Email Sub Title";
  static const String SETTINGS_UPDATE_PASSWORD_TITLE = "Settings Update Password Title";
  static const String SETTINGS_UPDATE_PASSOWRD_SUB_TITLE = "Settings Update Password Sub Title";
  static const String SETTINGS_UPDATE_PHONE_TITLE = "Settings Update Phone Title";
  static const String SETTINGS_UPDATE_PHONE_SUB_TITLE = "Settings Update Phone Sub Title";
  static const String SETTINGS_DISPLAY_TITLE = "Settings Display Title";
  static const String SETTINGS_UPDATE_DARK_MODE_TITLE = "Settings Update Dark Mode Title";
  static const String SETTINGS_UPDATE_DARK_MODE_SUB_TITLE = "Settings Update Dark Mode Sub Title";
  static const String SETTINGS_UPDATE_HIDE_AUTH_TITLE = "Settings Update Hide Auth Title";
  static const String SETTINGS_UPDATE_HIDE_AUTH_SUB_TITLE = "Settings Update Hide Auth Sub Title";
  static const String SETTINGS_UPDATE_LANGUAGE_TITLE = "Settings Update Language Title";
  static const String SETTINGS_UPDATE_LANGUAGE_SUB_TITLE = "Settings Update Language Sub Title";
  static const String SETTINGS_OTHERS_TITLE = "Settings Others Title";
  static const String SETTINGS_PRIVACY_AND_SECURITY_TITLE = "Settings Privacy And Security Title";
  static const String SETTINGS_PRIVACY_AND_SECURITY_SUB_TITLE = "Settings Privacy And Security Sub Title";
  static const String SETTINGS_HELP_AND_SUPPOR_TITLE = "Settings Help And Support Title";
  static const String SETTINGS_HELP_AND_SUPPOR_SUB_TITLE = "Settings Help And Support Sub Title";
  static const String SETTINGS_ABOUT_TITLE = "Settings About Title";
  static const String SETTINGS_ABOUT_SUB_TITLE = "Settings About Sub Title";
  static const String SETTINGS_APP_VERSION_TITLE = "Settings App Version Title";
  static const String SETTINGS_PHONE = "Settings Phone";
  static const String SETTINGS_BUTTON_UPDATE_TITLE = "Settings Button Update Title";


  // - - - - - - - - - - - - - - - - - - REUSABLE  - - - - - - - - - - - - - - - - - -  //
  static const String EMAIL = "Email";
  static const String PASSWORD = "Password";
  static const String EMAIL_VALIDATOR = "Email Validator";
  static const String PASSWORD_VALIDATOR = "Password Validator";
  static const String OR = "Or";
  static const String LOADING_TITLE = "loading_title";
  static const String LOADING_SUB_TITLE = "loading_sub_title";
  static const String ERROR_TITLE = "error_title";
  static const String ERROR_SUB_TITLE = "error_sub_title";
  static const String ERROR_BUTTON_TITLE = "error_button_title";
  static const String NETWORK_TITLE = "title notwork";
  static const String NETWORK_SUB_TITLE = "sub title notwork";

}
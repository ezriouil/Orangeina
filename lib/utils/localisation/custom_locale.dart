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
  static const String HOME_SHOW_MY_LOCATION_TITLE = "Home Show My Location Title";
  static const String HOME_SHOW_MY_LOCATION_SUB_TITLE = "Home Show My Location Sub Title";
  static const String HOME_ENABLE_MAP_SATELLITE_TITLE = "Home Enable Map Satellite Title";
  static const String HOME_ENABLE_MAP_SATELLITE_SUB_TITLE = "Home Enable Map Satellite Sub Title";
  static const String HOME_ENABLE_MAP_TRAFFIC_TITLE = "Home Enable Map Traffic Title";
  static const String HOME_ENABLE_MAP_TRAFFIC_SUB_TITLE = "Home Enable Map Traffic Sub Title";
  static const String HOME_ENABLE_MAP_FILTER_TITLE = "Home Enable Map Filter Title";
  static const String HOME_ENABLE_MAP_FILTER_SUB_TITLE = "Home Enable Map Filter Sub Title";
  static const String HOME_ENABLE_MAP_REFRESH_TITLE = "Home Enable Map Refresh Title";
  static const String HOME_ENABLE_MAP_REFRESH_SUB_TITLE = "Home Enable Map Refresh Sub Title";
  static const String HOME_ENABLE_MAP_VENDORS_TITLE = "Home Enable Map Vendors Title";
  static const String HOME_ENABLE_MAP_VENDORS_SUB_TITLE = "Home Enable Map Vendors Sub Title";

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
  static const String SETTINGS_BE_VENDOR_TITLE = "Settings Be Vendor Title";
  static const String SETTINGS_BE_VENDOR_SUB_TITLE = "Settings Be Vendor Sub Title";
  static const String SETTINGS_VENDOR_SECTION_TITLE = "Settings Vendor Section Title";
  static const String SETTINGS_JOB_TITLE = "Settings Job Title";
  static const String SETTINGS_VENDOR_NEW_ORDER_TITLE = "Settings Vendor New Order Title";
  static const String SETTINGS_VENDOR_NEW_ORDER_SUB_TITLE = "Settings Vendor New Order Sub Title";
  static const String SETTINGS_VENDOR_ORDERS_TITLE = "Settings Vendor Orders Title";
  static const String SETTINGS_VENDOR_ORDES_SUB_TITLE = "Settings Vendor Orders Sub Title";
  static const String SETTINGS_VENDOR_ONLINE_OFFLINE_TITLE = "Settings Vendor Online Offline Title";
  static const String SETTINGS_VENDOR_ONLINE_OFFLINE_SUB_TITLE = "Settings Vendor Online Offline Sub Title";
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
  static const String SETTINGS_UPDATE_IMAGE_BUTTON_GALLERY_TITLE = "Settings Update Image Button Gallery Title";
  static const String SETTINGS_UPDATE_IMAGE_BUTTON_DISMISS_TITLE = "Settings Update Image Button Dismiss Title";

  // - - - - - - - - - - - - - - - - - - VENDOR NEW ORDER SCREEN - - - - - - - - - - - - - - - - - -  //
  static const String NEW_ORDER_TITLE = "New Order Title";
  static const String NEW_ORDER_SUB_TITLE = "New Order Sub Title";
  static const String NEW_ORDER_HINT = "New Order Hint";
  static const String NEW_ORDER_DELIVERY_TIME = "New Order Delivery Time";
  static const String NEW_ORDER_BAG_PRICE = "New Order Bag Price";
  static const String NEW_ORDER_TOTAL_PRICE = "New Order Total Price";
  static const String NEW_ORDER_CONFIRM_BUTTON = "New Order Confirm Button";
  static const String NEW_ORDER_MAD = "New Order MAD";

  // - - - - - - - - - - - - - - - - - - VENDOR ORDERS SCREEN - - - - - - - - - - - - - - - - - -  //


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
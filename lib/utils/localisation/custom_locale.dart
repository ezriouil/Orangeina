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
  static const String ORDERS_TITLE = "Orders Title";
  static const String ORDERS_BAG_PRICE_TITLE = "Orders Bag Price Title";
  static const String ORDERS_Quantity_TITLE = "Orders Quantity Title";
  static const String ORDERS_CREATE_AT_TITLE = "Orders Create At Title";
  static const String ORDERS_SELECTED_AT_TITLE = "Orders Selected At Title";
  static const String ORDERS_MAD_TITLE = "Orders MAD Title";
  static const String ORDERS_KG_TITLE = "Orders KG Title";
  static const String ORDERS_TOTAL_TITLE = "Orders Total Title";
  static const String ORDERS_STATUS_TITLE = "Orders Status Title";
  static const String ORDERS_EMPTY_LIST_TITLE = "Orders Empty List Title";

  // - - - - - - - - - - - - - - - - - - NOTIFICATIONS SCREEN - - - - - - - - - - - - - - - - - -  //
  static const String NOTIFICATIONS_TITLE = "Notifications Title";
  static const String NOTIFICATION_TITLE = "Notification Title";
  static const String NOTIFICATION_DIALOG_DELETE_TITLE = "Notification Dialog Delete Title";
  static const String NOTIFICATION_DIALOG_DISMISS_TITLE = "Notification Dialog Dismiss Title";
  static const String NOTIFICATION_EMPTY_LIST_TITLE = "Notification Empty List Title";

  // - - - - - - - - - - - - - - - - - - WISHLISTS SCREEN - - - - - - - - - - - - - - - - - -  //
  static const String WISHLISTS_TITLE = "WishLists Title";
  static const String WSIHLIST_DIALOG_DELETE_TITLE = "Wishlist Dialog Delete Title";
  static const String WSIHLIST_DIALOG_DISMISS_TITLE = "Wishlist Dialog Dismiss Title";
  static const String WISHLIST_EMPTY_LIST_TITLE = "WishList Empty List Title";

  // - - - - - - - - - - - - - - - - - - BE VENDOR SCREEN - - - - - - - - - - - - - - - - - -  //
  static const String BE_VENDOR_TITLE = "Be Vendor Title";
  static const String BE_VENDOR_CIN = "Be Vendor CIN";
  static const String BE_VENDOR_PHONE = "Be Vendor Phone";
  static const String BE_VENDOR_BIRTHDAY = "Be Vendor Birthday";
  static const String BE_VENDOR_STEP_1_TITLE = "Be Vendor Step 1 Title";
  static const String BE_VENDOR_TITLE_1 = "Be Vendor Title 1";
  static const String BE_VENDOR_GENDER_TITLE = "Be Gender Title";
  static const String BE_VENDOR_GENDER_MAN_TITLE = "Be Gender Man Title";
  static const String BE_VENDOR_GENDER_WOMAN_TITLE = "Be Gender Woman Title";

  static const String BE_VENDOR_STEP_2_TITLE = "Be Vendor Step 2 Title";
  static const String BE_VENDOR_TITLE_2 = "Be Vendor Title 2";
  static const String BE_VENDOR_PICK_CAR_TYPE_TITLE = "Be Vendor Pick Car Type Title";
  static const String BE_VENDOR_CAR_TRICYCLE_TYPE_TITLE = "Be Vendor Car Tricycle Type Title";
  static const String BE_VENDOR_CAR_PICK_UP_TYPE_TITLE = "Be Vendor Car Pick Up Type Title";
  static const String BE_VENDOR_CAR_CAR_TYPE_TITLE = "Be Vendor Car Car Type Title";
  static const String BE_VENDOR_CAR_THUMBNAIL_TITLE = "Be Vendor Car Thumbnail Title";
  static const String BE_VENDOR_CAR_INFO_TITLE = "Be Vendor Car Info Title";
  static const String BE_VENDOR_CAR_ASSURANCE_NUMBER_TITLE = "Be Vendor Car Assurance Number Title";
  static const String BE_VENDOR_CAR_REGISTRATION_NUMBER_TITLE = "Be Vendor Car Registration Number Title";

  static const String BE_VENDOR_STEP_3_TITLE = "Be Vendor Step 3 Title";
  static const String BE_VENDOR_TITLE_3 = "Be Vendor Title 3";
  static const String BE_VENDOR_CIN_FRONT_THUMBNAIL_TITLE = "Be Vendor Cin Front Thumbnail Title";
  static const String BE_VENDOR_CIN_BACK_THUMBNAIL_TITLE = "Be Vendor Cin Back Thumbnail Title";
  static const String BE_VENDOR_CAR_REGISTRATION_NUMBER_THUMBNAIL_TITLE = "Be Vendor Car Registration Number Thumbnail Title";
  static const String BE_VENDOR_CAR_ASSURANCE_NUMBER_THUMBNAIL_TITLE = "Be Vendor Car Assurance Number Thumbnail Title";

  static const String BE_VENDOR_BUTTON_CONTINUE_TITLE = "Be Vendor Button Continue Title";
  static const String BE_VENDOR_BUTTON_BACK_TITLE = "Be Vendor Button Back Title";

  static const String BE_VENDOR_SUCCESS_STATE_TITLE = "Be Vendor Success State Title";
  static const String BE_VENDOR_SUCCESS_STATE_SUB_TITLE = "Be Vendor Success State Sub Title";
  static const String BE_VENDOR_SUCCESS_STATE_BUTTON_TITLE = "Be Vendor Success State Button Title";

  // - - - - - - - - - - - - - - - - - - VENDOR DETAILS SCREEN - - - - - - - - - - - - - - - - - -  //
  static const String VENDOR_DETAILS_TITLE = "Vendor Details Title";
  static const String VENDOR_DETAILS_TITLE_BUTTON_FEEDBACK = "Vendor Details Title Button Feedback";
  static const String VENDOR_DETAILS_TITLE_BUTTON_REPORT = "Vendor Details Title Button Report";
  static const String VENDOR_DETAILS_TITLE_TAB_MAP = "Vendor Details Title Tab Map";
  static const String VENDOR_DETAILS_TITLE_TAB_REVIEWS = "Vendor Details Title Tab Reviews";

  static const String VENDOR_DETAILS_FEEDBACK_TITLE = "Vendor Details Feedback Title";
  static const String VENDOR_DETAILS_FEEDBACK_SUB_TITLE = "Vendor Details Feedback Sub Title";
  static const String VENDOR_DETAILS_FEEDBACK_TEXT_FILED_TITLE = "Vendor Details Feedback Text Field Title";
  static const String VENDOR_DETAILS_FEEDBACK_HINT_TITLE = "Vendor Details Feedback Hint Title";

  static const String VENDOR_DETAILS_REPORT_TITLE = "Vendor Details Report Title";
  static const String VENDOR_DETAILS_REPORT_SUB_TITLE = "Vendor Details Report Sub Title";

  static const String VENDOR_DETAILS_TITLE_BUTTON_CANCEL = "Vendor Details Title Button Cancel";
  static const String VENDOR_DETAILS_TITLE_BUTTON_SUBMIT = "Vendor Details Title Button Submit";

  static const String VENDOR_DETAILS_REVIEWS_EMPTY_LIST = "Vendor Details Reviews Empty List";

  static const String VENDOR_DETAILS_REPORT_REASON_1 = "Vendor Details Report Reason 1";
  static const String VENDOR_DETAILS_REPORT_REASON_2 = "Vendor Details Report Reason 2";
  static const String VENDOR_DETAILS_REPORT_REASON_3 = "Vendor Details Report Reason 3";
  static const String VENDOR_DETAILS_REPORT_REASON_4 = "Vendor Details Report Reason 4";
  static const String VENDOR_DETAILS_REPORT_REASON_5 = "Vendor Details Report Reason 5";

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
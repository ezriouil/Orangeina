import 'package:berkania/utils/localisation/custom_locale.dart';

class English {
  English._();

  static const Map<String, dynamic> EN = {

    // - - - - - - - - - - - - - - - - - - REUSABLE  - - - - - - - - - - - - - - - - - -  //
    CustomLocale.EMAIL: "Email",
    CustomLocale.PASSWORD: "Password",
    CustomLocale.EMAIL_VALIDATOR: "Email is required",
    CustomLocale.PASSWORD_VALIDATOR: "Password is required",
    CustomLocale.OR: "Or",
    CustomLocale.LOADING_TITLE: "Please wait",
    CustomLocale.LOADING_SUB_TITLE: "We are processing your information and it may take a few seconds, please wait.",
    CustomLocale.ERROR_TITLE: "",
    CustomLocale.ERROR_SUB_TITLE: "",
    CustomLocale.ERROR_BUTTON_TITLE: "Try again",
    CustomLocale.NETWORK_TITLE: "No Network Connection",
    CustomLocale.NETWORK_SUB_TITLE: "Make Sure Your Device Is Connected To The Network",

    // - - - - - - - - - - - - - - - - - - LOGIN SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.LOGIN_TITLE: "Welcome back,",
    CustomLocale.LOGIN_SUB_TITLE: "Discover Limitless Choices and Unmatched Convenience..",
    CustomLocale.LOGIN_FORGET_THE_PASSWORD: "Forget Password ?",
    CustomLocale.LOGIN_LOGIN: "Login",
    CustomLocale.LOGIN_CREATE_NEW_ACCOUNT: "Create new account",
    CustomLocale.LOGIN_LOGIN_WITH_GOOGLE: "Log in with Google",
    CustomLocale.LOGIN_CHANGE_THE_LANGUAGE: "Change the language (en)",

    // - - - - - - - - - - - - - - - - - - REGISTER SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.REGISTER_TITLE: "Let's create your account",
    CustomLocale.REGISTER_FIRST_NAME: "First Name",
    CustomLocale.REGISTER_LAST_NAME: "Last Name",
    CustomLocale.REGISTER_CONFIRM_PASSWORD: "Confirm Password",
    CustomLocale.REGISTER_FIRST_NAME_VALIDATOR: "First Name is required",
    CustomLocale.REGISTER_LAST_NAME_VALIDATOR: "Last Name is required",
    CustomLocale.REGISTER_CONFIRM_PASSWORD_VALIDATOR: "Confirm Password is required",
    CustomLocale.REGISTER_IM_AGREE: "I'm agree",
    CustomLocale.REGISTER_TERMS_OF_USE: "Terms of Use",
    CustomLocale.REGISTER_PRIVACY_POLICY: "Privacy Policy",
    CustomLocale.REGISTER_CREATE_ACCOUNT: "Create account",
    CustomLocale.REGISTER_WITH_GOOGLE: "Register with Google",
    CustomLocale.REGISTER_CHECK_BOX_TITLE_ERROR: "Check The Box",
    CustomLocale.REGISTER_PASSWORD_NOT_MATCHED_TITLE_ERROR: "Password Not Matched",
    CustomLocale.REGISTER_CHECK_BOX_SUB_TITLE_ERROR: "You Have Must Check The Box To Continue",
    CustomLocale.REGISTER_PASSWORD_NOT_MATCHED_SUB_TITLE_ERROR: "The Passwords Must Be The Same",

    // - - - - - - - - - - - - - - - - - - FORGET PASSWORD SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.FORGET_PASSOWRD_TITLE: "Forget password",
    CustomLocale.FORGET_PASSOWRD_SUB_TITLE: "Don't worry sometimes people can forget to, enter your email and we will send you a password reset link.",
    CustomLocale.FORGET_PASSOWRD_SEND: "Send",
    CustomLocale.FORGET_PASSOWRD_EMAIL_TITLE_INVALID: "Invalid Email",
    CustomLocale.FORGET_PASSOWRD_EMAIL_SUB_TITLE_INVALID: "Email Must Be At Least 6 Characters And @",

    // - - - - - - - - - - - - - - - - - - INDEX - - - - - - - - - - - - - - - - - -  //
    CustomLocale.INDEX_EXPLORE_TITLE: "Explore",
    CustomLocale.INDEX_WISHLIST_TITLE: "Wishlist",
    CustomLocale.INDEX_NOTIFICATION_TITLE: "Notification",
    CustomLocale.INDEX_SETTINGS_TITLE: "Settings",

    // - - - - - - - - - - - - - - - - - - HOME SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.HOME_PERMISSION_TITLE: "Permission needed",
    CustomLocale.HOME_PERMISSION_SUB_TITLE: "To serve you best user experience we need permission from location services",
    CustomLocale.HOME_PERMISSION_BUTTON_ENABLE: "Enable",

  CustomLocale.HOME_SHOW_MY_LOCATION_TITLE : "My Location",
  CustomLocale.HOME_SHOW_MY_LOCATION_SUB_TITLE : "Show your position on map",
  CustomLocale.HOME_ENABLE_MAP_SATELLITE_TITLE : "Map Satellite",
  CustomLocale.HOME_ENABLE_MAP_SATELLITE_SUB_TITLE : "Enjoy with to new theme designed for you",
  CustomLocale.HOME_ENABLE_MAP_TRAFFIC_TITLE : "Traffic",
  CustomLocale.HOME_ENABLE_MAP_TRAFFIC_SUB_TITLE : "Show traffic and roads",
  CustomLocale.HOME_ENABLE_MAP_FILTER_TITLE : "Filter",
  CustomLocale.HOME_ENABLE_MAP_FILTER_SUB_TITLE : "You can filter on map by rating",
  CustomLocale.HOME_ENABLE_MAP_REFRESH_TITLE : "Refresh",
  CustomLocale.HOME_ENABLE_MAP_REFRESH_SUB_TITLE : "Refresh vendors automatically",
  CustomLocale.HOME_ENABLE_MAP_VENDORS_TITLE : "Vendors",
  CustomLocale.HOME_ENABLE_MAP_VENDORS_SUB_TITLE : "You can show and hide vendors on map",

  // - - - - - - - - - - - - - - - - - - SETTINGS SCREEN - - - - - - - - - - - - - - - - - -  //
  CustomLocale.SETTINGS_PROFILE_TITLE : "Profile",
  CustomLocale.SETTINGS_UPDATE_FULL_NAME_TITLE : "Update Full Name",
  CustomLocale.SETTINGS_UPDATE_FULL_NAME_SUB_TITLE : "Change your first name and last name any time.",
  CustomLocale.SETTINGS_UPDATE_EMAIL_TITLE : "Update Email",
  CustomLocale.SETTINGS_UPDATE_EMAIL_SUB_TITLE : "Change your email any time.",
  CustomLocale.SETTINGS_UPDATE_PASSWORD_TITLE : "Update Password",
  CustomLocale.SETTINGS_UPDATE_PASSOWRD_SUB_TITLE : "Change your password any time.",
  CustomLocale.SETTINGS_UPDATE_PHONE_TITLE : "Update Phone",
  CustomLocale.SETTINGS_UPDATE_PHONE_SUB_TITLE : "Change your phone number any time.",
  CustomLocale.SETTINGS_VENDOR_SECTION_TITLE : "Vendor Section",
  CustomLocale.SETTINGS_BE_VENDOR_TITLE : "Be Vendor",
  CustomLocale.SETTINGS_BE_VENDOR_SUB_TITLE : "Apply now to become a seller.",
  CustomLocale.SETTINGS_JOB_TITLE : "Job",
  CustomLocale.SETTINGS_VENDOR_NEW_ORDER_TITLE : "New Order",
  CustomLocale.SETTINGS_VENDOR_NEW_ORDER_SUB_TITLE : "Demand new order from Berkania.",
  CustomLocale.SETTINGS_VENDOR_ORDERS_TITLE : "Orders",
  CustomLocale.SETTINGS_VENDOR_ONLINE_OFFLINE_TITLE : "Online / Offline",
  CustomLocale.SETTINGS_VENDOR_ONLINE_OFFLINE_SUB_TITLE : "Automatically show or hide on map.",
  CustomLocale.SETTINGS_VENDOR_ORDES_SUB_TITLE : "Show my orders.",
  CustomLocale.SETTINGS_UPDATE_LANGUAGE_TITLE : "Update Language",
  CustomLocale.SETTINGS_UPDATE_LANGUAGE_SUB_TITLE : "Arabic & English & French",
  CustomLocale.SETTINGS_OTHERS_TITLE : "Others",
  CustomLocale.SETTINGS_PRIVACY_AND_SECURITY_TITLE : "Privacy And Security",
  CustomLocale.SETTINGS_PRIVACY_AND_SECURITY_SUB_TITLE : "See our privacy and security",
  CustomLocale.SETTINGS_HELP_AND_SUPPOR_TITLE : "Help And Support",
  CustomLocale.SETTINGS_HELP_AND_SUPPOR_SUB_TITLE : "You can contact us to help you.",
  CustomLocale.SETTINGS_ABOUT_TITLE : "About us",
  CustomLocale.SETTINGS_ABOUT_SUB_TITLE : "Information about application.",
  CustomLocale.SETTINGS_SIGN_OUT_TITLE : "Sign Out",
  CustomLocale.SETTINGS_SIGN_OUT_SUB_TITLE : "You are going to out from the application.",
  CustomLocale.SETTINGS_APP_VERSION_TITLE : "version 1.0.0",
  CustomLocale.SETTINGS_PHONE : "Phone",
  CustomLocale.SETTINGS_BUTTON_UPDATE_TITLE : "Update",
  CustomLocale.SETTINGS_UPDATE_IMAGE_BUTTON_GALLERY_TITLE : "Gallery",
  CustomLocale.SETTINGS_UPDATE_IMAGE_BUTTON_DISMISS_TITLE : "Dismiss",


    // - - - - - - - - - - - - - - - - - - VENDOR NEW ORDER SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.NEW_ORDER_TITLE: "New Order",
    CustomLocale.NEW_ORDER_SUB_TITLE: "Fill how much KG you want and don't forget set date to you receive your command.",
    CustomLocale.NEW_ORDER_HINT: "We will notify you with more details about your orders in orders screen.",
    CustomLocale.NEW_ORDER_DELIVERY_TIME: "Delivered Time",
    CustomLocale.NEW_ORDER_BAG_PRICE: "Bag Price",
    CustomLocale.NEW_ORDER_TOTAL_PRICE: "Total Price",
    CustomLocale.NEW_ORDER_CONFIRM_BUTTON: "Confirm",
    CustomLocale.NEW_ORDER_MAD: "MAD",

  // - - - - - - - - - - - - - - - - - - VENDOR ORDERS SCREEN - - - - - - - - - - - - - - - - - -  //
  CustomLocale.ORDERS_TITLE : "Orders",
  CustomLocale.ORDERS_BAG_PRICE_TITLE : "Bag Price",
  CustomLocale.ORDERS_Quantity_TITLE : "Quantity",
  CustomLocale.ORDERS_CREATE_AT_TITLE : "Created At",
  CustomLocale.ORDERS_SELECTED_AT_TITLE : "Selected At",
  CustomLocale.ORDERS_TOTAL_TITLE : "Total",
  CustomLocale.ORDERS_MAD_TITLE : "MAD",
  CustomLocale.ORDERS_KG_TITLE : "kg",
  CustomLocale.ORDERS_STATUS_TITLE : "Status",
  CustomLocale.ORDERS_EMPTY_LIST_TITLE : "No Orders Found !",

  // - - - - - - - - - - - - - - - - - - NOTIFICATIONS SCREEN - - - - - - - - - - - - - - - - - -  //
  CustomLocale.NOTIFICATIONS_TITLE : "Notifications",
  CustomLocale.NOTIFICATION_TITLE : "Notification",
  CustomLocale.NOTIFICATION_DIALOG_DELETE_TITLE : "Delete",
  CustomLocale.NOTIFICATION_DIALOG_DISMISS_TITLE : "Dismiss",
  CustomLocale.NOTIFICATION_EMPTY_LIST_TITLE : "No Notification Found !",

  // - - - - - - - - - - - - - - - - - - BE SELLER SCREEN - - - - - - - - - - - - - - - - - -  //
  CustomLocale.BE_VENDOR_STEP_1_TITLE : "Personal Information",
  CustomLocale.BE_VENDOR_TITLE_1 : "Fill The Blanks With Your Information ..",
  CustomLocale.BE_VENDOR_TITLE : "Become Vendor",
  CustomLocale.BE_VENDOR_CIN : "CIN",
  CustomLocale.BE_VENDOR_PHONE : "Phone Number",
  CustomLocale.BE_VENDOR_BIRTHDAY : "Age",
  CustomLocale.BE_VENDOR_GENDER_TITLE : "Gender",
  CustomLocale.BE_VENDOR_GENDER_MAN_TITLE : "Man",
  CustomLocale.BE_VENDOR_GENDER_WOMAN_TITLE : "Woman",

    CustomLocale.BE_VENDOR_STEP_2_TITLE: "Vehicle Information",
    CustomLocale.BE_VENDOR_TITLE_2: "Please Insert The Valid Information Of Your Vehicle ..",
    CustomLocale.BE_VENDOR_PICK_CAR_TYPE_TITLE: "Choose Your Vehicle Type.",
    CustomLocale.BE_VENDOR_CAR_TRICYCLE_TYPE_TITLE: "Tricycle",
    CustomLocale.BE_VENDOR_CAR_PICK_UP_TYPE_TITLE: "Pick Up",
    CustomLocale.BE_VENDOR_CAR_CAR_TYPE_TITLE: "Car",
    CustomLocale.BE_VENDOR_CAR_THUMBNAIL_TITLE: "Your Vehicle Image.",
    CustomLocale.BE_VENDOR_CAR_INFO_TITLE: "Complete Vehicle Info.",
    CustomLocale.BE_VENDOR_CAR_ASSURANCE_NUMBER_TITLE: "Assurance Number",
    CustomLocale.BE_VENDOR_CAR_REGISTRATION_NUMBER_TITLE: "Registration Number",

    CustomLocale.BE_VENDOR_STEP_3_TITLE: "Documents Information",
    CustomLocale.BE_VENDOR_TITLE_3: "Add Images Of Your Paper ..",
    CustomLocale.BE_VENDOR_CIN_FRONT_THUMBNAIL_TITLE: "CIN (Front) Image.",
    CustomLocale.BE_VENDOR_CIN_BACK_THUMBNAIL_TITLE: "CIN (Back) Image.",
    CustomLocale.BE_VENDOR_CAR_REGISTRATION_NUMBER_THUMBNAIL_TITLE: "Registration Number Image.",
    CustomLocale.BE_VENDOR_CAR_ASSURANCE_NUMBER_THUMBNAIL_TITLE: "Assurance Number Image",

    CustomLocale.BE_VENDOR_BUTTON_CONTINUE_TITLE: "Continue",
    CustomLocale.BE_VENDOR_BUTTON_BACK_TITLE: "Back",

    CustomLocale.BE_VENDOR_SUCCESS_STATE_TITLE: "La demande est en cours de révisé !",
    CustomLocale.BE_VENDOR_SUCCESS_STATE_SUB_TITLE: "Vous avez déjà soumis une candidature pour devenir vendeur pour notre équipe, veuillez patienter.",
    CustomLocale.BE_VENDOR_SUCCESS_STATE_BUTTON_TITLE: "Ok",

    // - - - - - - - - - - - - - - - - - - VENDOR DETAILS SCREEN - - - - - - - - - - - - - - - - - -  //
  CustomLocale.VENDOR_DETAILS_TITLE : "Vendor Details",
  CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_FEEDBACK : "Feedback",
  CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_REPORT : "Report",
  CustomLocale.VENDOR_DETAILS_TITLE_TAB_MAP : "Map",
  CustomLocale.VENDOR_DETAILS_TITLE_TAB_REVIEWS : "Reviews",

  CustomLocale.VENDOR_DETAILS_FEEDBACK_TITLE : "Give Feedback",
  CustomLocale.VENDOR_DETAILS_FEEDBACK_SUB_TITLE : "What do you think about this seller",
  CustomLocale.VENDOR_DETAILS_FEEDBACK_TEXT_FILED_TITLE : "Do you have any thoughts would you like to share it ?",
  CustomLocale.VENDOR_DETAILS_FEEDBACK_HINT_TITLE : "Write your feedback ..!",

  CustomLocale.VENDOR_DETAILS_REPORT_TITLE : "Give Report",
  CustomLocale.VENDOR_DETAILS_REPORT_SUB_TITLE : "Why you want to report this seller?",

  CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_CANCEL : "Cancel",
  CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_SUBMIT : "Submit",
  
  CustomLocale.VENDOR_DETAILS_REVIEWS_EMPTY_LIST : "No Reviews Found !",

  CustomLocale.VENDOR_DETAILS_REPORT_REASON_1 : "Bad quality and taste",
  CustomLocale.VENDOR_DETAILS_REPORT_REASON_2 : "Unsanitary conditions",
  CustomLocale.VENDOR_DETAILS_REPORT_REASON_3 : "Lack of hygiene",
  CustomLocale.VENDOR_DETAILS_REPORT_REASON_4 : "Serious verbal abuse",
  CustomLocale.VENDOR_DETAILS_REPORT_REASON_5 : "High prices",

    // - - - - - - - - - - - - - - - - - - WISHLISTS SCREEN - - - - - - - - - - - - - - - - - -  //
  CustomLocale.WISHLISTS_TITLE : "WishLists",
  CustomLocale.WSIHLIST_DIALOG_DELETE_TITLE : "Delete",
  CustomLocale.WSIHLIST_DIALOG_DISMISS_TITLE : "Dismiss",
  CustomLocale.WISHLIST_EMPTY_LIST_TITLE : "No WishLists Found !",

    // - - - - - - - - - - - - - - - - - - FAQ SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.Q1 : "Where can i find the application",
    CustomLocale.R1 : "Google play\nApp store\nHuawei store\n",
    CustomLocale.Q2 : "What are the new offers have?",
    CustomLocale.R2 : "Go home page and check the popular option then you will find all offers we have for you\n",
    CustomLocale.Q3 : "How Can I Be Vendor?",
    CustomLocale.R3 : "Go Settings page and click on Be Vendor then fill the form. after 24h we will send you our acceptation\n",
    CustomLocale.Q4 : "How Can I Know I'm a Vendor?",
    CustomLocale.R4 : "Go Notifications page you will find all notification\n",
    CustomLocale.Q5 : "More questions",
    CustomLocale.R5 : "Contact us\n",

  };
}

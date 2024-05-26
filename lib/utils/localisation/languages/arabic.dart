import 'package:berkania/utils/localisation/custom_locale.dart';

class Arabic{
  Arabic._();

  static const Map<String, dynamic> AR = {

    // - - - - - - - - - - - - - - - - - - REUSABLE  - - - - - - - - - - - - - - - - - -  //
    CustomLocale.EMAIL: "البريد إلكتروني",
    CustomLocale.PASSWORD: "كلمة المرور",
    CustomLocale.EMAIL_VALIDATOR: "البريد الالكتروني مطلوب",
    CustomLocale.PASSWORD_VALIDATOR: "كلمة المرور مطلوب",
    CustomLocale.OR: "أو",
    CustomLocale.LOADING_TITLE: "انتظر من فضلك",
    CustomLocale.LOADING_SUB_TITLE: "نحن نقوم بمعالجة معلوماتك وربما يستغرق الأمر بضع ثواني، يرجى الانتظار.",
    CustomLocale.ERROR_TITLE: "",
    CustomLocale.ERROR_SUB_TITLE: "",
    CustomLocale.ERROR_BUTTON_TITLE: "حاول ثانية",
    CustomLocale.NETWORK_TITLE: "لا يوجد اتصال بالشبكة",
    CustomLocale.NETWORK_SUB_TITLE: "تأكد من أن جهازك متصل بالشبكة",

    // - - - - - - - - - - - - - - - - - - LOGIN SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.LOGIN_TITLE: "مرحبًا بعودتك،",
    CustomLocale.LOGIN_SUB_TITLE: "اكتشف خيارات لا حدود لها وراحة لا مثيل لها.",
    CustomLocale.LOGIN_FORGET_THE_PASSWORD: "هل نسيت كلمة السر ؟",
    CustomLocale.LOGIN_LOGIN: "تسجيل الدخول",
    CustomLocale.LOGIN_CREATE_NEW_ACCOUNT: "انشاء حساب جديد",
    CustomLocale.LOGIN_LOGIN_WITH_GOOGLE: "تسجيل الدخول عبر جوجل",
    CustomLocale.LOGIN_CHANGE_THE_LANGUAGE: "تغيير اللغة (ar)",

    // - - - - - - - - - - - - - - - - - - REGISTER SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.REGISTER_TITLE: "لنقم بإنشاء حسابك",
    CustomLocale.REGISTER_FIRST_NAME: "الاسم الأول",
    CustomLocale.REGISTER_LAST_NAME: "اسم العائلة",
    CustomLocale.REGISTER_CONFIRM_PASSWORD: "تأكيد كلمة المرور",
    CustomLocale.REGISTER_FIRST_NAME_VALIDATOR: "الإسم الأول مطلوب",
    CustomLocale.REGISTER_LAST_NAME_VALIDATOR: "اسم العائلة مطلوب",
    CustomLocale.REGISTER_CONFIRM_PASSWORD_VALIDATOR: "تأكيد كلمة المرور",
    CustomLocale.REGISTER_IM_AGREE: "انا موافق",
    CustomLocale.REGISTER_TERMS_OF_USE: "شروط الاستخدام",
    CustomLocale.REGISTER_PRIVACY_POLICY: "سياسة الخصوصية",
    CustomLocale.REGISTER_CREATE_ACCOUNT: "إنشاء حساب",
    CustomLocale.REGISTER_WITH_GOOGLE: "سجل مع جوجل",
    CustomLocale.REGISTER_CHECK_BOX_TITLE_ERROR: "تفقد الخانة",
    CustomLocale.REGISTER_PASSWORD_NOT_MATCHED_TITLE_ERROR: "غير مطابق",
    CustomLocale.REGISTER_CHECK_BOX_SUB_TITLE_ERROR: "يجب عليك  تفقد الخانة للمتابعة",
    CustomLocale.REGISTER_PASSWORD_NOT_MATCHED_SUB_TITLE_ERROR: "يجب أن تكون كلمات المرور هي نفسها",

    // - - - - - - - - - - - - - - - - - - FORGET PASSWORD SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.FORGET_PASSOWRD_TITLE: "نسيت كلمة المرور",
    CustomLocale.FORGET_PASSOWRD_SUB_TITLE: "لا تقلق في بعض الأحيان قد ينسى الأشخاص إدخال بريدك الإلكتروني وسنرسل لك رابطًا لإعادة تعيين كلمة المرور.",
    CustomLocale.FORGET_PASSOWRD_SEND: "ارسل",
    CustomLocale.FORGET_PASSOWRD_EMAIL_TITLE_INVALID: "بريد إلكتروني خاطئ",
    CustomLocale.FORGET_PASSOWRD_EMAIL_SUB_TITLE_INVALID: "يجب أن يتكون البريد الإلكتروني من 6 أحرف على الأقل و@",

    // - - - - - - - - - - - - - - - - - - INDEX - - - - - - - - - - - - - - - - - -  //
    CustomLocale.INDEX_EXPLORE_TITLE: "الرئيسي",
    CustomLocale.INDEX_WISHLIST_TITLE: "الرغبات",
    CustomLocale.INDEX_NOTIFICATION_TITLE: "الإشعارات",
    CustomLocale.INDEX_SETTINGS_TITLE: "الإعدادات",

    // - - - - - - - - - - - - - - - - - - HOME SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.HOME_PERMISSION_TITLE: "الإذن مطلوب",
    CustomLocale.HOME_PERMISSION_SUB_TITLE: "لتزويدك بأفضل تجربة مستخدم، نحتاج إلى إذن من خدمات الموقع",
    CustomLocale.HOME_PERMISSION_BUTTON_ENABLE: "سماح",
    CustomLocale.HOME_SHOW_MY_LOCATION_TITLE : "عرض موقعي",
    CustomLocale.HOME_SHOW_MY_LOCATION_SUB_TITLE : "أظهر موقعك على الخريطة",
    CustomLocale.HOME_ENABLE_MAP_SATELLITE_TITLE : "خريطة القمر الصناعي",
    CustomLocale.HOME_ENABLE_MAP_SATELLITE_SUB_TITLE : "استمتع بالموضوع الجديد المصمم لك",
    CustomLocale.HOME_ENABLE_MAP_TRAFFIC_TITLE : "حركة المرور",
    CustomLocale.HOME_ENABLE_MAP_TRAFFIC_SUB_TITLE : "تظهر حركة المرور والطرق",
    CustomLocale.HOME_ENABLE_MAP_FILTER_TITLE : "تصفية البائعون",
    CustomLocale.HOME_ENABLE_MAP_FILTER_SUB_TITLE : "يمكنك التصفية على الخريطة حسب التصنيف",
    CustomLocale.HOME_ENABLE_MAP_REFRESH_TITLE : "تحديث",
    CustomLocale.HOME_ENABLE_MAP_REFRESH_SUB_TITLE : "تحديث البائعين تلقائيا",
    CustomLocale.HOME_ENABLE_MAP_VENDORS_TITLE : "البائعون",
    CustomLocale.HOME_ENABLE_MAP_VENDORS_SUB_TITLE : "يمكنك إظهار وإخفاء البائعين على الخريطة",

    // - - - - - - - - - - - - - - - - - - SETTINGS SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.SETTINGS_PROFILE_TITLE : "الحساب",
    CustomLocale.SETTINGS_UPDATE_FULL_NAME_TITLE : "تحديث الاسم الكامل",
    CustomLocale.SETTINGS_UPDATE_FULL_NAME_SUB_TITLE : "قم بتغيير اسمك الأول والأخير في أي وقت.",
    CustomLocale.SETTINGS_UPDATE_EMAIL_TITLE : "تحديث البريد الإلكتروني",
    CustomLocale.SETTINGS_UPDATE_EMAIL_SUB_TITLE : "قم بتغيير بريدك الإلكتروني في أي وقت.",
    CustomLocale.SETTINGS_UPDATE_PASSWORD_TITLE : "تحديث كلمة السر",
    CustomLocale.SETTINGS_UPDATE_PASSOWRD_SUB_TITLE : "قم بتغيير كلمة المرور الخاصة بك في أي وقت.",
    CustomLocale.SETTINGS_UPDATE_PHONE_TITLE : "تحديث الهاتف",
    CustomLocale.SETTINGS_UPDATE_PHONE_SUB_TITLE : "قم بتغيير رقم هاتفك في أي وقت.",
    CustomLocale.SETTINGS_VENDOR_SECTION_TITLE : "قسم البائع",
    CustomLocale.SETTINGS_BE_VENDOR_TITLE : "كن بائعًا",
    CustomLocale.SETTINGS_BE_VENDOR_SUB_TITLE : "قدم طلبك الأن لتكن بائعا.",
    CustomLocale.SETTINGS_JOB_TITLE : "وظيفة",
    CustomLocale.SETTINGS_VENDOR_NEW_ORDER_TITLE : "طلب جديد",
    CustomLocale.SETTINGS_VENDOR_NEW_ORDER_SUB_TITLE : "إضافة طلب جديد من بركانيا.",
    CustomLocale.SETTINGS_VENDOR_ORDERS_TITLE : "طلبات",
    CustomLocale.SETTINGS_VENDOR_ORDES_SUB_TITLE : "رؤية جميع طلباتي.",
    CustomLocale.SETTINGS_VENDOR_ONLINE_OFFLINE_TITLE : "متصل  / غير متصل",
    CustomLocale.SETTINGS_VENDOR_ONLINE_OFFLINE_SUB_TITLE : "سوف تظهر أو تخفي تلقائيًا على الخريطة.",
    CustomLocale.SETTINGS_UPDATE_LANGUAGE_TITLE : "تحديث اللغة",
    CustomLocale.SETTINGS_UPDATE_LANGUAGE_SUB_TITLE : "العربية والإنجليزية والفرنسية",
    CustomLocale.SETTINGS_OTHERS_TITLE : "آخرى",
    CustomLocale.SETTINGS_PRIVACY_AND_SECURITY_TITLE : "الخصوصية والأمن",
    CustomLocale.SETTINGS_PRIVACY_AND_SECURITY_SUB_TITLE : "أعرض الخصوصية والأمان لدينا",
    CustomLocale.SETTINGS_HELP_AND_SUPPOR_TITLE : "المساعدة و الدعم",
    CustomLocale.SETTINGS_HELP_AND_SUPPOR_SUB_TITLE : "يمكنك الاتصال بنا لمساعدتك.",
    CustomLocale.SETTINGS_ABOUT_TITLE : "عنا",
    CustomLocale.SETTINGS_ABOUT_SUB_TITLE : "معلومات التطبيق.",
    CustomLocale.SETTINGS_APP_VERSION_TITLE : "الإصدار 1.0.0",
    CustomLocale.SETTINGS_PHONE : "الهاتف",
    CustomLocale.SETTINGS_BUTTON_UPDATE_TITLE : "تحديث",
    CustomLocale.SETTINGS_UPDATE_IMAGE_BUTTON_GALLERY_TITLE : "الصور",
    CustomLocale.SETTINGS_UPDATE_IMAGE_BUTTON_DISMISS_TITLE : "عودة",


    // - - - - - - - - - - - - - - - - - - VENDOR NEW ORDER SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.NEW_ORDER_TITLE: "طلب جديد",
    CustomLocale.NEW_ORDER_SUB_TITLE: "املأ كمية الكيلو التي تريدها ولا تنس تحديد التاريخ الذي ستتلقى فيه طلبك.",
    CustomLocale.NEW_ORDER_HINT: "سنخبرك بمزيد من التفاصيل حول طلباتك في شاشة الطلبات.",
    CustomLocale.NEW_ORDER_DELIVERY_TIME: "أجل التسليم",
    CustomLocale.NEW_ORDER_BAG_PRICE: " سعر الحقيبة",
    CustomLocale.NEW_ORDER_TOTAL_PRICE: "الثمن الإجمالي",
    CustomLocale.NEW_ORDER_CONFIRM_BUTTON: "طلب",
    CustomLocale.NEW_ORDER_MAD: "درهم",

    // - - - - - - - - - - - - - - - - - - VENDOR ORDERS SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.BE_VENDOR_TITLE : "كن بائعًا",
    CustomLocale.ORDERS_TITLE : "طلبات",
    CustomLocale.ORDERS_BAG_PRICE_TITLE : "سعر الحقيبة",
    CustomLocale.ORDERS_Quantity_TITLE : "الكمية",
    CustomLocale.ORDERS_CREATE_AT_TITLE : "أنشئت في",
    CustomLocale.ORDERS_SELECTED_AT_TITLE : "تم اختياره في",
    CustomLocale.ORDERS_TOTAL_TITLE : "المجموع",
    CustomLocale.ORDERS_KG_TITLE : "كيلو",
    CustomLocale.ORDERS_MAD_TITLE : "درهم",
    CustomLocale.ORDERS_STATUS_TITLE : "الحالة",
    CustomLocale.ORDERS_EMPTY_LIST_TITLE : "لم يتم العثور على أية طلبات !",

    // - - - - - - - - - - - - - - - - - - NOTIFICATIONS SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.NOTIFICATIONS_TITLE : "الإشعارات",
    CustomLocale.NOTIFICATION_TITLE : "إشعار",
    CustomLocale.NOTIFICATION_DIALOG_DELETE_TITLE : "مسح",
    CustomLocale.NOTIFICATION_DIALOG_DISMISS_TITLE : "عودة",
    CustomLocale.NOTIFICATION_EMPTY_LIST_TITLE : "لم يتم العثور على أية إشعارات !",

    // - - - - - - - - - - - - - - - - - - BE SELLER SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.BE_VENDOR_CIN : "رقم البطاقة الوطنية",
    CustomLocale.BE_VENDOR_PHONE : "الهاتف",
    CustomLocale.BE_VENDOR_BIRTHDAY : "تاريخ الميلاد",
    CustomLocale.BE_VENDOR_BUTTON_CONTINUE_TITLE : "التالي",
    CustomLocale.BE_VENDOR_BUTTON_BACK_TITLE : "عودة",
    CustomLocale.BE_VENDOR_STEP_1_TITLE : "المعلومات الشخصية",
    CustomLocale.BE_VENDOR_TITLE_1 : "إملأ الفراغات بمعلوماتك ..",
    CustomLocale.BE_VENDOR_GENDER_TITLE : "الجنس",
    CustomLocale.BE_VENDOR_GENDER_MAN_TITLE : "رجل",
    CustomLocale.BE_VENDOR_GENDER_WOMAN_TITLE : "مرأة",

    // - - - - - - - - - - - - - - - - - - WISHLISTS SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.WISHLISTS_TITLE : "الرغبات",
    CustomLocale.WSIHLIST_DIALOG_DELETE_TITLE : "مسح",
    CustomLocale.WSIHLIST_DIALOG_DISMISS_TITLE : "عودة",
    CustomLocale.WISHLIST_EMPTY_LIST_TITLE : "لم يتم العثور على أية رغبات !",

  };
}
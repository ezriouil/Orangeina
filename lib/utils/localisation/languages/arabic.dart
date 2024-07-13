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
    CustomLocale.LOADING_TITLE: "انتظر من فضلك...",
    CustomLocale.LOADING_SUB_TITLE: "ربما يستغرق الأمر بضع ثواني، يرجى الانتظار.",
    CustomLocale.ERROR_BUTTON_TITLE: "حاول ثانية",
    CustomLocale.NETWORK_TITLE: "لا يوجد اتصال بالشبكة",
    CustomLocale.NETWORK_SUB_TITLE: "تأكد من أن جهازك متصل بالشبكة",

    // - - - - - - - - - - - - - - - - - - ALERT MESSAGES - - - - - - - - - - - - - - - - - -  //
    CustomLocale.ERROR_TITLE: "يا للمفاجئة !",
    CustomLocale.SUCCESS_TITLE: "تم بنجاح",

    // - - - - - - - - - - - - - - - - - - LOGIN SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.LOGIN_TITLE: "مرحبًا بعودتك،",
    CustomLocale.LOGIN_SUB_TITLE: "اكتشف خيارات لا حدود لها وراحة لا مثيل لها.",
    CustomLocale.LOGIN_FORGET_THE_PASSWORD: "هل نسيت كلمة السر ؟",
    CustomLocale.LOGIN_LOGIN: "تسجيل الدخول",
    CustomLocale.LOGIN_CREATE_NEW_ACCOUNT: "انشاء حساب جديد",
    CustomLocale.LOGIN_LOGIN_WITH_GOOGLE: "تسجيل الدخول عبر جوجل",
    CustomLocale.LOGIN_CHANGE_THE_LANGUAGE: "تغيير اللغة (ar)",

    CustomLocale.LOGIN_ERROR_EMAI_INVALID_SUB_TITLE: "لا يمكن تسجيل الدخول بهذا البريد الإلكتروني.",
    CustomLocale.LOGIN_ERROR_EMAIL_PASS_INVALID_SUB_TITLE: "البريد الإلكتروني أو كلمة المرور غير صالحة.",

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

    CustomLocale.REGISTER_ERROR_EMAIL_INVALID_SUB_TITLE: "لا يمكن التسجيل بهذا البريد الإلكتروني.",
    CustomLocale.REGISTER_SUCCESS_SUB_TITLE: "تم إنشاء حسابك بنجاح.",

    // - - - - - - - - - - - - - - - - - - FORGET PASSWORD SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.FORGET_PASSOWRD_TITLE: "نسيت كلمة المرور",
    CustomLocale.FORGET_PASSOWRD_SUB_TITLE: "لا تقلق في بعض الأحيان قد ينسى الأشخاص إدخال بريدك الإلكتروني وسنرسل لك رابطًا لإعادة تعيين كلمة المرور.",
    CustomLocale.FORGET_PASSOWRD_SEND: "ارسل",
    CustomLocale.FORGET_PASSOWRD_EMAIL_TITLE_INVALID: "بريد إلكتروني خاطئ",
    CustomLocale.FORGET_PASSOWRD_EMAIL_SUB_TITLE_INVALID: "يجب أن يتكون البريد الإلكتروني من 6 أحرف على الأقل و@",
    CustomLocale.FORGOT_PASSOWRD_ERROR_SUB_TITLE: "لقد حدث خطأ،البريد الإلكتروني غير موجود.",
    CustomLocale.FORGOT_PASSOWRD_SUCCESS_SUB_TITLE: "لقد أرسلنا الرابط لإعادة تعيين كلمة المرور الخاصة بك.",

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
    CustomLocale.HOME_KM : "كيلومتر",

    CustomLocale.HOME_ERROR_GET_VENDOR_SUB_TITLE : "لم يتم العثور على البائع !",
    CustomLocale.HOME_ERROR_VENDORS_NOT_FOUND : "   لم يتم العثور على  اي بائع !",
    CustomLocale.HOME_ERROR_GET_CURRENT_LOCATION_SUB_TITLE : "لا يمكن الحصول على موقعك الحالي!",

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
    CustomLocale.SETTINGS_SIGN_OUT_TITLE : "تسجيل الخروج",
    CustomLocale.SETTINGS_SIGN_OUT_SUB_TITLE : "ستخرج من التطبيق.",
    CustomLocale.SETTINGS_APP_VERSION_TITLE : "الإصدار 1.0.0",
    CustomLocale.SETTINGS_PHONE : "الهاتف",
    CustomLocale.SETTINGS_BUTTON_UPDATE_TITLE : "تحديث",
    CustomLocale.SETTINGS_UPDATE_IMAGE_BUTTON_GALLERY_TITLE : "الصور",
    CustomLocale.SETTINGS_UPDATE_IMAGE_BUTTON_DISMISS_TITLE : "عودة",

    CustomLocale.SETTINGS_IMAGE_PROFILE_UPDATED_SUCCESSFULLY : "تم تحديث صورة ملف التعريف  بنجاح.",
    CustomLocale.SETTINGS_ERROR_IMAGE_PROFILE_SELECTED_SUB_TITLE : "لم يتم تحديد أي صورة.",
    CustomLocale.SETTINGS_ERROR_UPDATE_IMAGE_PROFILE_SUB_TITLE : "لا يمكن تحديث صورة ملف التعريف الخاص بك.",
    CustomLocale.SETTINGS_PHONE_UPDATED_SUCCESSFULLY_SUB_TITLE : "تم تحديث رقم الهاتف بنجاح.",
    CustomLocale.SETTINGS_ERROR_UPDATE_PHONE_SUB_TITLE : "لا يمكن تحديث رقم هاتفك.",
    CustomLocale.SETTINGS_FULL_NAME_UPDATED_SUCCESSFULLY_SUB_TITLE : "تم تحديث رقم هاتفك بنجاح.",
    CustomLocale.SETTINGS_ERROR_UPDATE_FULL_NAME_SUB_TITLE : "لا يمكن تحديث رقم إسمك.",
    CustomLocale.SETTINGS_VENDOR_STATUS_UPDATED_SUCCESSFULLY_SUB_TITLE : "تم تحديث رقم حالتك بنجاح.",
    CustomLocale.SETTINGS_ERROR_UPDATE_VENDOR_STATUS_SUB_TITLE : "لا يمكن تحديث رقم حالتك.",


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

    CustomLocale.ORDERS_EMPTY_COUNTER_SUB_TITLE: "يرجى إدخال كمية الكيلوغرامات التي تريدها !",
    CustomLocale.ORDERS_CANNOT_ORDER_SUB_TITLE: "عذرًا، لا يمكن الطلب الآن !",
    CustomLocale.ORDERS_ORDER_SUCCESS_SUB_TITLE: "شكرًا لطلبك، سنقوم بإعلامك في قسم الإشعارات.",


    // - - - - - - - - - - - - - - - - - - NOTIFICATIONS SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.NOTIFICATIONS_TITLE : "الإشعارات",
    CustomLocale.NOTIFICATION_TITLE : "إشعار",
    CustomLocale.NOTIFICATION_DIALOG_DELETE_TITLE : "مسح",
    CustomLocale.NOTIFICATION_DIALOG_DISMISS_TITLE : "عودة",
    CustomLocale.NOTIFICATION_EMPTY_LIST_TITLE : "لم يتم العثور على أية إشعارات !",

    CustomLocale.NOTIFICATION_ERROR_DELETE_NOTIFICATION_SUB_TITLE : "لا يمكن حذف هذا الإشعار!",

    // - - - - - - - - - - - - - - - - - - BE SELLER SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.BE_VENDOR_CIN : "رقم البطاقة الوطنية",
    CustomLocale.BE_VENDOR_PHONE : "الهاتف",
    CustomLocale.BE_VENDOR_BIRTHDAY : "السن",
    CustomLocale.BE_VENDOR_STEP_1_TITLE : "المعلومات الشخصية",
    CustomLocale.BE_VENDOR_TITLE_1 : "إملأ الفراغات بمعلوماتك ..",
    CustomLocale.BE_VENDOR_GENDER_TITLE : "الجنس",
    CustomLocale.BE_VENDOR_GENDER_MAN_TITLE : "رجل",
    CustomLocale.BE_VENDOR_GENDER_WOMAN_TITLE : "مرأة",

    CustomLocale.BE_VENDOR_STEP_2_TITLE: "معلومات السيارة",
    CustomLocale.BE_VENDOR_TITLE_2: "الرجاء إدخال معلومات سيارتك الصحيحة ..",
    CustomLocale.BE_VENDOR_PICK_CAR_TYPE_TITLE: "اختر نوع سيارتك.",
    CustomLocale.BE_VENDOR_CAR_TRICYCLE_TYPE_TITLE: "دراجة ثلاثية",
    CustomLocale.BE_VENDOR_CAR_PICK_UP_TYPE_TITLE: "شاحنة صغيرة",
    CustomLocale.BE_VENDOR_CAR_CAR_TYPE_TITLE: "سيارة",
    CustomLocale.BE_VENDOR_CAR_THUMBNAIL_TITLE: "صورة لسيارتك.",
    CustomLocale.BE_VENDOR_CAR_INFO_TITLE: "املأ معلومات السيارة.",
    CustomLocale.BE_VENDOR_CAR_ASSURANCE_NUMBER_TITLE: "رقم التأمين",
    CustomLocale.BE_VENDOR_CAR_REGISTRATION_NUMBER_TITLE: "رقم التسجيل",

    CustomLocale.BE_VENDOR_STEP_3_TITLE: "معلومات المستند",
    CustomLocale.BE_VENDOR_TITLE_3: "أضف صور اوراقك..",
    CustomLocale.BE_VENDOR_CIN_FRONT_THUMBNAIL_TITLE: "صور البطاقة الوطنية (الامام).",
    CustomLocale.BE_VENDOR_CIN_BACK_THUMBNAIL_TITLE: "صور البطاقة الوطنية (الخلف).",
    CustomLocale.BE_VENDOR_CAR_REGISTRATION_NUMBER_THUMBNAIL_TITLE: "صورة رقم التسجيل السيارة.",
    CustomLocale.BE_VENDOR_CAR_ASSURANCE_NUMBER_THUMBNAIL_TITLE: " صورة رقم التأمين السيارة.",

    CustomLocale.BE_VENDOR_BUTTON_CONTINUE_TITLE : "التالي",
    CustomLocale.BE_VENDOR_BUTTON_BACK_TITLE : "عودة",

    CustomLocale.BE_VENDOR_SUCCESS_STATE_TITLE: "جار مراجعة الطلب!",
    CustomLocale.BE_VENDOR_SUCCESS_STATE_SUB_TITLE: "لقد قمت بالفعل بإرسال طلب لتصبح بائعا لفريقنا، يرجى الانتظار.",
    CustomLocale.BE_VENDOR_SUCCESS_STATE_BUTTON_TITLE: "حسنا",

    CustomLocale.BE_VENDOR_ERROR_SUB_TITLE: "لا يمكن إرسال الطلب إليك، يرجى المحاولة مرة أخرى",

    // - - - - - - - - - - - - - - - - - - VENDOR DETAILS SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.VENDOR_DETAILS_TITLE : "تفاصيل البائع",
    CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_FEEDBACK : "تقيم",
    CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_REPORT : "تقرير",
    CustomLocale.VENDOR_DETAILS_TITLE_TAB_MAP : "الخريطة",
    CustomLocale.VENDOR_DETAILS_TITLE_TAB_REVIEWS : "التعليقات",

    CustomLocale.VENDOR_DETAILS_FEEDBACK_TITLE : "اعطي رأيك",
    CustomLocale.VENDOR_DETAILS_FEEDBACK_SUB_TITLE : "ما رأيك في هذا البائع؟",
    CustomLocale.VENDOR_DETAILS_FEEDBACK_TEXT_FILED_TITLE : "هل لديك أي أفكار وترغب في مشاركتها؟",
    CustomLocale.VENDOR_DETAILS_FEEDBACK_HINT_TITLE : "اكتب تعليقا ..!",

    CustomLocale.VENDOR_DETAILS_REPORT_TITLE : "إعطاء تقرير",
    CustomLocale.VENDOR_DETAILS_REPORT_SUB_TITLE : "لماذا تريد الإبلاغ عن هذا البائع؟",

    CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_CANCEL : "رجوع",
    CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_SUBMIT : "إرسال",

    CustomLocale.VENDOR_DETAILS_REVIEWS_EMPTY_LIST : "لم يتم العثور على أية ارآء !",

    CustomLocale.VENDOR_DETAILS_REPORT_REASON_1 : "نوعية / طعم سيئ",
    CustomLocale.VENDOR_DETAILS_REPORT_REASON_2 : "ظروف غير صحية",
    CustomLocale.VENDOR_DETAILS_REPORT_REASON_3 : "قلة النظافة",
    CustomLocale.VENDOR_DETAILS_REPORT_REASON_4 : "العنف اللفظي",
    CustomLocale.VENDOR_DETAILS_REPORT_REASON_5 : "أسعار عالية",

    // - - - - - - - - - - - - - - - - - - WISHLISTS SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.WISHLISTS_TITLE : "الرغبات",
    CustomLocale.WSIHLIST_DIALOG_DELETE_TITLE : "مسح",
    CustomLocale.WSIHLIST_DIALOG_DISMISS_TITLE : "عودة",
    CustomLocale.WISHLIST_EMPTY_LIST_TITLE : "لم يتم العثور على أية رغبات !",

    CustomLocale.WISHLIST_ERROR_CANNOT_DELETE_SUB_TITLE: "لا يمكنك  حذف  اية رغبات  في الوقت الحالي !",


    // - - - - - - - - - - - - - - - - - - FAQ SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.FAQ_TITLE : "التعليمات",
    CustomLocale.Q1 : "أين يمكنني العثور على التطبيق",
    CustomLocale.R1 : "جميع المتاجر لتحميل التطبيقات  Google Play أو App Store",
    CustomLocale.Q2 : "ما هي العروض الجديدة؟",
    CustomLocale.R2 : "انتقل إلى الصفحة الرئيسية وتحقق من الخيار الشائع، ثم ستجد جميع العروض المتوفرة لدينا لك",
    CustomLocale.Q3 : "كيف يمكنني أن أكون بائعًا؟",
    CustomLocale.R3 : "انتقل إلى صفحة الإعدادات وانقر على كن بائعًا ثم املأ النموذج. بعد 24 ساعة سوف نرسل لك قبولنا",
    CustomLocale.Q4 : "كيف يمكنني أن أعرف أنني بائع؟",
    CustomLocale.R4 : "انتقل إلى صفحة الإشعارات وستجد جميع الإشعارات",
    CustomLocale.Q5 : "المزيد من الأسئلة",
    CustomLocale.R5 : "اتصل بنا",

    // - - - - - - - - - - - - - - - - - - VALIDATOR - - - - - - - - - - - - - - - - - -  //
    CustomLocale.VALIDATOR_CUSTOM_FIELD_ERROR1 : "لا ينبغي أن تكون فارغة",
    CustomLocale.VALIDATOR_EMAIL_ERROR1 : "لا ينبغي أن تكون فارغة",
    CustomLocale.VALIDATOR_EMAIL_ERROR2 : "يجب أن يحتوي البريد الإلكتروني على @",
    CustomLocale.VALIDATOR_PASSWORD_ERROR1 : "يجب أن كلمة السر لا تكون فارغة",
    CustomLocale.VALIDATOR_PASSWORD_ERROR2 : "كلمة المرور قصيرة جدًا",
    CustomLocale.VALIDATOR_PASSWORD_ERROR3 : "كلمة المرور يجب أن تحتوي على أحرف وأرقام",
    CustomLocale.VALIDATOR_PASSWORD_ERROR4 : "كلمة المرور طويلة جدًا",
    CustomLocale.VALIDATOR_MOBILE_NUMBER_ERROR1 : "يجب ألا يكون الهاتف فارغًا",
    CustomLocale.VALIDATOR_MOBILE_NUMBER_ERROR2 : "رقم الهاتف غير صحيح",
    CustomLocale.VALIDATOR_AGE_ERROR1 : "لا ينبغي أن يكون السن فارغا",
    CustomLocale.VALIDATOR_AGE_ERROR2 : "السن غير صالح",
    CustomLocale.VALIDATOR_AGE_ERROR3 : "سن تحت 18 سنة غير صالح",
    CustomLocale.VALIDATOR_AGE_ERROR4 : "سن فوق 82 سنة غير صالح",

  };
}
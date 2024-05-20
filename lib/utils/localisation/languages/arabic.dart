import 'package:berkania/utils/localisation/custom_locale.dart';

class Arabic{
  Arabic._();

  static const Map<String, dynamic> AR = {

    // - - - - - - - - - - - - - - - - - - REUSABLE  - - - - - - - - - - - - - - - - - -  //
    CustomLocale.EMAIL: "بريد إلكتروني",
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
    CustomLocale.SETTINGS_DISPLAY_TITLE : "العرض",
    CustomLocale.SETTINGS_UPDATE_DARK_MODE_TITLE : "تمكين الوضع المظلم",
    CustomLocale.SETTINGS_UPDATE_DARK_MODE_SUB_TITLE : "استمتع بالموضوع الجديد المصمم لك.",
    CustomLocale.SETTINGS_UPDATE_HIDE_AUTH_TITLE : "تمكين إخفاء المصادقة",
    CustomLocale.SETTINGS_UPDATE_HIDE_AUTH_SUB_TITLE : "يمكنك إخفاء صفحة تسجيل الدخول.",
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

  };
}
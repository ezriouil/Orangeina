import 'package:berkania/utils/localisation/custom_locale.dart';

class French{
  French._();

  static const Map<String, dynamic> FR = {

    // - - - - - - - - - - - - - - - - - - REUSABLE  - - - - - - - - - - - - - - - - - -  //
    CustomLocale.EMAIL: "E-mail",
    CustomLocale.PASSWORD: "Mot de passe",
    CustomLocale.EMAIL_VALIDATOR: "E-mail requis",
    CustomLocale.PASSWORD_VALIDATOR: "Mot de passe requis",
    CustomLocale.OR: "Ou",
    CustomLocale.LOADING_TITLE: "S'il vous plaît, attendez",
    CustomLocale.LOADING_SUB_TITLE: "Nous traitons vos informations et cela peut prendre quelques secondes, veuillez patienter.",
    CustomLocale.ERROR_TITLE: "",
    CustomLocale.ERROR_SUB_TITLE: "",
    CustomLocale.ERROR_BUTTON_TITLE: "Essayer à nouveau",
    CustomLocale.NETWORK_TITLE: "Pas de connexion réseau",
    CustomLocale.NETWORK_SUB_TITLE: "Assurez-Vous Que Votre Appareil Est Connecté Au Réseau",

    // - - - - - - - - - - - - - - - - - - LOGIN SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.LOGIN_TITLE: "Bienvenu encore,",
    CustomLocale.LOGIN_SUB_TITLE: "Découvrez des choix illimités et une commodité inégalée.",
    CustomLocale.LOGIN_FORGET_THE_PASSWORD: "Mot de passe oublié ?",
    CustomLocale.LOGIN_LOGIN: "Se connecter",
    CustomLocale.LOGIN_CREATE_NEW_ACCOUNT: "Créer un nouveau compte",
    CustomLocale.LOGIN_LOGIN_WITH_GOOGLE: "Connectez-vous avec Google",
    CustomLocale.LOGIN_CHANGE_THE_LANGUAGE: "Changer la langue (fr)",

    // - - - - - - - - - - - - - - - - - - REGISTER SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.REGISTER_TITLE: "Créer votre compte",
    CustomLocale.REGISTER_FIRST_NAME: "Prénom",
    CustomLocale.REGISTER_LAST_NAME: "Nom",
    CustomLocale.REGISTER_CONFIRM_PASSWORD: "Confirmez le mot de passe",
    CustomLocale.REGISTER_IM_AGREE: "Je suis d'accord",
    CustomLocale.REGISTER_TERMS_OF_USE: "Conditions d'utilisation",
    CustomLocale.REGISTER_PRIVACY_POLICY: "politique de confidentialité",
    CustomLocale.REGISTER_CREATE_ACCOUNT: "Créer un compte",
    CustomLocale.REGISTER_WITH_GOOGLE: "S'inscrire sur Google",
    CustomLocale.REGISTER_CHECK_BOX_TITLE_ERROR: "Cochez La Case",
    CustomLocale.REGISTER_PASSWORD_NOT_MATCHED_TITLE_ERROR: "Ne Correspondant Pas",
    CustomLocale.REGISTER_CHECK_BOX_SUB_TITLE_ERROR: "Vous Devez Cocher La Case Pour Continuer",
    CustomLocale.REGISTER_PASSWORD_NOT_MATCHED_SUB_TITLE_ERROR: "Les Mots De Passe Doivent Être Les Mêmes",

    // - - - - - - - - - - - - - - - - - - FORGET PASSWORD SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.FORGET_PASSOWRD_TITLE: "Mot de passe oublié",
    CustomLocale.FORGET_PASSOWRD_SUB_TITLE: "Ne vous inquiétez pas, parfois les gens peuvent oublier de le faire, entrez votre adresse e-mail et nous vous enverrons un lien de réinitialisation du mot de passe.",
    CustomLocale.FORGET_PASSOWRD_SEND: "Envoyer",
    CustomLocale.FORGET_PASSOWRD_EMAIL_TITLE_INVALID: "Email Invalide",
    CustomLocale.FORGET_PASSOWRD_EMAIL_SUB_TITLE_INVALID: "E-mail Doit Comporter Au Moins 6 Caractères Et @",

    // - - - - - - - - - - - - - - - - - - INDEX - - - - - - - - - - - - - - - - - -  //
    CustomLocale.INDEX_EXPLORE_TITLE: "Explorer",
    CustomLocale.INDEX_WISHLIST_TITLE: "Souhaits",
    CustomLocale.INDEX_NOTIFICATION_TITLE: "Notification",
    CustomLocale.INDEX_SETTINGS_TITLE: "Paramètres",

    // - - - - - - - - - - - - - - - - - - HOME SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.HOME_PERMISSION_TITLE: "Autorisation Requise",
    CustomLocale.HOME_PERMISSION_SUB_TITLE: "Pour Vous Offrir La Meilleure Expérience Utilisateur, Nous Avons Besoin De L'autorisation Des Services De Localisation",
    CustomLocale.HOME_PERMISSION_BUTTON_ENABLE: "Activer",
    CustomLocale.HOME_SHOW_MY_LOCATION_TITLE : "Ma Position",
    CustomLocale.HOME_SHOW_MY_LOCATION_SUB_TITLE : "Montrez votre position sur la carte",
    CustomLocale.HOME_ENABLE_MAP_SATELLITE_TITLE : "Carte satellite",
    CustomLocale.HOME_ENABLE_MAP_SATELLITE_SUB_TITLE : "Profitez d'un nouveau thème conçu pour vous",
    CustomLocale.HOME_ENABLE_MAP_TRAFFIC_TITLE : "Trafic",
    CustomLocale.HOME_ENABLE_MAP_TRAFFIC_SUB_TITLE : "Afficher le trafic et les routes",
    CustomLocale.HOME_ENABLE_MAP_FILTER_TITLE : "Filtre",
    CustomLocale.HOME_ENABLE_MAP_FILTER_SUB_TITLE : "Vous pouvez filtrer sur la carte par note",
    CustomLocale.HOME_ENABLE_MAP_REFRESH_TITLE : "L'actualisation",
    CustomLocale.HOME_ENABLE_MAP_REFRESH_SUB_TITLE : "Actualiser automatiquement les Vendeurs",
    CustomLocale.HOME_ENABLE_MAP_VENDORS_TITLE : "Fournisseurs",
    CustomLocale.HOME_ENABLE_MAP_VENDORS_SUB_TITLE : "Vous pouvez afficher et masquer les fournisseurs sur la carte",

    // - - - - - - - - - - - - - - - - - - SETTINGS SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.SETTINGS_PROFILE_TITLE : "Profil",
    CustomLocale.SETTINGS_UPDATE_FULL_NAME_TITLE : "Mettre à jour le nom complet",
    CustomLocale.SETTINGS_UPDATE_FULL_NAME_SUB_TITLE : "Changez votre prénom et votre nom à tout moment.",
    CustomLocale.SETTINGS_UPDATE_EMAIL_TITLE : "Mettre à jour e-mail",
    CustomLocale.SETTINGS_UPDATE_EMAIL_SUB_TITLE : "Changez votre email à tout moment.",
    CustomLocale.SETTINGS_UPDATE_PASSWORD_TITLE : "Mettre à jour mot de passe",
    CustomLocale.SETTINGS_UPDATE_PASSOWRD_SUB_TITLE : "Changez votre mot de passe à tout moment.",
    CustomLocale.SETTINGS_UPDATE_PHONE_TITLE : "Mettre à jour le téléphone",
    CustomLocale.SETTINGS_UPDATE_PHONE_SUB_TITLE : "Changez votre numéro de téléphone à tout moment.",
    CustomLocale.SETTINGS_JOB_TITLE : "Emploi",
    CustomLocale.SETTINGS_BE_VENDOR_TITLE : "Soyez vendeur",
    CustomLocale.SETTINGS_BE_VENDOR_SUB_TITLE : "Postulez maintenant pour devenir vendeur.",
    CustomLocale.SETTINGS_UPDATE_LANGUAGE_TITLE : "Mettre à jour la langue",
    CustomLocale.SETTINGS_UPDATE_LANGUAGE_SUB_TITLE : "Arabe & Anglais & Français",
    CustomLocale.SETTINGS_OTHERS_TITLE : "Autres",
    CustomLocale.SETTINGS_PRIVACY_AND_SECURITY_TITLE : "Confidentialité et sécurité",
    CustomLocale.SETTINGS_PRIVACY_AND_SECURITY_SUB_TITLE : "Voir notre confidentialité et sécurité",
    CustomLocale.SETTINGS_HELP_AND_SUPPOR_TITLE : "Aide et soutien",
    CustomLocale.SETTINGS_HELP_AND_SUPPOR_SUB_TITLE : "Vous pouvez nous contacter pour vous aider.",
    CustomLocale.SETTINGS_ABOUT_TITLE : "À propos nous",
    CustomLocale.SETTINGS_ABOUT_SUB_TITLE : "Informations sur la candidature.",
    CustomLocale.SETTINGS_APP_VERSION_TITLE : "version 1.0.0",
    CustomLocale.SETTINGS_PHONE : "Téléphone",
    CustomLocale.SETTINGS_BUTTON_UPDATE_TITLE : "Mettre à jour",

  };
}
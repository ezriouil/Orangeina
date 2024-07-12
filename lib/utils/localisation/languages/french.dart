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
    CustomLocale.LOADING_TITLE: "Attendez-Vous...",
    CustomLocale.LOADING_SUB_TITLE: "Cela peut prendre quelques secondes, veuillez patienter.",
    CustomLocale.ERROR_BUTTON_TITLE: "Essayer à nouveau",
    CustomLocale.NETWORK_TITLE: "Pas de connexion réseau",
    CustomLocale.NETWORK_SUB_TITLE: "Assurez-Vous Que Votre Appareil Est Connecté Au Réseau",

    // - - - - - - - - - - - - - - - - - - ALERT MESSAGES - - - - - - - - - - - - - - - - - -  //
    CustomLocale.ERROR_TITLE: "Oh claquement!",
    CustomLocale.SUCCESS_TITLE: "Effectué avec succès",

    // - - - - - - - - - - - - - - - - - - LOGIN SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.LOGIN_TITLE: "Bienvenu encore,",
    CustomLocale.LOGIN_SUB_TITLE: "Découvrez des choix illimités et une commodité inégalée.",
    CustomLocale.LOGIN_FORGET_THE_PASSWORD: "Mot de passe oublié ?",
    CustomLocale.LOGIN_LOGIN: "Se connecter",
    CustomLocale.LOGIN_CREATE_NEW_ACCOUNT: "Créer un nouveau compte",
    CustomLocale.LOGIN_LOGIN_WITH_GOOGLE: "Connectez-vous avec Google",
    CustomLocale.LOGIN_CHANGE_THE_LANGUAGE: "Changer la langue (fr)",

    CustomLocale.LOGIN_ERROR_EMAI_INVALID_SUB_TITLE: "Impossible de se connecter avec cet email.",
    CustomLocale.LOGIN_ERROR_EMAIL_PASS_INVALID_SUB_TITLE: "E-mail ou mot de passe invalide.",

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

    CustomLocale.REGISTER_ERROR_EMAIL_INVALID_SUB_TITLE: "Impossible de s'inscrire avec cet email.",
    CustomLocale.REGISTER_SUCCESS_SUB_TITLE: "Votre compte a été créé avec succès.",

    // - - - - - - - - - - - - - - - - - - FORGET PASSWORD SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.FORGET_PASSOWRD_TITLE: "Mot de passe oublié",
    CustomLocale.FORGET_PASSOWRD_SUB_TITLE: "Ne vous inquiétez pas, parfois les gens peuvent oublier de le faire, entrez votre adresse e-mail et nous vous enverrons un lien de réinitialisation du mot de passe.",
    CustomLocale.FORGET_PASSOWRD_SEND: "Envoyer",
    CustomLocale.FORGET_PASSOWRD_EMAIL_TITLE_INVALID: "Email Invalide",
    CustomLocale.FORGET_PASSOWRD_EMAIL_SUB_TITLE_INVALID: "E-mail Doit Comporter Au Moins 6 Caractères Et @",
    CustomLocale.FORGOT_PASSOWRD_ERROR_SUB_TITLE: "Une erreur s'est produite, Email non trouvé.",
    CustomLocale.FORGOT_PASSOWRD_SUCCESS_SUB_TITLE: "Nous avons envoyé le lien pour réinitialiser votre mot de passe.",

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
    CustomLocale.HOME_KM : "Km",

    CustomLocale.HOME_ERROR_GET_VENDOR_SUB_TITLE : "Fournisseur introuvable !",
    CustomLocale.HOME_ERROR_VENDORS_NOT_FOUND : "   Fournisseurs introuvable !",
    CustomLocale.HOME_ERROR_GET_CURRENT_LOCATION_SUB_TITLE : "Impossible d'obtenir votre position actuelle!",

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
    CustomLocale.SETTINGS_VENDOR_SECTION_TITLE : "Section Vendeur",
    CustomLocale.SETTINGS_BE_VENDOR_TITLE : "Soyez vendeur",
    CustomLocale.SETTINGS_BE_VENDOR_SUB_TITLE : "Postulez maintenant pour devenir vendeur.",
    CustomLocale.SETTINGS_JOB_TITLE : "Emploi",
    CustomLocale.SETTINGS_VENDOR_NEW_ORDER_TITLE : "Nouvel ordre",
    CustomLocale.SETTINGS_VENDOR_NEW_ORDER_SUB_TITLE : "Ajouter une nouvelle commande de Berkania.",
    CustomLocale.SETTINGS_VENDOR_ORDERS_TITLE : "Commandes",
    CustomLocale.SETTINGS_VENDOR_ORDES_SUB_TITLE : "Voir tous mes commandes.",
    CustomLocale.SETTINGS_VENDOR_ONLINE_OFFLINE_TITLE : "Connecté / Déconnecté",
    CustomLocale.SETTINGS_VENDOR_ONLINE_OFFLINE_SUB_TITLE : "Vous afficherez ou masquerez automatiquement sur la carte.",
    CustomLocale.SETTINGS_UPDATE_LANGUAGE_TITLE : "Mettre à jour la langue",
    CustomLocale.SETTINGS_UPDATE_LANGUAGE_SUB_TITLE : "Arabe & Anglais & Français",
    CustomLocale.SETTINGS_OTHERS_TITLE : "Autres",
    CustomLocale.SETTINGS_PRIVACY_AND_SECURITY_TITLE : "Confidentialité et sécurité",
    CustomLocale.SETTINGS_PRIVACY_AND_SECURITY_SUB_TITLE : "Voir notre confidentialité et sécurité",
    CustomLocale.SETTINGS_HELP_AND_SUPPOR_TITLE : "Aide et soutien",
    CustomLocale.SETTINGS_HELP_AND_SUPPOR_SUB_TITLE : "Vous pouvez nous contacter pour vous aider.",
    CustomLocale.SETTINGS_ABOUT_TITLE : "À propos nous",
    CustomLocale.SETTINGS_ABOUT_SUB_TITLE : "Informations sur la candidature.",
    CustomLocale.SETTINGS_SIGN_OUT_TITLE : "Déconnexion",
    CustomLocale.SETTINGS_SIGN_OUT_SUB_TITLE : "Vous allez quitter l'application.",
    CustomLocale.SETTINGS_APP_VERSION_TITLE : "version 1.0.0",
    CustomLocale.SETTINGS_PHONE : "Téléphone",
    CustomLocale.SETTINGS_BUTTON_UPDATE_TITLE : "Mettre à jour",
    CustomLocale.SETTINGS_UPDATE_IMAGE_BUTTON_GALLERY_TITLE : "Galerie",
    CustomLocale.SETTINGS_UPDATE_IMAGE_BUTTON_DISMISS_TITLE : "Rejeter",

    CustomLocale.SETTINGS_IMAGE_PROFILE_UPDATED_SUCCESSFULLY : "Profil d'image mis à jour avec succès.",
    CustomLocale.SETTINGS_ERROR_IMAGE_PROFILE_SELECTED_SUB_TITLE : "Aucune image sélectionnée.",
    CustomLocale.SETTINGS_ERROR_UPDATE_IMAGE_PROFILE_SUB_TITLE : "Impossible de mettre à jour votre profil d'image.",
    CustomLocale.SETTINGS_PHONE_UPDATED_SUCCESSFULLY_SUB_TITLE : "Numéro de téléphone mis à jour avec succès.",
    CustomLocale.SETTINGS_ERROR_UPDATE_PHONE_SUB_TITLE : "Impossible de mettre à jour votre numéro de téléphone.",
    CustomLocale.SETTINGS_FULL_NAME_UPDATED_SUCCESSFULLY_SUB_TITLE : "Votre nom mis à jour avec succès.",
    CustomLocale.SETTINGS_ERROR_UPDATE_FULL_NAME_SUB_TITLE : "Impossible de mettre à jour votre nom.",
    CustomLocale.SETTINGS_VENDOR_STATUS_UPDATED_SUCCESSFULLY_SUB_TITLE : "Votre statut mis à jour avec succès.",
    CustomLocale.SETTINGS_ERROR_UPDATE_VENDOR_STATUS_SUB_TITLE : "Impossible de mettre à jour votre statut.",

    // - - - - - - - - - - - - - - - - - - VENDOR NEW ORDER SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.NEW_ORDER_TITLE: "Nouvel ordre",
    CustomLocale.NEW_ORDER_SUB_TITLE: "Remplissez la quantité de KG que vous souhaitez et n'oubliez pas de fixer la date à laquelle vous recevrez votre commande.",
    CustomLocale.NEW_ORDER_HINT: "Nous vous informerons avec plus de détails sur vos commandes dans l'écran des commandes.",
    CustomLocale.NEW_ORDER_DELIVERY_TIME: "Délai De Livraison",
    CustomLocale.NEW_ORDER_BAG_PRICE: "Prix Du Sac",
    CustomLocale.NEW_ORDER_TOTAL_PRICE: "Prix Total",
    CustomLocale.NEW_ORDER_CONFIRM_BUTTON: "Confirmer",
    CustomLocale.NEW_ORDER_MAD: "DH",

    // - - - - - - - - - - - - - - - - - - VENDOR ORDERS SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.ORDERS_TITLE : "Commandes",
    CustomLocale.ORDERS_BAG_PRICE_TITLE : "Prix Du Sac",
    CustomLocale.ORDERS_Quantity_TITLE : "Quantité",
    CustomLocale.ORDERS_CREATE_AT_TITLE : "Créé À",
    CustomLocale.ORDERS_SELECTED_AT_TITLE : "Choisi À",
    CustomLocale.ORDERS_TOTAL_TITLE : "Total",
    CustomLocale.ORDERS_MAD_TITLE : "DH",
    CustomLocale.ORDERS_KG_TITLE : "kg",
    CustomLocale.ORDERS_STATUS_TITLE : "Statut",
    CustomLocale.ORDERS_EMPTY_LIST_TITLE : "Aucune Commande Trouvée !",

    CustomLocale.ORDERS_EMPTY_COUNTER_SUB_TITLE: "Veuillez indiquer la quantité en kilogrammes que vous souhaitez !",
    CustomLocale.ORDERS_CANNOT_ORDER_SUB_TITLE: "Désolé, il est impossible de commander en ce moment !",
    CustomLocale.ORDERS_ORDER_SUCCESS_SUB_TITLE: "Merci pour votre commande, nous vous informerons dans la section des notifications.",


    // - - - - - - - - - - - - - - - - - - NOTIFICATIONS SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.NOTIFICATIONS_TITLE : "Notifications",
    CustomLocale.NOTIFICATION_TITLE : "Notification",
    CustomLocale.NOTIFICATION_DIALOG_DELETE_TITLE : "Supprimer",
    CustomLocale.NOTIFICATION_DIALOG_DISMISS_TITLE : "Rejeter",
    CustomLocale.NOTIFICATION_EMPTY_LIST_TITLE : "Aucune Notification Trouvée !",

    CustomLocale.NOTIFICATION_ERROR_DELETE_NOTIFICATION_SUB_TITLE : "Impossible de supprimer cette notification !",

    // - - - - - - - - - - - - - - - - - - BE SELLER SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.BE_VENDOR_TITLE : "Devenez Vendeur",
    CustomLocale.BE_VENDOR_CIN : "CIN",
    CustomLocale.BE_VENDOR_PHONE : "Téléphone",
    CustomLocale.BE_VENDOR_BIRTHDAY : "L'age",
    CustomLocale.BE_VENDOR_STEP_1_TITLE : "Informations personnelles",
    CustomLocale.BE_VENDOR_TITLE_1 : "Remplissez Les Blancs Avec Vos Informations ..",
    CustomLocale.BE_VENDOR_GENDER_TITLE : "Genre",
    CustomLocale.BE_VENDOR_GENDER_MAN_TITLE : "Homme",
    CustomLocale.BE_VENDOR_GENDER_WOMAN_TITLE : "Femme",

    CustomLocale.BE_VENDOR_STEP_2_TITLE: "Informations De Véhicule",
    CustomLocale.BE_VENDOR_TITLE_2: "Veuillez insérer les informations valides de votre véhicule ..",
    CustomLocale.BE_VENDOR_PICK_CAR_TYPE_TITLE: "Choisissez votre type de véhicule.",
    CustomLocale.BE_VENDOR_CAR_TRICYCLE_TYPE_TITLE: "Triporteur",
    CustomLocale.BE_VENDOR_CAR_PICK_UP_TYPE_TITLE: "Pick Up",
    CustomLocale.BE_VENDOR_CAR_CAR_TYPE_TITLE: "Voiture",
    CustomLocale.BE_VENDOR_CAR_THUMBNAIL_TITLE: "Image De Votre Véhicule.",
    CustomLocale.BE_VENDOR_CAR_INFO_TITLE: "Complète Véhicule Info.",
    CustomLocale.BE_VENDOR_CAR_ASSURANCE_NUMBER_TITLE: "Numéro D'assurance",
    CustomLocale.BE_VENDOR_CAR_REGISTRATION_NUMBER_TITLE: "Numéro D'enregistrement",

    CustomLocale.BE_VENDOR_STEP_3_TITLE: "Information Du Documents",
    CustomLocale.BE_VENDOR_TITLE_3: "Ajoutez Des Images De Votre Papier..",
    CustomLocale.BE_VENDOR_CIN_FRONT_THUMBNAIL_TITLE: "Image De CIN (Devant).",
    CustomLocale.BE_VENDOR_CIN_BACK_THUMBNAIL_TITLE: "Image De CIN (Arrière).",
    CustomLocale.BE_VENDOR_CAR_REGISTRATION_NUMBER_THUMBNAIL_TITLE: "Image Du Numéro D’enregistrement.",
    CustomLocale.BE_VENDOR_CAR_ASSURANCE_NUMBER_THUMBNAIL_TITLE: " Image du numéro D'assurance.",

    CustomLocale.BE_VENDOR_BUTTON_CONTINUE_TITLE : "Continuer",
    CustomLocale.BE_VENDOR_BUTTON_BACK_TITLE : "retour",

    CustomLocale.BE_VENDOR_SUCCESS_STATE_TITLE: "Continue",
    CustomLocale.BE_VENDOR_SUCCESS_STATE_SUB_TITLE: "Vous avez déjà soumis une candidature pour devenir vendeur pour notre équipe, veuillez patienter.",
    CustomLocale.BE_VENDOR_SUCCESS_STATE_BUTTON_TITLE: "Ok",

    CustomLocale.BE_VENDOR_ERROR_SUB_TITLE: "Impossible de vous envoyer une demande, veuillez réessayer",

    // - - - - - - - - - - - - - - - - - - VENDOR DETAILS SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.VENDOR_DETAILS_TITLE : "Détails Du Vendeur",
    CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_FEEDBACK : "Avis",
    CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_REPORT : "Rapport",
    CustomLocale.VENDOR_DETAILS_TITLE_TAB_MAP : "Carte",
    CustomLocale.VENDOR_DETAILS_TITLE_TAB_REVIEWS : "Commentaires",

    CustomLocale.VENDOR_DETAILS_FEEDBACK_TITLE : "Donner votre avis",
    CustomLocale.VENDOR_DETAILS_FEEDBACK_SUB_TITLE : "Que pensez-vous de ce vendeur",
    CustomLocale.VENDOR_DETAILS_FEEDBACK_TEXT_FILED_TITLE : "Avez-vous des idées et aimeriez-vous les partager ?",
    CustomLocale.VENDOR_DETAILS_FEEDBACK_HINT_TITLE : "Écrivez vos commentaires ..!",

    CustomLocale.VENDOR_DETAILS_REPORT_TITLE : "Donner un rapport",
    CustomLocale.VENDOR_DETAILS_REPORT_SUB_TITLE : "Pourquoi souhaitez-vous signaler ce vendeur?",

    CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_CANCEL : "Annuler",
    CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_SUBMIT : "Valide",

    CustomLocale.VENDOR_DETAILS_REVIEWS_EMPTY_LIST : "Aucune Avis Trouvée !",

    CustomLocale.VENDOR_DETAILS_REPORT_REASON_1 : "Mauvaise qualité / goût",
    CustomLocale.VENDOR_DETAILS_REPORT_REASON_2 : "Conditions insalubres",
    CustomLocale.VENDOR_DETAILS_REPORT_REASON_3 : "Manque d'hygiène",
    CustomLocale.VENDOR_DETAILS_REPORT_REASON_4 : "Graves violences verbales",
    CustomLocale.VENDOR_DETAILS_REPORT_REASON_5 : "Prix élevés",

    // - - - - - - - - - - - - - - - - - - WISHLISTS SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.WISHLISTS_TITLE : "Souhaits",
    CustomLocale.WSIHLIST_DIALOG_DELETE_TITLE : "Supprimer",
    CustomLocale.WSIHLIST_DIALOG_DISMISS_TITLE : "Rejeter",
    CustomLocale.WISHLIST_EMPTY_LIST_TITLE : "Aucune Souhait Trouvée !",

    CustomLocale.WISHLIST_ERROR_CANNOT_DELETE_SUB_TITLE: "Vous ne pouvez pas supprimer cette liste de souhaits pour le moment !",

    // - - - - - - - - - - - - - - - - - - FAQ SCREEN - - - - - - - - - - - - - - - - - -  //
    CustomLocale.FAQ_TITLE : "FAQ",
    CustomLocale.Q1 : "Où puis-je trouver l'application",
    CustomLocale.R1 : "Google play\nApp store\nHuawei store\n",
    CustomLocale.Q2 : "Quelles sont les nouvelles offres ?",
    CustomLocale.R2 : "Allez sur la page d'accueil et cochez l'option populaire, vous trouverez alors toutes les offres que nous avons pour vous.\n",
    CustomLocale.Q3 : "Comment puis-je être vendeur?",
    CustomLocale.R3 : "Allez sur la page Paramètres et cliquez sur Be Vendor puis remplissez le formulaire. après 24h nous vous enverrons notre acceptation\n",
    CustomLocale.Q4 : "Comment puis-je savoir que je suis votre fournisseur?",
    CustomLocale.R4 : "Allez sur la page Notifications, vous trouverez toutes les notifications\n",
    CustomLocale.Q5 : "Plus de questions",
    CustomLocale.R5 : "Contactez-nous\n",

    // - - - - - - - - - - - - - - - - - - VALIDATOR - - - - - - - - - - - - - - - - - -  //
    CustomLocale.VALIDATOR_CUSTOM_FIELD_ERROR1 : "Ne devrait pas être vide",
    CustomLocale.VALIDATOR_EMAIL_ERROR1 : "L'e-mail ne doit pas être vide",
    CustomLocale.VALIDATOR_EMAIL_ERROR2 : "L'e-mail doit contenir @",
    CustomLocale.VALIDATOR_PASSWORD_ERROR1 : "Ne doit pas être vide",
    CustomLocale.VALIDATOR_PASSWORD_ERROR2 : "Mot de passe trop court",
    CustomLocale.VALIDATOR_PASSWORD_ERROR3 : "Doit contenir caractères / chiffres",
    CustomLocale.VALIDATOR_PASSWORD_ERROR4 : "Mot de passe trop long",
    CustomLocale.VALIDATOR_MOBILE_NUMBER_ERROR1 : "Ne doit pas être vide",
    CustomLocale.VALIDATOR_MOBILE_NUMBER_ERROR2 : "Téléphone invalide",
    CustomLocale.VALIDATOR_AGE_ERROR1 : "Ne doit pas être vide",
    CustomLocale.VALIDATOR_AGE_ERROR2 : "Âge invalide",
    CustomLocale.VALIDATOR_AGE_ERROR3 : "Vous avez moins de 18 ans",
    CustomLocale.VALIDATOR_AGE_ERROR4 : "Tu as plus de 82 ans",

  };
}
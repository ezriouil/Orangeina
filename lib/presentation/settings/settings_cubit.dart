import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_colors.dart';
import '../../utils/constants/custom_image_strings.dart';
import '../../utils/constants/custom_sizes.dart';
import '../../utils/localisation/custom_locale.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {

  final FlutterLocalization localization = FlutterLocalization.instance;

  SettingsCubit() : super(SettingsCurrentState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  void init() async{
    GetStorage.init();
    emit(SettingsCurrentState(
      enableDarkMode: false,
      hideAuthentication: false,
      arabicLang: false,
      frenchLang: false,
      englishLang: true,
      updateFirstNameController: TextEditingController(),
      updateLastNameController: TextEditingController(),
      updateEmailNameController: TextEditingController(),
      updatePasswordController: TextEditingController(),
      updatePhoneController: TextEditingController(),
    ));
  }

  // - - - - - - - - - - - - - - - - - - UPDATE SWITCH BUTTON ( DARK MODE ) - - - - - - - - - - - - - - - - - -  //
  void onUpdateEnableDarkMode(bool value){
    final currentState = state as SettingsCurrentState;
    emit(currentState.copyWith(enableDarkMode: value));
  }

  // - - - - - - - - - - - - - - - - - - UPDATE SWITCH BUTTON ( HIDE AUTHENTICATION ) - - - - - - - - - - - - - - - - - -  //
  void onUpdateHideAuth(bool value){
    final currentState = state as SettingsCurrentState;
    emit(currentState.copyWith(hideAuthentication: value));
  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE IMAGE PROFILE - - - - - - - - - - - - - - - - - -  //
  onUpdateImageProfile()async{

  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE FULL NAME - - - - - - - - - - - - - - - - - -  //
  onUpdateFullName({required BuildContext context}) async{
    final currentState = state as SettingsCurrentState;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SizedBox(
                  height: 250.0,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // - - - - - - - - - - - - - - - - - - FIRST NAME - - - - - - - - - - - - - - - - - -  //
                      CustomTextField(
                          leadingIcon: Iconsax.user,
                          hint: "First Name",
                          controller: currentState.updateFirstNameController!),

                      // - - - - - - - - - - - - - - - - - - LAST NAME - - - - - - - - - - - - - - - - - -  //
                      CustomTextField(
                          leadingIcon: Iconsax.user,
                          hint: "Last Name",
                          controller: currentState.updateLastNameController!),

                      // - - - - - - - - - - - - - - - - - - BUTTON UPDATE - - - - - - - - - - - - - - - - - -  //
                      CustomElevatedButton(onClick: () {

                        currentState.updateFirstNameController!.clear();
                        currentState.updateLastNameController!.clear();

                      }, child: const Text("Update"),)
                    ],
                  )));
        });
  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE EMAIL - - - - - - - - - - - - - - - - - -  //
  onUpdateEmail({required BuildContext context})async{
    final currentState = state as SettingsCurrentState;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SizedBox(
                  height: 180.0,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // - - - - - - - - - - - - - - - - - - EMAIL - - - - - - - - - - - - - - - - - -  //
                      CustomTextField(
                          leadingIcon: Iconsax.direct_right,
                          hint: "Email",
                          controller: currentState.updateEmailNameController!,
                        textInputType: TextInputType.emailAddress,
                      ),

                      // - - - - - - - - - - - - - - - - - - BUTTON UPDATE - - - - - - - - - - - - - - - - - -  //
                      CustomElevatedButton(onClick: () { currentState.updateEmailNameController!.clear(); }, child: const Text("Update"),)
                    ],
                  )));
        });
  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE PASSWORD - - - - - - - - - - - - - - - - - -  //
  onUpdatePassword({required BuildContext context})async{
    final currentState = state as SettingsCurrentState;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SizedBox(
                  height: 180.0,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // - - - - - - - - - - - - - - - - - - EMAIL - - - - - - - - - - - - - - - - - -  //
                      CustomTextField(
                        leadingIcon: Iconsax.password_check,
                        hint: "Password",
                        controller: currentState.updatePasswordController!
                      ),

                      // - - - - - - - - - - - - - - - - - - BUTTON UPDATE - - - - - - - - - - - - - - - - - -  //
                      CustomElevatedButton(onClick: () { currentState.updatePasswordController!.clear(); }, child: const Text("Update"),)
                    ],
                  )));
        });
  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE PHONE - - - - - - - - - - - - - - - - - -  //
  onUpdatePhone({required BuildContext context})async{
    final currentState = state as SettingsCurrentState;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SizedBox(
                  height: 180.0,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      // - - - - - - - - - - - - - - - - - - EMAIL - - - - - - - - - - - - - - - - - -  //
                      CustomTextField(
                        leadingIcon: Iconsax.call,
                        hint: "Phone",
                        controller: currentState.updatePhoneController!,
                        textInputType: TextInputType.phone,
                      ),

                      // - - - - - - - - - - - - - - - - - - BUTTON UPDATE - - - - - - - - - - - - - - - - - -  //
                      CustomElevatedButton(onClick: () { currentState.updatePhoneController!.clear(); }, child: const Text("Update"),)
                    ],
                  )));
        });
  }

  // - - - - - - - - - - - - - - - - - - SHOW DIALOG LANGUAGES - - - - - - - - - - - - - - - - - -  //
  onUpdateLanguage({ required BuildContext context, required Function callBack }) async{

    final SettingsCurrentState currentState = state as SettingsCurrentState;
    //String langSelected = "";

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // - - - - - - - - - - - - - - - - - - IMAGE - - - - - - - - - - - - - - - - - -  //
                        ClipRRect(borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2), child: Image.asset(CustomImageStrings.FLAG_MOROCCO, height: 30, width: 40, fit: BoxFit.cover,)),

                        // - - - - - - - - - - - - - - - - - - TEXT - - - - - - - - - - - - - - - - - -  //
                        Text("العربية", style: Theme.of(context).textTheme.headlineSmall),

                        // - - - - - - - - - - - - - - - - - - CHECKBOX - - - - - - - - - - - - - - - - - -  //
                        Checkbox(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                            value: currentState.arabicLang,
                            onChanged: (value) async{
                              if(!currentState.arabicLang!){
                                //langSelected = CustomLocale.AR;
                                localization.translate(CustomLocale.AR);
                                emit(currentState.copyWith(arabicLang: true, frenchLang: false, englishLang: false));
                                callBack.call();
                              }
                            }),
                      ]),
                  const Divider(color: CustomColors.GRAY_LIGHT),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // - - - - - - - - - - - - - - - - - - IMAGE - - - - - - - - - - - - - - - - - -  //
                        ClipRRect(borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2), child: Image.asset(CustomImageStrings.FLAG_FRANCE, height: 30, width: 40, fit: BoxFit.cover,)),

                        // - - - - - - - - - - - - - - - - - - TEXT - - - - - - - - - - - - - - - - - -  //
                        Text("Francais", style: Theme.of(context).textTheme.headlineSmall),

                        // - - - - - - - - - - - - - - - - - - CHECKBOX - - - - - - - - - - - - - - - - - -  //
                        Checkbox(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                            value: currentState.frenchLang,
                            onChanged: (value) async{
                              if(!currentState.frenchLang!){
                                //langSelected = CustomLocale.FR;
                                localization.translate(CustomLocale.FR);
                                emit(currentState.copyWith(frenchLang: true, arabicLang: false, englishLang: false));
                                callBack.call();
                              }
                            }),
                      ]),
                  const Divider(color: CustomColors.GRAY_LIGHT),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // - - - - - - - - - - - - - - - - - - IMAGE - - - - - - - - - - - - - - - - - -  //
                        ClipRRect(borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2), child: Image.asset(CustomImageStrings.FLAG_ENGLAND, height: 30, width: 40, fit: BoxFit.cover,)),

                        // - - - - - - - - - - - - - - - - - - TEXT - - - - - - - - - - - - - - - - - -  //
                        Text("English", style: Theme.of(context).textTheme.headlineSmall),

                        // - - - - - - - - - - - - - - - - - - CHECKBOX - - - - - - - - - - - - - - - - - -  //
                        Checkbox(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                            value: currentState.englishLang,
                            onChanged: (value) async{
                              if(!currentState.englishLang!){
                                //langSelected = CustomLocale.EN;
                                localization.translate(CustomLocale.EN);
                                emit(currentState.copyWith(englishLang: true, arabicLang: false, frenchLang: false));
                                callBack.call();
                              }
                            }),
                      ]),
                ],
              ),
            ),
          );
        });

    //if(langSelected == "") return;
    //await LocalStorage.upsert(key: "LANGUAGE", value: langSelected, storage: storage);
  }

  // - - - - - - - - - - - - - - - - - - ON NAVIGATE TO PRIVACY AND SECURITY - - - - - - - - - - - - - - - - - -  //
  onNavigateToPrivacyAndSecurity(){}

  // - - - - - - - - - - - - - - - - - - ON NAVIGATE TO HELP AND SUPPORT - - - - - - - - - - - - - - - - - -  //
  onNavigateToHelpAndSupport(){}

  // - - - - - - - - - - - - - - - - - - ON NAVIGATE TO ABOUT - - - - - - - - - - - - - - - - - -  //
  onNavigateToAbout(){}

}

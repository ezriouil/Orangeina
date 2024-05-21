import 'package:berkania/data/repositories_impl/user_repository_impl.dart';
import 'package:berkania/data/repositories_impl/vendor_repository_impl.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/constants/custom_colors.dart';
import '../../utils/constants/custom_image_strings.dart';
import '../../utils/constants/custom_sizes.dart';
import '../../utils/local/storage/local_storage.dart';
import '../../utils/localisation/custom_locale.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {

  final FlutterLocalization localization = FlutterLocalization.instance;
  final _storage = GetStorage();
  final UserRepositoryImpl _userRepository = UserRepositoryImpl();
  final VendorRepositoryImpl _vendorRepository = VendorRepositoryImpl();
  final ImagePicker _imagePicker = ImagePicker();

  SettingsCubit() : super(SettingsCurrentState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  void init() async{

    emit(SettingsCurrentState(
      arabicLang: false,
      englishLang: false,
      frenchLang: false,
      updateImageProfilePath : "",
      updateFirstNameController: TextEditingController(),
      updateLastNameController: TextEditingController(),
      updatePhoneController: TextEditingController(),
    ));

    final String lang = await LocalStorage.read(key: "LANGUAGE", storage: _storage) ?? CustomLocale.EN;


    emit((state as SettingsCurrentState).copyWith(
      frenchLang: lang == CustomLocale.FR ? true : false,
      arabicLang: lang == CustomLocale.AR ? true : false,
      englishLang: lang == CustomLocale.EN ? true : false,
    ));

  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE IMAGE PROFILE - - - - - - - - - - - - - - - - - -  //
  onUpdateImageProfile({ required BuildContext context })async{
    final String img = await LocalStorage.read(key: "IMAGE_PROFILE", storage: _storage);
    print("++++++++++");
    print(img);
    print("++++++++++");
    try{

      final String uid = await LocalStorage.read(key: "UID", storage: _storage) ?? "";

      final currentState = state as SettingsCurrentState;

      final img = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
      if(img == null) {
        //SNACK BAR
        return;
      }

      final isUserExist = await _userRepository.existUser(userId: uid);
      if(isUserExist){
        await _userRepository.updateUserImage(userId: uid, newImage: img.path);
        await LocalStorage.upsert(key: "IMAGE_PROFILE", value: currentState.updateImageProfilePath, storage: _storage);
        //SNACK BAR
        return;
      }

      final isVendorExist = await _vendorRepository.existVendor(vendorId: uid);
      if(isVendorExist){
        await _userRepository.updateUserImage(userId: uid, newImage: img.path);
        await LocalStorage.upsert(key: "IMAGE_PROFILE", value: currentState.updateImageProfilePath, storage: _storage);
        //SNACK BAR
        return;
      }

      currentState.updateFirstNameController!.clear();
      currentState.updateLastNameController!.clear();
      context.mounted ? context.pop() : null;


    }catch(e){
      print(e.toString());
    }
  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE FULL NAME - - - - - - - - - - - - - - - - - -  //
  onUpdateFullName({required BuildContext context}) async{

    final String firstName = await LocalStorage.read(key: "FIRST_NAME", storage: _storage) ?? CustomLocale.REGISTER_FIRST_NAME.getString(context.mounted ? context : context);
    final String lastName = await LocalStorage.read(key: "LAST_NAME", storage: _storage) ?? CustomLocale.REGISTER_LAST_NAME.getString(context.mounted ? context : context);
    final String uid = await LocalStorage.read(key: "UID", storage: _storage) ?? "";

    final currentState = state as SettingsCurrentState;

    await showDialog(
        context: context.mounted ? context : context,
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
                          hint: firstName,
                          controller: currentState.updateFirstNameController!),

                      // - - - - - - - - - - - - - - - - - - LAST NAME - - - - - - - - - - - - - - - - - -  //
                      CustomTextField(
                          leadingIcon: Iconsax.user,
                          hint: lastName,
                          controller: currentState.updateLastNameController!),

                      // - - - - - - - - - - - - - - - - - - BUTTON UPDATE - - - - - - - - - - - - - - - - - -  //
                      CustomElevatedButton(onClick: () async{

                        try{

                          if(currentState.updateFirstNameController!.text.trim().length < 3 || currentState.updateFirstNameController!.text.trim().length < 3){
                            context.mounted ? context.pop() : null;
                            return;
                          }

                          final isUserExist = await _userRepository.existUser(userId: uid);
                          if(isUserExist){
                            await _userRepository.updateUserFullName(userId: uid, newFirstName: currentState.updateFirstNameController!.text, newLastName: currentState.updateLastNameController!.text);
                            await LocalStorage.upsert(key: "FIRST_NAME", value: currentState.updateFirstNameController!.text, storage: _storage);
                            await LocalStorage.upsert(key: "LAST_NAME", value: currentState.updateLastNameController!.text, storage: _storage);
                            currentState.updateFirstNameController!.clear();
                            currentState.updateLastNameController!.clear();
                            context.mounted ? context.pop() : null;
                            //SNACK BAR
                            return;
                          }

                          final isVendorExist = await _vendorRepository.existVendor(vendorId: uid);
                          if(isVendorExist){
                            await _vendorRepository.updateVendorFullName(vendorId: uid, newFirstName: currentState.updateFirstNameController!.text, newLastName: currentState.updateLastNameController!.text);
                            await LocalStorage.upsert(key: "FIRST_NAME", value: currentState.updateFirstNameController!.text, storage: _storage);
                            await LocalStorage.upsert(key: "LAST_NAME", value: currentState.updateLastNameController!.text, storage: _storage);
                            currentState.updateFirstNameController!.clear();
                            currentState.updateLastNameController!.clear();
                            context.mounted ? context.pop() : null;
                            //SNACK BAR
                            return;
                          }

                          currentState.updateFirstNameController!.clear();
                          currentState.updateLastNameController!.clear();
                          context.mounted ? context.pop() : null;

                        }catch(e){
                          print("+++++++++");
                          print(e.toString());
                          print("+++++++++");
                        }

                      }, child: Text(CustomLocale.SETTINGS_BUTTON_UPDATE_TITLE.getString(context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE)))
                    ],
                  )));
        });
  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE PHONE - - - - - - - - - - - - - - - - - -  //
  onUpdatePhone({required BuildContext context})async{

    final String phone = await LocalStorage.read(key: "PHONE", storage: _storage) ?? CustomLocale.SETTINGS_PHONE.getString(context.mounted ? context : context);

    final currentState = state as SettingsCurrentState;
    await showDialog(
        context: context.mounted ? context : context,
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
                        hint: phone,
                        controller: currentState.updatePhoneController!,
                        textInputType: TextInputType.phone,
                      ),

                      // - - - - - - - - - - - - - - - - - - BUTTON UPDATE - - - - - - - - - - - - - - - - - -  //
                      CustomElevatedButton(onClick: () { currentState.updatePhoneController!.clear(); }, child: Text(CustomLocale.SETTINGS_BUTTON_UPDATE_TITLE.getString(context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE)))
                    ],
                  )));
        });
  }

  // - - - - - - - - - - - - - - - - - - SHOW DIALOG LANGUAGES - - - - - - - - - - - - - - - - - -  //
  onUpdateLanguage({ required BuildContext context, required Function callBack }) async{

    final SettingsCurrentState currentState = state as SettingsCurrentState;
    String langSelected = "";

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

    if(langSelected == "") return;
    await LocalStorage.upsert(key: "LANGUAGE", value: langSelected, storage: _storage);
  }

  // - - - - - - - - - - - - - - - - - - ON NAVIGATE TO PRIVACY AND SECURITY - - - - - - - - - - - - - - - - - -  //
  onNavigateToPrivacyAndSecurity(){}

  // - - - - - - - - - - - - - - - - - - ON NAVIGATE TO HELP AND SUPPORT - - - - - - - - - - - - - - - - - -  //
  onNavigateToHelpAndSupport(){}

  // - - - - - - - - - - - - - - - - - - ON NAVIGATE TO ABOUT - - - - - - - - - - - - - - - - - -  //
  onNavigateToAbout(){}

}

/*
  // - - - - - - - - - - - - - - - - - - ON UPDATE EMAIL - - - - - - - - - - - - - - - - - -  //
  onUpdateEmail({required BuildContext context})async{

    final String uid = await LocalStorage.read(key: "UID", storage: _storage) ?? "";
    final String email = await LocalStorage.read(key: "EMAIL", storage: _storage) ?? CustomLocale.EMAIL.getString(context.mounted ? context : context);

    final currentState = state as SettingsCurrentState;
    await showDialog(
        context: context.mounted ? context : context,
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
                          hint: email,
                          controller: currentState.updateEmailNameController!,
                        textInputType: TextInputType.emailAddress,
                      ),

                      // - - - - - - - - - - - - - - - - - - BUTTON UPDATE - - - - - - - - - - - - - - - - - -  //
                      CustomElevatedButton(onClick: () async{
                        try{

                          if(currentState.updateEmailNameController!.text.trim().length < 6 || !(currentState.updateEmailNameController!.text.contains("@"))){
                            context.mounted ? context.pop() : null;
                            return;
                          }

                          final isUserExist = await _userRepository.existUser(userId: uid);
                          if(isUserExist){
                            await _userRepository.updateUserEmail(userId: uid, newEmail: currentState.updateEmailNameController!.text);
                            await LocalStorage.upsert(key: "EMAIL", value: currentState.updateEmailNameController!.text, storage: _storage);
                            currentState.updateEmailNameController!.clear();
                            context.mounted ? context.pop() : null;
                            //SNACK BAR
                            return;
                          }

                          final isVendorExist = await _vendorRepository.existVendor(vendorId: uid);
                          if(isVendorExist){
                            await _vendorRepository.updateVendorEmail(vendorId: uid, newEmail: currentState.updateEmailNameController!.text);
                            await LocalStorage.upsert(key: "EMAIL", value: currentState.updateEmailNameController!.text, storage: _storage);
                            currentState.updateEmailNameController!.clear();
                            context.mounted ? context.pop() : null;
                            //SNACK BAR
                            return;
                          }

                          currentState.updateEmailNameController!.clear();
                          context.mounted ? context.pop() : null;

                        }catch(e){
                          print("+++++++++");
                          print(e.toString());
                          print("+++++++++");
                        }
                      }, child: Text(CustomLocale.SETTINGS_BUTTON_UPDATE_TITLE.getString(context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE)))
                    ],
                  )));
        });
  }
 */

/*
 // - - - - - - - - - - - - - - - - - - ON UPDATE PASSWORD - - - - - - - - - - - - - - - - - -  //
  onUpdatePassword({required BuildContext context})async{

    final String uid = await LocalStorage.read(key: "UID", storage: _storage) ?? "";
    final String password = await LocalStorage.read(key: "PASSWORD", storage: _storage) ?? CustomLocale.PASSWORD.getString(context.mounted ? context : context);

    final currentState = state as SettingsCurrentState;
    await showDialog(
        context: context.mounted ? context : context,
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
                        hint: password,
                        controller: currentState.updatePasswordController!
                      ),

                      // - - - - - - - - - - - - - - - - - - BUTTON UPDATE - - - - - - - - - - - - - - - - - -  //
                      CustomElevatedButton(onClick: () async{

                        try{

                          if(currentState.updatePasswordController!.text.trim().length < 6){
                            context.mounted ? context.pop() : null;
                            //SNACK BAR
                            return;
                          }

                          final isUserExist = await _userRepository.existUser(userId: uid);
                          if(isUserExist){
                            await _userRepository.updateUserPassword(userId: uid, newPassword: currentState.updatePasswordController!.text);
                            await LocalStorage.upsert(key: "PASSOWRD", value: currentState.updatePasswordController!.text, storage: _storage);
                            currentState.updatePasswordController!.clear();
                            context.mounted ? context.pop() : null;
                            //SNACK BAR
                            return;
                          }

                          final isVendorExist = await _vendorRepository.existVendor(vendorId: uid);
                          if(isVendorExist){
                            await _vendorRepository.updateVendorPassword(vendorId: uid, newPassword: currentState.updatePasswordController!.text);
                            await LocalStorage.upsert(key: "PASSOWRD", value: currentState.updatePasswordController!.text, storage: _storage);
                            currentState.updatePasswordController!.clear();
                            context.mounted ? context.pop() : null;
                            //SNACK BAR
                            return;
                          }

                          currentState.updatePasswordController!.clear();
                          context.mounted ? context.pop() : null;

                        }catch(e){
                          print("+++++++++");
                          print(e.toString());
                          print("+++++++++");
                        }

                      }, child: Text(CustomLocale.SETTINGS_BUTTON_UPDATE_TITLE.getString(context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE)))
                    ],
                  )));
        });
  }
 */
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/domain/entities/user_entity.dart';
import 'package:berkania/domain/repositories/auth_repository.dart';
import 'package:berkania/domain/repositories/user_repository.dart';
import 'package:berkania/domain/repositories/vendor_repository.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/presentation/widgets/custom_text_field.dart';
import 'package:berkania/utils/constants/custom_txt_strings.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/vendor_entity.dart';
import '../../utils/constants/custom_colors.dart';
import '../../utils/constants/custom_image_strings.dart';
import '../../utils/constants/custom_sizes.dart';
import '../../utils/extensions/validator.dart';
import '../../utils/local/storage/local_storage.dart';
import '../../utils/localisation/custom_locale.dart';
import '../widgets/custom_snackbars.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  final FlutterLocalization localization = FlutterLocalization.instance;
  final ImagePicker _imagePicker = ImagePicker();
  VendorEntity? _vendor;
  UserEntity? _user;
  String? uid, lang;
  
  final GetStorage storage;
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final VendorRepository vendorRepository;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR - - - - - - - - - - - - - - - - - -  //
  SettingsCubit({ required this.storage, required this.userRepository, required this.vendorRepository, required this.authRepository }) : super(SettingsMainState()) { init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  void init() async {

    emit(SettingsMainState(
      arabicLang: false,
      englishLang: false,
      frenchLang: false,
      vendorOnlineOffline: false,
      updateImageProfilePath: "",
      updateFirstNameController: TextEditingController(),
      updateLastNameController: TextEditingController(),
      updatePhoneController: TextEditingController(),
    ));

    uid = await LocalStorage.read(key: "UID", storage: storage);
    lang = await LocalStorage.read(key: "LANGUAGE", storage: storage) ?? CustomLocale.EN;

    if(uid == null) return;
    final bool isVendor = await vendorRepository.existVendor(vendorId: uid!);
    if(isVendor) { _vendor = await vendorRepository.getVendorById(vendorId: uid!); }
    else { _user = await userRepository.getUserInfo(id: uid!); }
    emit((state as SettingsMainState).copyWith(
      frenchLang: lang == CustomLocale.FR ? true : false,
      arabicLang: lang == CustomLocale.AR ? true : false,
      englishLang: lang == CustomLocale.EN ? true : false,
      updateImageProfilePath: _user?.avatar ?? _vendor?.avatar,
      isVendor: isVendor,
      vendorOnlineOffline: _vendor?.isOnline ?? false,
    ));

  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE IMAGE PROFILE - - - - - - - - - - - - - - - - - -  //
  void onUpdateImageProfile({required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              width: double.infinity,
              height: 150,
              child: Column(
                children: [

                  CustomElevatedButton(
                      child: Text(CustomLocale.SETTINGS_UPDATE_IMAGE_BUTTON_GALLERY_TITLE.getString(context.mounted ? context : context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE)),
                      onClick: () async {
                        try {
                          context.pop();
                          if(uid == null) return;

                          final currentState = state as SettingsMainState;

                          final img = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
                          if (img == null && context.mounted) {
                            CustomSnackBar.show(context: context, title: "No Image Selected", subTitle: "Please Select Image For Your Profile", type: ContentType.warning);
                            return;
                          }

                          final isUserExist = await userRepository.existUser(userId: uid!);
                          if (isUserExist) {
                            final String newImageLink = await userRepository.updateUserImage(userId: uid!, newImage: img!.path);
                            await userRepository.updateUserAvatar(userId: uid!, newAvatar: newImageLink);
                            emit(currentState.copyWith(updateImageProfilePath: newImageLink));
                            return;
                          }

                          final isVendorExist = await vendorRepository.existVendor(vendorId: uid!);
                          if (isVendorExist) {
                            await vendorRepository.deleteVendorImage(imgName: uid!);
                            final String newImageLink = await vendorRepository.saveVendorImage(imgName: uid!, imgPath: img!.path);
                            await vendorRepository.updateVendorAvatar(vendorId: uid!, newAvatar: newImageLink);
                            emit(currentState.copyWith(updateImageProfilePath: newImageLink));
                            return;
                          }

                          context.mounted ? context.pop() : null;

                        } catch (_) {
                          context.mounted ? CustomSnackBar.show(context: context, title: "Error 404", subTitle: "Try Next Time.", type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
                        }
                      }),

                  CustomElevatedButton(
                      onClick: context.pop,
                      child: Text(CustomLocale.SETTINGS_UPDATE_IMAGE_BUTTON_DISMISS_TITLE.getString(context.mounted ? context : context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE))),

                ],
              ),
            ),
          );
        });
  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE FULL NAME - - - - - - - - - - - - - - - - - -  //
  void onUpdateFullName({required BuildContext context}) async {

    String firstName;
    String lastName;
    final GlobalKey<FormState> formState = GlobalKey<FormState>();

    if(_user != null){
      firstName = _user?.firstName ?? CustomLocale.REGISTER_FIRST_NAME.getString(context.mounted ? context : context);
      lastName = _user?.lastName ?? CustomLocale.REGISTER_LAST_NAME.getString(context.mounted ? context : context);
    }else{
      firstName = _vendor?.firstName ?? CustomLocale.REGISTER_FIRST_NAME.getString(context.mounted ? context : context);
      lastName = _vendor?.lastName ?? CustomLocale.REGISTER_LAST_NAME.getString(context.mounted ? context : context);
    }

    final currentState = state as SettingsMainState;

    await showDialog(
        context: context.mounted ? context : context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
              content: SizedBox(
                  height: 260.0,
                  width: double.infinity,
                  child: Form(
                    key: formState,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // - - - - - - - - - - - - - - - - - - FIRST NAME - - - - - - - - - - - - - - - - - -  //
                        CustomTextField(
                            leadingIcon: Iconsax.user,
                            hint: firstName,
                            validator: (value) => Validator.validateEmptyField(CustomLocale.REGISTER_FIRST_NAME_VALIDATOR.getString(context), value),
                            controller: currentState.updateFirstNameController!),

                        // - - - - - - - - - - - - - - - - - - LAST NAME - - - - - - - - - - - - - - - - - -  //
                        CustomTextField(
                            leadingIcon: Iconsax.user,
                            hint: lastName,
                            validator: (value) => Validator.validateEmptyField(CustomLocale.REGISTER_LAST_NAME_VALIDATOR.getString(context), value),
                            controller: currentState.updateLastNameController!),

                        // - - - - - - - - - - - - - - - - - - BUTTON UPDATE - - - - - - - - - - - - - - - - - -  //
                        CustomElevatedButton(
                            onClick: () async {
                              try {

                                // CHECK THE FORM
                                if(!formState.currentState!.validate()) return;

                                if (uid == null) {
                                  context.mounted ? context.pop() : null;
                                  return;
                                }

                                final isUserExist = await userRepository.existUser(userId: uid!);
                                if (isUserExist) {
                                  await userRepository.updateUserFullName(userId: uid!, newFirstName: currentState.updateFirstNameController!.text, newLastName: currentState.updateLastNameController!.text);
                                  await LocalStorage.upsert(
                                      key: "FIRST_NAME",
                                      value: currentState.updateFirstNameController!.text,
                                      storage: storage);
                                  await LocalStorage.upsert(
                                      key: "LAST_NAME",
                                      value: currentState.updateLastNameController!.text,
                                      storage: storage);
                                  if(!context.mounted) return;
                                  context.pop();
                                  CustomSnackBar.show(context: context, title: "Updated Successfully", subTitle: "First Name and Last Name Updated", type: ContentType.success);
                                  return;
                                }

                                final isVendorExist = await vendorRepository.existVendor(vendorId: uid!);
                                if (isVendorExist) {
                                  await vendorRepository.updateVendorFullName(
                                      vendorId: uid!,
                                      newFirstName: currentState.updateFirstNameController!.text,
                                      newLastName: currentState.updateLastNameController!.text);
                                  await LocalStorage.upsert(
                                      key: "FIRST_NAME",
                                      value: currentState.updateFirstNameController!.text,
                                      storage: storage);
                                  await LocalStorage.upsert(
                                      key: "LAST_NAME",
                                      value: currentState.updateLastNameController!.text,
                                      storage: storage);
                                  currentState.updateFirstNameController!.clear();
                                  currentState.updateLastNameController!.clear();
                                  if(!context.mounted) return;
                                  context.pop();
                                  CustomSnackBar.show(context: context, title: "Updated Successfully", subTitle: "First Name and Last Name Updated", type: ContentType.success);
                                  return;
                                }

                                currentState.updateFirstNameController!.clear();
                                currentState.updateLastNameController!.clear();
                                context.mounted ? context.pop(): null;

                              } catch (e) {
                                context.mounted ? CustomSnackBar.show(context: context, title: "Error 404", subTitle: "Try Next Time", type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
                              }
                            },
                            child: Text(
                                CustomLocale.SETTINGS_BUTTON_UPDATE_TITLE.getString(context),
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE)))

                      ],
                    ),
                  )));
        });
  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE PHONE - - - - - - - - - - - - - - - - - -  //
  void onUpdatePhone({required BuildContext context}) async {
    String phone;
    final GlobalKey<FormState> formState = GlobalKey<FormState>();

    if(_user != null){
      phone = _user?.phoneNumber ?? CustomLocale.SETTINGS_PHONE.getString(context.mounted ? context : context);
    }else{
      phone = _vendor?.phoneNumber ?? CustomLocale.SETTINGS_PHONE.getString(context.mounted ? context : context);
    }

    final currentState = state as SettingsMainState;

    await showDialog(
        context: context.mounted ? context : context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SizedBox(
                  height: 180.0,
                  width: double.infinity,
                  child: Form(
                    key: formState,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {},
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            useBottomSheetSafeArea: true,
                            showFlags: false
                          ),
                          selectorTextStyle: Theme.of(context).textTheme.bodyLarge,
                          textFieldController: currentState.updatePhoneController,
                          hintText: phone,
                          initialValue: PhoneNumber(isoCode: "MA"),
                          formatInput: false,
                          validator: (value) => Validator.validateMobilePhone(value),
                          spaceBetweenSelectorAndTextField: 0,
                        ),



                        // - - - - - - - - - - - - - - - - - - BUTTON UPDATE - - - - - - - - - - - - - - - - - -  //
                        CustomElevatedButton(
                            onClick: () async {
                              try {
                                // CHECK THE FORM
                                if(!formState.currentState!.validate()) return;

                                if (uid == null) {
                                  context.mounted ? context.pop() : null;
                                  return;
                                }

                                final isUserExist = await userRepository.existUser(userId: uid!);
                                if (isUserExist) {
                                  await userRepository.updateUserPhone(userId: uid!, newPhone: currentState.updatePhoneController!.text);
                                  await LocalStorage.upsert(key: "PHONE", value: currentState.updatePhoneController!.text, storage: storage);
                                  if(!context.mounted) return;
                                  context.mounted ? context.pop() : null;
                                  CustomSnackBar.show(context: context, title: "Updated Successfully", subTitle: "Your Phone Is Updated", type: ContentType.success);
                                  return;
                                }

                                final isVendorExist = await vendorRepository.existVendor(vendorId: uid!);
                                if (isVendorExist) {
                                  await vendorRepository.updateVendorPhone(vendorId: uid!, newPhone: currentState.updatePhoneController!.text);
                                  await LocalStorage.upsert(key: "PHONE", value: currentState.updatePhoneController!.text, storage: storage);
                                  context.mounted ? context.pop() : null;
                                  if(!context.mounted) return;
                                  context.pop();
                                  CustomSnackBar.show(context: context, title: "Updated Successfully", subTitle: "Your Phone Is Updated", type: ContentType.success);
                                  return;
                                }
                                context.mounted ? context.pop() : null;
                              } catch (e) {
                                context.mounted ? CustomSnackBar.show(context: context, title: "Error 404", subTitle: "Try Next Time", type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
                              }
                            },
                            child: Text(CustomLocale.SETTINGS_BUTTON_UPDATE_TITLE.getString(context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE)))
                      ],
                    ),
                  )));
        });
  }

  // - - - - - - - - - - - - - - - - - - VENDOR => (ONLINE / OFFLINE) - - - - - - - - - - - - - - - - - -  //
  void updateVendorStatus(bool value) async{
    try{

      if (uid == null) return;

      final currentState = state as SettingsMainState;
      emit(SettingsLoadingState());

      if(value) {
        final isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
        final permission = await Geolocator.checkPermission();
        if(!isLocationServiceEnabled || permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
          // SNACK BAR
          return;
        }
        final Position currentPosition = await Geolocator.getCurrentPosition();
        await vendorRepository.online(vendorId: uid!, lat: currentPosition.latitude, lng: currentPosition.longitude);
        await LocalStorage.upsert(key: "VENDOR_ONLINE_OFFLINE", value: value, storage: storage);
      }else{
        await vendorRepository.offline(vendorId: uid!);
        await LocalStorage.upsert(key: "VENDOR_ONLINE_OFFLINE", value: value, storage: storage);
      }
      emit(currentState.copyWith(vendorOnlineOffline: value));
    }catch(_) {}
  }

  // - - - - - - - - - - - - - - - - - - VENDOR => ON NAVIGATE TO NEW ORDER SCREEN - - - - - - - - - - - - - - - - - -  //
  void onNavigateToNewOrderScreen({ required BuildContext context }) { context.pushNamed(CustomRouter.VENDOR_NEW_ORDER); }

  // - - - - - - - - - - - - - - - - - - VENDOR => ON NAVIGATE TO ORDERS SCREEN - - - - - - - - - - - - - - - - - -  //
  void onNavigateToOrdersScreen({ required BuildContext context }) { context.pushNamed(CustomRouter.VENDOR_ORDERS); }

  // - - - - - - - - - - - - - - - - - - BECOME VENDOR - - - - - - - - - - - - - - - - - -  //
  void onNavigateToBeVendorScreen({ required BuildContext context }) { context.pushNamed(CustomRouter.BE_VENDOR); }

  // - - - - - - - - - - - - - - - - - - SHOW DIALOG LANGUAGES - - - - - - - - - - - - - - - - - -  //
  void onUpdateLanguage({required BuildContext context, required Function callBack}) async {
    final SettingsMainState currentState = state as SettingsMainState;
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
                        ClipRRect(
                            borderRadius: BorderRadius.circular(
                                CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                            child: Image.asset(
                              CustomImageStrings.FLAG_MOROCCO,
                              height: 30,
                              width: 40,
                              fit: BoxFit.cover,
                            )),

                        // - - - - - - - - - - - - - - - - - - TEXT - - - - - - - - - - - - - - - - - -  //
                        Text("العربية", style: Theme.of(context).textTheme.headlineSmall),

                        // - - - - - - - - - - - - - - - - - - CHECKBOX - - - - - - - - - - - - - - - - - -  //
                        Checkbox(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                            value: currentState.arabicLang,
                            onChanged: (value) async {
                              if (!currentState.arabicLang!) {
                                langSelected = CustomLocale.AR;
                                localization.translate(CustomLocale.AR);
                                emit(currentState.copyWith(
                                    arabicLang: true,
                                    frenchLang: false,
                                    englishLang: false));
                                callBack.call();
                              }
                            }),
                      ]),
                  const Divider(color: CustomColors.GRAY_LIGHT),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // - - - - - - - - - - - - - - - - - - IMAGE - - - - - - - - - - - - - - - - - -  //
                        ClipRRect(
                            borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                            child: Image.asset(CustomImageStrings.FLAG_FRANCE,
                              height: 30,
                              width: 40,
                              fit: BoxFit.cover,
                            )),

                        // - - - - - - - - - - - - - - - - - - TEXT - - - - - - - - - - - - - - - - - -  //
                        Text("Francais", style: Theme.of(context).textTheme.headlineSmall),

                        // - - - - - - - - - - - - - - - - - - CHECKBOX - - - - - - - - - - - - - - - - - -  //
                        Checkbox(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                            value: currentState.frenchLang,
                            onChanged: (value) async {
                              if (!currentState.frenchLang!) {
                                langSelected = CustomLocale.FR;
                                localization.translate(CustomLocale.FR);
                                emit(currentState.copyWith(
                                    frenchLang: true,
                                    arabicLang: false,
                                    englishLang: false));
                                callBack.call();
                              }
                            }),
                      ]),
                  const Divider(color: CustomColors.GRAY_LIGHT),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // - - - - - - - - - - - - - - - - - - IMAGE - - - - - - - - - - - - - - - - - -  //
                        ClipRRect(
                            borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                            child: Image.asset(CustomImageStrings.FLAG_ENGLAND,
                              height: 30,
                              width: 40,
                              fit: BoxFit.cover,
                            )),

                        // - - - - - - - - - - - - - - - - - - TEXT - - - - - - - - - - - - - - - - - -  //
                        Text("English", style: Theme.of(context).textTheme.headlineSmall),

                        // - - - - - - - - - - - - - - - - - - CHECKBOX - - - - - - - - - - - - - - - - - -  //
                        Checkbox(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                            value: currentState.englishLang,
                            onChanged: (value) async {
                              if (!currentState.englishLang!) {
                                langSelected = CustomLocale.EN;
                                localization.translate(CustomLocale.EN);
                                emit(currentState.copyWith(
                                    englishLang: true,
                                    arabicLang: false,
                                    frenchLang: false));
                                callBack.call();
                              }
                            }),
                      ]),
                ],
              ),
            ),
          );
        });

    if (langSelected == "") return;
    await LocalStorage.upsert(key: "LANGUAGE", value: langSelected, storage: storage);
  }

  // - - - - - - - - - - - - - - - - - - ON NAVIGATE TO PRIVACY AND SECURITY - - - - - - - - - - - - - - - - - -  //
  //void onNavigateToPrivacyAndSecurity() async{
    //await launchUrl(Uri.parse(CustomTextStrings.TERMS_LINK), mode: LaunchMode.inAppWebView);
  //}

  // - - - - - - - - - - - - - - - - - - ON NAVIGATE TO HELP AND SUPPORT - - - - - - - - - - - - - - - - - -  //
  void onNavigateToHelpAndSupport() async{
    await launchUrl(Uri.parse(CustomTextStrings.TERMS_LINK), mode: LaunchMode.inAppWebView);
  }

  // - - - - - - - - - - - - - - - - - - ON NAVIGATE TO ABOUT - - - - - - - - - - - - - - - - - -  //
  void onNavigateToAbout({ required BuildContext context }) async{
    //await launchUrl(Uri.parse(CustomTextStrings.TERMS_LINK), mode: LaunchMode.inAppWebView);
     context.pushNamed(CustomRouter.FAQ);
  }

  // - - - - - - - - - - - - - - - - - - ON SIGN OUT - - - - - - - - - - - - - - - - - -  //
  void signOut({required BuildContext context}) async{
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: SizedBox(
              width: double.infinity,
              height: 150,
              child: Column(
                children: [
                  CustomElevatedButton(
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.call_calling),
                          Text("  Sign Out"),
                        ],
                      ),
                      onClick: () async{
                        await authRepository.signOut();
                        await LocalStorage.upsert(key: "INIT_LOCATION", value: "LOGIN", storage: storage);
                        if(!context.mounted) return;
                        context.pushReplacementNamed(CustomRouter.LOGIN);
                        context.pop();
                      }),
                  CustomElevatedButton(
                      onClick: context.pop,
                      backgroundColor: CustomColors.GRAY_LIGHT,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.close_square),
                          Text("  Close"),
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }
}

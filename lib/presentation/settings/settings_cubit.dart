import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/domain/entities/user_entity.dart';
import 'package:berkania/domain/repositories/auth_repository.dart';
import 'package:berkania/domain/repositories/user_repository.dart';
import 'package:berkania/domain/repositories/vendor_repository.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/presentation/widgets/custom_text_field.dart';
import 'package:berkania/utils/constants/custom_txt_strings.dart';
import 'package:berkania/utils/device/device_utility.dart';
import 'package:berkania/utils/helpers/network.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:permission_handler/permission_handler.dart';
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
  final Connectivity connectivity;
  final UserRepository userRepository;
  final AuthRepository authRepository;
  final VendorRepository vendorRepository;
  final BuildContext context;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR - - - - - - - - - - - - - - - - - -  //
  SettingsCubit({ required this.context, required this.storage, required this.connectivity, required this.userRepository, required this.vendorRepository, required this.authRepository }) : super(SettingsMainState(
    arabicLang: false,
    englishLang: false,
    frenchLang: false,
    vendorOnlineOffline: false,
    updateImageProfilePath: "",
    firstNameHint: "",
    lastNameHint: "",
    phoneHint: "",
    dialCodeHint: "",
    isoCodeHint: "",
  )){init(context: context);}

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  void init({ required BuildContext context }) async {

    final currentState = state as SettingsMainState;

    await Future.delayed(const Duration(milliseconds: 200));

    emit(SettingsLoadingState());

    await Future.delayed(const Duration(milliseconds: 200));

    uid = await LocalStorage.read(key: "UID", storage: storage);
    lang = await LocalStorage.read(key: "LANGUAGE", storage: storage) ?? CustomLocale.FR;

    if(uid == null) {
      await LocalStorage.upsert(key: "INIT_LOCATION", value: "LOGIN", storage: storage);
      context.pushReplacementNamed(CustomRouter.LOGIN);
      return;
    }

    final bool isVendor = await vendorRepository.existVendor(vendorId: uid!);
    if(isVendor) {
      _user = null;
      _vendor = await vendorRepository.getVendorById(vendorId: uid!);
    }
    else {
      _vendor = null;
      _user = await userRepository.getUserInfo(id: uid!);
    }

    emit(currentState.copyWith(
      frenchLang: lang == CustomLocale.FR ? true : false,
      arabicLang: lang == CustomLocale.AR ? true : false,
      englishLang: lang == CustomLocale.EN ? true : false,
      updateImageProfilePath: _user == null ? _vendor?.avatar : _user?.avatar ,
      isVendor: isVendor,
      vendorOnlineOffline: _vendor?.isOnline ?? false,
      firstNameHint: _user == null ? _vendor?.firstName : _user?.firstName,
      lastNameHint: _user == null ? _vendor?.lastName : _user?.lastName,
      phoneHint: _user == null ? _vendor?.phoneNumber : _user?.phoneNumber,
      dialCodeHint: _user == null ? _vendor?.dialCode : _user?.dialCode,
      isoCodeHint: _user == null ? _vendor?.isoCode : _user?.isoCode,
    ));

  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE IMAGE PROFILE - - - - - - - - - - - - - - - - - -  //
  void onUpdateImageProfile({required BuildContext context}) async {

    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }

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

                          final status = await Permission.storage.status;

                          if(status.isDenied){
                            await Permission.storage.request();
                            return ;
                          }
                          if(status.isPermanentlyDenied){
                            Geolocator.openAppSettings();
                            return ;
                          }

                          if(uid == null) return;

                          final currentState = state as SettingsMainState;

                          final img = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
                          if (img == null && context.mounted) {
                            CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_ERROR_IMAGE_PROFILE_SELECTED_SUB_TITLE.getString(context), type: ContentType.warning);
                            return;
                          }

                          final isUserExist = await userRepository.existUser(userId: uid!);
                          final isVendorExist = await vendorRepository.existVendor(vendorId: uid!);
                          if (isUserExist && isVendorExist) {
                            final String newImageLink = await userRepository.updateUserImage(userId: uid!, newImage: img!.path);
                            await userRepository.updateUserAvatar(userId: uid!, newAvatar: newImageLink);
                            await vendorRepository.updateVendorAvatar(vendorId: uid!, newAvatar: newImageLink);
                            emit(currentState.copyWith(updateImageProfilePath: newImageLink));
                            context.mounted ? CustomSnackBar.show(context: context, title: CustomLocale.SUCCESS_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_IMAGE_PROFILE_UPDATED_SUCCESSFULLY.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
                            return;
                          }

                          if (isUserExist) {
                            final String newImageLink = await userRepository.updateUserImage(userId: uid!, newImage: img!.path);
                            await userRepository.updateUserAvatar(userId: uid!, newAvatar: newImageLink);
                            emit(currentState.copyWith(updateImageProfilePath: newImageLink));
                            context.mounted ? CustomSnackBar.show(context: context, title: CustomLocale.SUCCESS_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_IMAGE_PROFILE_UPDATED_SUCCESSFULLY.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
                            return;
                          }

                          if (isVendorExist) {
                            try{ await vendorRepository.deleteVendorImage(imgName: uid!); }
                            catch(_){}
                            final String newImageLink = await vendorRepository.saveVendorImage(imgName: uid!, imgPath: img!.path);
                            await vendorRepository.updateVendorAvatar(vendorId: uid!, newAvatar: newImageLink);
                            emit(currentState.copyWith(updateImageProfilePath: newImageLink));
                            context.mounted ? CustomSnackBar.show(context: context, title: CustomLocale.SUCCESS_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_IMAGE_PROFILE_UPDATED_SUCCESSFULLY.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
                            return;
                          }

                          context.mounted ? context.pop() : null;
                          context.mounted ? CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_ERROR_UPDATE_IMAGE_PROFILE_SUB_TITLE.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;

                        } catch (_) {
                          context.mounted ? CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_ERROR_UPDATE_IMAGE_PROFILE_SUB_TITLE.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
                        }
                      }),

                  CustomElevatedButton(
                      onClick: context.pop,
                      backgroundColor: CustomColors.GRAY_LIGHT,
                      child: Text(CustomLocale.SETTINGS_UPDATE_IMAGE_BUTTON_DISMISS_TITLE.getString(context.mounted ? context : context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE))),

                ],
              ),
            ),
          );
        });
  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE FULL NAME - - - - - - - - - - - - - - - - - -  //
  void onUpdateFullName({required BuildContext context}) async {

    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }

    final GlobalKey<FormState> formState = GlobalKey<FormState>();

    final currentState = state as SettingsMainState;
    final TextEditingController firstName = TextEditingController(text: currentState.firstNameHint);
    final TextEditingController lastName = TextEditingController(text: currentState.lastNameHint);

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
                            hint: firstName.text,
                            validator: (value) => Validator.validateCustomField(value, CustomLocale.VALIDATOR_CUSTOM_FIELD_ERROR1.getString(context)),
                            controller: firstName),

                        // - - - - - - - - - - - - - - - - - - LAST NAME - - - - - - - - - - - - - - - - - -  //
                        CustomTextField(
                            leadingIcon: Iconsax.user,
                            hint: lastName.text,
                            validator: (value) => Validator.validateCustomField(CustomLocale.REGISTER_LAST_NAME_VALIDATOR.getString(context), CustomLocale.VALIDATOR_CUSTOM_FIELD_ERROR1.getString(context)),
                            controller: lastName),

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
                                final isVendorExist = await vendorRepository.existVendor(vendorId: uid!);
                                if (isUserExist && isVendorExist) {
                                  await userRepository.updateUserFullName(userId: uid!, newFirstName: firstName.text, newLastName: lastName.text);
                                  await vendorRepository.updateVendorFullName(vendorId: uid!, newFirstName: firstName.text, newLastName: lastName.text);
                                  context.pop();
                                  emit(currentState.copyWith(firstNameHint: firstName.text, lastNameHint: lastName.text));
                                  CustomSnackBar.show(context: context.mounted ? context : context, title: CustomLocale.SUCCESS_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_FULL_NAME_UPDATED_SUCCESSFULLY_SUB_TITLE.getString(context), type: ContentType.success);
                                  return;
                                }

                                if (isUserExist) {
                                  await userRepository.updateUserFullName(userId: uid!, newFirstName: firstName.text, newLastName: lastName.text);
                                  context.pop();
                                  emit(currentState.copyWith(firstNameHint: firstName.text, lastNameHint: lastName.text));
                                  CustomSnackBar.show(context: context.mounted ? context : context, title: CustomLocale.SUCCESS_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_FULL_NAME_UPDATED_SUCCESSFULLY_SUB_TITLE.getString(context), type: ContentType.success);
                                  return;
                                }

                                if (isVendorExist) {
                                  await vendorRepository.updateVendorFullName(vendorId: uid!, newFirstName: firstName.text, newLastName: lastName.text);
                                  context.pop();
                                  emit(currentState.copyWith(firstNameHint: firstName.text, lastNameHint: lastName.text));
                                  CustomSnackBar.show(context: context.mounted ? context : context, title: CustomLocale.SUCCESS_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_FULL_NAME_UPDATED_SUCCESSFULLY_SUB_TITLE.getString(context), type: ContentType.success);
                                  return;
                                }
                                context.mounted ? context.pop(): null;
                                context.mounted ? CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_ERROR_UPDATE_FULL_NAME_SUB_TITLE.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;

                              } catch (_) {
                                context.mounted ? CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_ERROR_UPDATE_FULL_NAME_SUB_TITLE.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
                              }
                            },
                            child: Text(CustomLocale.SETTINGS_BUTTON_UPDATE_TITLE.getString(context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE)))

                      ],
                    ),
                  )));
        });
  }

  // - - - - - - - - - - - - - - - - - - ON UPDATE PHONE - - - - - - - - - - - - - - - - - -  //
  void onUpdatePhone({required BuildContext context}) async {

    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }

    final GlobalKey<FormState> formState = GlobalKey<FormState>();

    final currentState = state as SettingsMainState;
    final bool isArabic = localization.currentLocale?.languageCode == CustomLocale.AR;
    final TextEditingController phone = TextEditingController(text: currentState.phoneHint);

    PhoneNumber phoneNumber = PhoneNumber(isoCode: currentState.isoCodeHint, dialCode: currentState.dialCodeHint, phoneNumber: currentState.phoneHint);

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
                          onInputChanged: (PhoneNumber number) {phoneNumber = number;},
                          selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              useBottomSheetSafeArea: true,
                              showFlags: true,
                              trailingSpace: false
                          ),
                          inputDecoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 24, horizontal: isArabic ? 24 : 0 ),
                              fillColor: CustomColors.TRANSPARENT,
                              hintText: CustomLocale.BE_VENDOR_PHONE.getString(context),
                              prefixIcon: const Icon(Iconsax.call, color: CustomColors.GRAY_LIGHT),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: DeviceUtility.isDark(context) ? CustomColors.WHITE : CustomColors.BLACK ))),
                          selectorTextStyle: Theme.of(context).textTheme.bodyLarge,
                          textFieldController:  phone,
                          locale: isArabic ? "ar": "fr",
                          hintText: CustomLocale.BE_VENDOR_PHONE.getString(context),
                          initialValue: phoneNumber,
                          formatInput: false,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) => Validator.validateMobilePhone(value, CustomLocale.VALIDATOR_MOBILE_NUMBER_ERROR1.getString(context), CustomLocale.VALIDATOR_MOBILE_NUMBER_ERROR2.getString(context)),
                          spaceBetweenSelectorAndTextField: 2.0,
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
                                final isVendorExist = await vendorRepository.existVendor(vendorId: uid!);

                                if (isUserExist && isVendorExist) {
                                  await userRepository.updateUserPhone(userId: uid!, newPhone: phone.text, dialCode: phoneNumber.dialCode ?? "+212", isoCode: phoneNumber.isoCode ?? "MA");
                                  await vendorRepository.updateVendorPhone(vendorId: uid!, newPhone: phone.text, dialCode: phoneNumber.dialCode ?? "+212", isoCode: phoneNumber.isoCode ?? "MA");
                                  context.pop();
                                  emit(currentState.copyWith(phoneHint: phone.text, dialCodeHint: phoneNumber.dialCode ?? "+212", isoCodeHint: phoneNumber.isoCode ?? "MA" ));
                                  CustomSnackBar.show(context: context.mounted ? context : context, title: CustomLocale.SUCCESS_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_PHONE_UPDATED_SUCCESSFULLY_SUB_TITLE.getString(context), type: ContentType.success);
                                  return;
                                }

                                if (isUserExist) {
                                  await userRepository.updateUserPhone(userId: uid!, newPhone: phone.text, dialCode: phoneNumber.dialCode ?? "+212", isoCode: phoneNumber.isoCode ?? "MA");
                                  if(!context.mounted) return;
                                  context.mounted ? context.pop() : null;
                                  emit(currentState.copyWith(phoneHint: phone.text, dialCodeHint: phoneNumber.dialCode ?? "+212", isoCodeHint: phoneNumber.isoCode ?? "MA" ));
                                  CustomSnackBar.show(context: context.mounted ? context : context, title: CustomLocale.SUCCESS_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_PHONE_UPDATED_SUCCESSFULLY_SUB_TITLE.getString(context), type: ContentType.success);
                                  return;
                                }

                                if (isVendorExist) {
                                  await vendorRepository.updateVendorPhone(vendorId: uid!, newPhone: phone.text, dialCode: phoneNumber.dialCode ?? "+212", isoCode: phoneNumber.isoCode ?? "MA");
                                  context.pop();
                                  emit(currentState.copyWith(phoneHint: phone.text, dialCodeHint: phoneNumber.dialCode ?? "+212", isoCodeHint: phoneNumber.isoCode ?? "MA" ));
                                  CustomSnackBar.show(context: context.mounted ? context : context, title: CustomLocale.SUCCESS_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_PHONE_UPDATED_SUCCESSFULLY_SUB_TITLE.getString(context), type: ContentType.success);
                                  return;
                                }

                                context.pop();
                                CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_ERROR_UPDATE_PHONE_SUB_TITLE.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT);

                              } catch (e) {
                                context.mounted ? CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_ERROR_UPDATE_PHONE_SUB_TITLE.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
                              }
                            },
                            child: Text(CustomLocale.SETTINGS_BUTTON_UPDATE_TITLE.getString(context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE)))
                      ],
                    ),
                  )));
        });
  }

  // - - - - - - - - - - - - - - - - - - VENDOR => (ONLINE / OFFLINE) - - - - - - - - - - - - - - - - - -  //
  void updateVendorStatus(bool value, BuildContext context) async{

    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }

    try{

      if (uid == null) return;

      final currentState = state as SettingsMainState;
      emit(SettingsLoadingState());

      if(value) {
        final isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
        final permission = await Geolocator.checkPermission();
        if(!isLocationServiceEnabled || permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
          openAppSettings();
          return;
        }
        final Position currentPosition = await Geolocator.getCurrentPosition();
        await vendorRepository.online(vendorId: uid!, lat: currentPosition.latitude, lng: currentPosition.longitude);
        context.mounted ? CustomSnackBar.show(context: context, title: CustomLocale.SUCCESS_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_VENDOR_STATUS_UPDATED_SUCCESSFULLY_SUB_TITLE.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
      }else{
        await vendorRepository.offline(vendorId: uid!);
        context.mounted ? CustomSnackBar.show(context: context, title: CustomLocale.SUCCESS_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_VENDOR_STATUS_UPDATED_SUCCESSFULLY_SUB_TITLE.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
      }
      emit(currentState.copyWith(vendorOnlineOffline: value));
    }catch(_) { context.mounted ? CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.SETTINGS_ERROR_UPDATE_VENDOR_STATUS_SUB_TITLE.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT) : null; }
  }

  // - - - - - - - - - - - - - - - - - - VENDOR => ON NAVIGATE TO NEW ORDER SCREEN - - - - - - - - - - - - - - - - - -  //
  void onNavigateToNewOrderScreen({ required BuildContext context }) async{
    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }
    context.pushNamed(CustomRouter.VENDOR_NEW_ORDER);
  }

  // - - - - - - - - - - - - - - - - - - VENDOR => ON NAVIGATE TO ORDERS SCREEN - - - - - - - - - - - - - - - - - -  //
  void onNavigateToOrdersScreen({ required BuildContext context }) async{
    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }
    context.pushNamed(CustomRouter.VENDOR_ORDERS);
  }

  // - - - - - - - - - - - - - - - - - - BECOME VENDOR - - - - - - - - - - - - - - - - - -  //
  void onNavigateToBeVendorScreen({ required BuildContext context }) async{
    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }
    context.pushNamed(CustomRouter.BE_VENDOR);
  }

  // - - - - - - - - - - - - - - - - - - SHOW DIALOG LANGUAGES - - - - - - - - - - - - - - - - - -  //
  void onUpdateLanguage({required BuildContext context, required Function callBack}) async {

    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }

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
    await LocalStorage.upsert(key: "INIT_LOCATION", value: "INDEX", storage: storage);
  }

  // - - - - - - - - - - - - - - - - - - ON NAVIGATE TO HELP AND SUPPORT - - - - - - - - - - - - - - - - - -  //
  void onNavigateToHelpAndSupport({ required BuildContext context }) async{

    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }

    await launchUrl(Uri.parse(CustomTextStrings.TERMS_LINK), mode: LaunchMode.inAppWebView);
  }

  // - - - - - - - - - - - - - - - - - - ON NAVIGATE TO ABOUT - - - - - - - - - - - - - - - - - -  //
  void onNavigateToAbout({ required BuildContext context }) async{

    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }

     context.pushNamed(CustomRouter.FAQ);
  }

  // - - - - - - - - - - - - - - - - - - ON SIGN OUT - - - - - - - - - - - - - - - - - -  //
  void signOut({required BuildContext context}) async{

    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            content: SizedBox(
              width: double.infinity,
              height: 150,
              child: Column(
                children: [
                  CustomElevatedButton(
                      child: Text(CustomLocale.SETTINGS_SIGN_OUT_TITLE.getString(context)),
                      onClick: () async{
                        await authRepository.signOut();
                        await LocalStorage.upsert(key: "INIT_LOCATION", value: "LOGIN", storage: storage);
                        context.pushReplacementNamed(CustomRouter.LOGIN);
                      }),
                  CustomElevatedButton(
                      onClick: context.pop,
                      backgroundColor: CustomColors.GRAY_LIGHT,
                      child: Text(CustomLocale.SETTINGS_UPDATE_IMAGE_BUTTON_DISMISS_TITLE.getString(context))),
                ],
              ),
            ),
          );
        });
  }

}

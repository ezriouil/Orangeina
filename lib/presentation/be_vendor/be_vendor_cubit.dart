import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/domain/entities/notification_entity.dart';
import 'package:berkania/domain/entities/vendor_entity.dart';
import 'package:berkania/domain/repositories/user_repository.dart';
import 'package:berkania/presentation/notification/notification_cubit.dart';
import 'package:berkania/utils/device/device_utility.dart';
import 'package:berkania/utils/local/storage/local_storage.dart';
import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../domain/repositories/vendor_repository.dart';
import '../widgets/custom_snackbars.dart';

part 'be_vendor_state.dart';

class BeVendorCubit extends Cubit<BeVendorState> {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  final ImagePicker _imagePicker = ImagePicker();
  static PhoneNumber phoneNumber = PhoneNumber(isoCode: "MA", dialCode: "+212");
  String? uid;

  final BuildContext context;
  final VendorRepository vendorRepository;
  final NotificationRepository notificationRepository;
  final UserRepository userRepository;
  final GetStorage storage;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR - - - - - - - - - - - - - - - - - -  //
  BeVendorCubit({ required this.context,required this.notificationRepository, required this.vendorRepository, required this.userRepository, required this.storage }) : super(BeVendorLoadingState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  void init() async{

    uid = await LocalStorage.read(key: "UID", storage: storage);
    if(uid == null) {
      await LocalStorage.upsert(key: "INIT_LOCATION", value: "LOGIN", storage: storage);
      context.pushReplacementNamed(CustomRouter.LOGIN);
      return;
    }
    final bool inProcess = await vendorRepository.isProcessingVendorInfo(uid: uid!);

    if(inProcess){
      emit(BeVendorSuccessState());
      return;
    }
    final getUserInfo = await userRepository.getUserInfo(id: uid!);
    emit(BeVendorMainState(
      scrollPhysics: const ScrollPhysics(),
      currentStep: 0,
      gender: "Homme",
      carType: "Voituer",
      shopThumbnail: "",
      cinFrontImage: "",
      cinBackImage: "",
      carAssuranceImage: "",
      carRegistrationImage: "",
      cinController: TextEditingController(),
      phoneController: TextEditingController(),
      ageController: TextEditingController(),
      carAssuranceController: TextEditingController(),
      carRegistrationController: TextEditingController(),
      personalInfoFormState: GlobalKey<FormState>(),
        carInfoFormState: GlobalKey<FormState>(),
      userEntity: getUserInfo
    ));

  }

   void onInputChanged(PhoneNumber innerPhoneNumber){ phoneNumber = innerPhoneNumber; }

  bool validateFirstStep(){
    final BeVendorMainState currentState = state as BeVendorMainState;
    if(!currentState.personalInfoFormState!.currentState!.validate()) {
      return false;
    }
    return true;
  }

  bool validateSecondStep({ required BuildContext context }){
    final BeVendorMainState currentState = state as BeVendorMainState;
    if(!currentState.carInfoFormState!.currentState!.validate()) {
      return false;
    }
    if(currentState.shopThumbnail == "") {
      CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.BE_VENDOR_CAR_THUMBNAIL_TITLE.getString(context) , type: ContentType.warning);
      return false;
    }
    return true;
  }

  bool validateThirdStep({ required BuildContext context }){
    final BeVendorMainState currentState = state as BeVendorMainState;
    if(currentState.cinFrontImage == "") {
      CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.BE_VENDOR_CIN_FRONT_THUMBNAIL_TITLE .getString(context) , type: ContentType.warning);
      return false;
    }
    if(currentState.cinBackImage == "") {
      CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.BE_VENDOR_CIN_BACK_THUMBNAIL_TITLE .getString(context) , type: ContentType.warning);
      return false;
    }
    if(currentState.carAssuranceImage == "") {
      CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.BE_VENDOR_CAR_ASSURANCE_NUMBER_THUMBNAIL_TITLE .getString(context) , type: ContentType.warning);
      return false;
    }
    if(currentState.carRegistrationImage == "") {
      CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.BE_VENDOR_CAR_REGISTRATION_NUMBER_THUMBNAIL_TITLE .getString(context) , type: ContentType.warning);
       return false;
    }
    return true;
  }

  // - - - - - - - - - - - - - - - - - - NEXT STEP - - - - - - - - - - - - - - - - - -  //
  void continued({ required BuildContext context }) async{

    final BeVendorMainState currentState = state as BeVendorMainState;

    try{



      final isFirstStepValid = validateFirstStep();
      if(!isFirstStepValid) return;
      emit(currentState.copyWith(currentStep: 1));

      final isSecondStepValid = validateSecondStep(context: context);
      if(!isSecondStepValid) return;
      emit(currentState.copyWith(currentStep: 2));

      final isThirdStepValid = validateThirdStep(context: context);
      if(!isThirdStepValid) return;

      emit(BeVendorLoadingState());

      final date = DateTime.now();
      final paperImages = [
        await vendorRepository.saveVendorPaperImages(imgName: "${uid}_cin_front", imgPath: currentState.cinFrontImage!),
        await vendorRepository.saveVendorPaperImages(imgName: "${uid}_cin_back", imgPath: currentState.cinBackImage!),
        await vendorRepository.saveVendorPaperImages(imgName: "${uid}_car_assurance_image", imgPath: currentState.carAssuranceImage!),
        await vendorRepository.saveVendorPaperImages(imgName: "${uid}_car_registration_image", imgPath: currentState.carRegistrationImage!)
      ];

      final String shopThumbnailUri = await vendorRepository.saveVendorShopThumbnail(imgName: uid!, imgPath: currentState.shopThumbnail!);

      // ADD NEW VENDOR
      final VendorEntity vendorEntity = VendorEntity(
          id: uid,
          firstName: currentState.userEntity?.firstName,
          lastName: currentState.userEntity?.lastName,
          cin: currentState.cinController?.text.trim(),
          avatar: shopThumbnailUri,
          email: currentState.userEntity?.email,
          phoneNumber: currentState.phoneController!.text.trim(),
          dialCode: phoneNumber.dialCode ?? "+212",
          isoCode: phoneNumber.isoCode ?? "MA",
          gender: currentState.gender,
          shopThumbnail: shopThumbnailUri,
          carAssurance: currentState.carAssuranceController?.text.trim(),
          carRegistration: currentState.carRegistrationController?.text.trim(),
          carType: currentState.carType,
          isOnline: false,
          visible: false,
          averageRating: 0.0,
          birthdayYear:int.parse( currentState.ageController!.text.trim()),
          totalOrders: 0,
          shopLat: 0.0,
          shopLng: 0.0,
          uploadedPaperImagesAt:  "${date.day}/${date.month}/${date.year}",
          paperImages: paperImages,
          createAt: "${date.day}/${date.month}/${date.year}"
      );

      await vendorRepository.insertNewVendor(vendorEntity : vendorEntity);

      if(currentState.currentStep! >= 2) {
        final DateTime dateTime = DateTime.now();
        final NotificationEntity notificationEntity = NotificationEntity(
          userId: uid,
          type: "INFORMATION",
          title: "Postuler Pour Un Emploi",
          body: "Merci de votre intérêt à faire partie de nos vendeurs, nous traiterons vos données puis nous vous informerons dans les prochaines 48h.",
          createAt: "${dateTime.day}/${dateTime.month}/${dateTime.year}",
        );
        await notificationRepository.sendNotification(notificationEntity: notificationEntity);
        emit(BeVendorSuccessState());
        context.read<NotificationCubit>().init(context: context);
        return;
      }
      final updateCurrentStep = currentState.currentStep! + 1;
      emit(currentState.copyWith(currentStep: updateCurrentStep));

    }catch(_){
      emit(currentState);
      CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.BE_VENDOR_ERROR_SUB_TITLE.getString(context) , type: ContentType.warning);
    }
  }

  // - - - - - - - - - - - - - - - - - - STEP BACK - - - - - - - - - - - - - - - - - -  //
  void cancel(){
    final BeVendorMainState currentState = state as BeVendorMainState;
    if(currentState.currentStep! < 0) return;

    if(currentState.currentStep == 0) return;

    if(currentState.currentStep == 1){
      currentState.carRegistrationController?.clear();
      currentState.carAssuranceController?.clear();
      emit(currentState.copyWith(
          shopThumbnail: "", currentStep: 0,
          carAssuranceImage: "",
          carRegistrationImage: "",
          cinFrontImage: "",
          cinBackImage: ""
      ));
      return;
    }

    if(currentState.currentStep == 2){
      emit(currentState.copyWith(
          currentStep: 1,
          carAssuranceImage: "",
          carRegistrationImage: "",
          cinFrontImage: "",
          cinBackImage: ""
      ));
      return;
    }

  }

  // - - - - - - - - - - - - - - - - - - UPDATE GENDER RADIO BUTTON - - - - - - - - - - - - - - - - - -  //
  void onChangeGender(String? value){
    final BeVendorMainState currentState = state as BeVendorMainState;
    emit(currentState.copyWith(gender: value));
  }

  // - - - - - - - - - - - - - - - - - - UPDATE CAR TYPE RADIO BUTTON - - - - - - - - - - - - - - - - - -  //
  void onChangeCarType(String? value){
    final BeVendorMainState currentState = state as BeVendorMainState;
    emit(currentState.copyWith(carType: value));
  }

  // - - - - - - - - - - - - - - - - - - PICK IMAGE OF VEHICLE FROM GALLERY- - - - - - - - - - - - - - - - - -  //
  void onPickCarImage({ required BuildContext context }) async{
    final BeVendorMainState currentState = state as BeVendorMainState;
   try{

     if(DeviceUtility.isAndroid()){
       final storagePermission = await Permission.storage.status;
       final photosPermission =  await Permission.photos.status;

       DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
       AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

       if (androidInfo.version.sdkInt >= 33) {

         bool? grantedPhotos;

         if(photosPermission.isGranted){ grantedPhotos = true; }
         if(photosPermission.isDenied){
           final isOk = await Permission.photos.request();
           if(isOk.isGranted) { grantedPhotos = true; }
           else { grantedPhotos = false; }
         }
         if(photosPermission.isPermanentlyDenied || storagePermission.isPermanentlyDenied){
           Geolocator.openAppSettings();
           return ;
         }

         if(!grantedPhotos! ) return;

         final img = await _imagePicker.pickImage(source: ImageSource.gallery);
         if(img == null) return;
         await Future.delayed(const Duration(milliseconds: 300));
         emit(currentState.copyWith(shopThumbnail: img.path));

       }
       else {

         bool? grantedStorage;

         if(storagePermission.isGranted){
           grantedStorage = true;
         }
         if(storagePermission.isDenied){
           final isOk =  await Permission.storage.request();
           if(isOk.isGranted) { grantedStorage = true; }
           else { grantedStorage = false; }
           return ;
         }
         if(storagePermission.isPermanentlyDenied){
           Geolocator.openAppSettings();
           return ;
         }
         if(!grantedStorage!) return;

         final img = await _imagePicker.pickImage(source: ImageSource.gallery);
         if(img == null) return;
         await Future.delayed(const Duration(milliseconds: 300));
         emit(currentState.copyWith(shopThumbnail: img.path));

       }
     }
     if(DeviceUtility.isIos()){
       final storagePermission = await Permission.storage.status;
       bool? grantedStorage;

       if(storagePermission.isGranted){
         grantedStorage = true;
       }
       if(storagePermission.isDenied){
         final isOk =  await Permission.storage.request();
         if(isOk.isGranted) { grantedStorage = true; }
         else { grantedStorage = false; }
         return ;
       }
       if(storagePermission.isPermanentlyDenied){
         Geolocator.openAppSettings();
         return ;
       }
       if(!grantedStorage!) return;

       final img = await _imagePicker.pickImage(source: ImageSource.gallery);
       if(img == null) return;
       await Future.delayed(const Duration(milliseconds: 300));
       emit(currentState.copyWith(shopThumbnail: img.path));
     }

   }catch(_){
     emit(currentState);
     CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.BE_VENDOR_CAR_THUMBNAIL_TITLE .getString(context) , type: ContentType.warning); }
  }

  // - - - - - - - - - - - - - - - - - - PICK FRONT IMAGE OF CIN FROM GALLERY- - - - - - - - - - - - - - - - - -  //
  void onPickCinFrontImage({ required BuildContext context }) async{
    final BeVendorMainState currentState = state as BeVendorMainState;
    try{
      final img = await _imagePicker.pickImage(source: ImageSource.gallery);
      if(img == null) return;

      await Future.delayed(const Duration(milliseconds: 300));
      emit(currentState.copyWith(cinFrontImage: img.path));

    }catch(_){
      emit(currentState);
      CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.BE_VENDOR_CIN_FRONT_THUMBNAIL_TITLE .getString(context) , type: ContentType.warning); }
  }

  // - - - - - - - - - - - - - - - - - - PICK IMAGE BACK OF CIN FROM GALLERY- - - - - - - - - - - - - - - - - -  //
  void onPickCinBackImage({ required BuildContext context }) async{
    final BeVendorMainState currentState = state as BeVendorMainState;
    try{
      final img = await _imagePicker.pickImage(source: ImageSource.gallery);
      if(img == null) return;

      await Future.delayed(const Duration(milliseconds: 300));
      emit(currentState.copyWith(cinBackImage: img.path));

    }catch(_){
      emit(currentState);
      CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.BE_VENDOR_CIN_BACK_THUMBNAIL_TITLE .getString(context) , type: ContentType.warning); }
  }

  // - - - - - - - - - - - - - - - - - - PICK IMAGE OF CAR REGISTRATION FROM GALLERY- - - - - - - - - - - - - - - - - -  //
  void onPickRegistrationCarImage({ required BuildContext context }) async{
    final BeVendorMainState currentState = state as BeVendorMainState;
    try{
      final img = await _imagePicker.pickImage(source: ImageSource.gallery);
      if(img == null) return;

      await Future.delayed(const Duration(milliseconds: 300));
      emit(currentState.copyWith(carRegistrationImage: img.path));

    }
    catch(_){
      emit(currentState);
      CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.BE_VENDOR_CAR_REGISTRATION_NUMBER_THUMBNAIL_TITLE .getString(context) , type: ContentType.warning); }
  }

  // - - - - - - - - - - - - - - - - - - PICK IMAGE OF CAR ASSURANCE FROM GALLERY- - - - - - - - - - - - - - - - - -  //
  void onPickAssuranceCarImage({ required BuildContext context }) async{
    final BeVendorMainState currentState = state as BeVendorMainState;
    try{
      final img = await _imagePicker.pickImage(source: ImageSource.gallery);
      if(img == null) return;

      await Future.delayed(const Duration(milliseconds: 300));
      emit(currentState.copyWith(carAssuranceImage: img.path));

    }
  catch(_){
      emit(currentState);
      CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.BE_VENDOR_CAR_ASSURANCE_NUMBER_THUMBNAIL_TITLE .getString(context) , type: ContentType.warning); }
  }

}

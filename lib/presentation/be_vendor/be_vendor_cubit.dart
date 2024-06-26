import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/domain/entities/notification_entity.dart';
import 'package:berkania/domain/entities/vendor_entity.dart';
import 'package:berkania/domain/repositories/user_repository.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/local/storage/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/notification_repository.dart';
import '../../domain/repositories/vendor_repository.dart';
import '../widgets/custom_snackbars.dart';

part 'be_vendor_state.dart';

class BeVendorCubit extends Cubit<BeVendorState> {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  final ImagePicker _imagePicker = ImagePicker();
  String? uid;

  final VendorRepository vendorRepository;
  final NotificationRepository notificationRepository;
  final UserRepository userRepository;
  final GetStorage storage;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR - - - - - - - - - - - - - - - - - -  //
  BeVendorCubit({ required this.notificationRepository, required this.vendorRepository, required this.userRepository, required this.storage }) : super(BeVendorMainState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  void init() async{
    emit(BeVendorMainState(
        scrollPhysics: const ScrollPhysics(),
        currentStep: 0,
        gender: "Man",
        carType: "Car",
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
      userEntity: UserEntity(),
      personalInfoFormState: GlobalKey<FormState>(),
      carInfoFormState: GlobalKey<FormState>()
    ));

    final currentState = state as BeVendorMainState;
    uid = await LocalStorage.read(key: "UID", storage: storage);
    final getUserInfo = await userRepository.getUserInfo(id: uid!);
    if(getUserInfo == null) return;
    emit(currentState.copyWith(userEntity: getUserInfo));
  }

  // - - - - - - - - - - - - - - - - - - NEXT STEP - - - - - - - - - - - - - - - - - -  //
  void continued({ required BuildContext context }) async{
    try{

      final BeVendorMainState currentState = state as BeVendorMainState;

      // CHECK THE FORM
      if(!currentState.personalInfoFormState!.currentState!.validate()) return;
      emit(currentState.copyWith(currentStep: 1));

      if((state as BeVendorMainState).currentStep == 1){
        if(!currentState.carInfoFormState!.currentState!.validate()) return;
        if(currentState.shopThumbnail == "") {
          CustomSnackBar.show(context: context, title: "No Image Selected", subTitle: "Try Again", type: ContentType.warning);
          return;
        }
        emit(currentState.copyWith(currentStep: 2));
      }

      if((state as BeVendorMainState).currentStep == 2){
        if(currentState.cinFrontImage == "") {
          CustomSnackBar.show(context: context, title: "Please Select Cin Image", subTitle: "Try Again", type: ContentType.warning);
          return;
        }
        if(currentState.cinBackImage == "") {
          CustomSnackBar.show(context: context, title: "Please Select Cin Image", subTitle: "Try Again", type: ContentType.warning);
          return;
        }
        if(currentState.carAssuranceImage == "") {
          CustomSnackBar.show(context: context, title: "Please Select Car Assurance Image", subTitle: "Try Again", type: ContentType.warning);
          return;
        }
        if(currentState.carRegistrationImage == "") {
          CustomSnackBar.show(context: context, title: "Please Select Car Assurance Image", subTitle: "Try Again", type: ContentType.warning);
          return;
        }
      }
      emit(BeVendorLoadingState());

      final date = DateTime.now();
      final paperImages = [
        await vendorRepository.saveVendorPaperImages(imgName: "${uid}_cin_front", imgPath: currentState.cinFrontImage!),
        await vendorRepository.saveVendorPaperImages(imgName: "${uid}_cin_back", imgPath: currentState.cinBackImage!),
        await vendorRepository.saveVendorPaperImages(imgName: "${uid}_car_assurance_image", imgPath: currentState.carAssuranceImage!),
        await vendorRepository.saveVendorPaperImages(imgName: "${uid}_car_registration_image", imgPath: currentState.carRegistrationImage!)
      ];

      final String shopThumbnailUri = await vendorRepository.saveVendorPaperImages(imgName: "${uid}_shop_thumbnail", imgPath: currentState.shopThumbnail!);

      // ADD NEW VENDOR
      final VendorEntity vendorEntity = VendorEntity(
          id: uid,
          firstName: currentState.userEntity?.firstName,
          lastName: currentState.userEntity?.lastName,
          cin: currentState.cinController?.text.trim(),
          avatar: currentState.userEntity?.avatar,
          email: currentState.userEntity?.email,
          phoneNumber: currentState.phoneController!.text.trim(),
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
          title: "Demand Be Seller",
          body: "Thank you for you interesting to be one of our sellers, We will hande your data then we will inform you in the next 48h.",
          createAt: "${dateTime.day}/${dateTime.month}/${dateTime.year}",
        );
        notificationRepository.sendNotification(notificationEntity: notificationEntity);
        emit(BeVendorSuccessState());
        return;
      }
      final updateCurrentStep = currentState.currentStep! + 1;
      emit(currentState.copyWith(currentStep: updateCurrentStep));

    }catch(_){
      context.mounted ? CustomSnackBar.show(context: context, title: "Error 404", subTitle: "Try Next Time", type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
    }
  }

  // - - - - - - - - - - - - - - - - - - STEP BACK - - - - - - - - - - - - - - - - - -  //
  void cancel(){
    final BeVendorMainState currentState = state as BeVendorMainState;
    if(currentState.currentStep! <= 0) return;
    final updateCurrentStep = currentState.currentStep! - 1;

    if(updateCurrentStep == 1){
      currentState.carRegistrationController?.clear();
      currentState.carAssuranceController?.clear();
      emit(currentState.copyWith(
          currentStep: updateCurrentStep
      ));
      return;
    }
    if(updateCurrentStep == 2){
      emit(currentState.copyWith(
          currentStep: updateCurrentStep,
          carAssuranceImage: "",
          carRegistrationImage: "",
          cinFrontImage: "",
          cinBackImage: ""));
      return;
    }
    emit(currentState.copyWith(currentStep: updateCurrentStep));
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
   try{

     final status = await Permission.storage.status;

     if(status.isDenied){
       await Permission.storage.request();
       return ;
     }
     if(status.isPermanentlyDenied){
       Geolocator.openAppSettings();
       return ;
     }

     final img = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
     if(img == null){
       return;
     }
     final BeVendorMainState currentState = state as BeVendorMainState;
     emit(currentState.copyWith(shopThumbnail: img.path));
   }catch(_){ context.mounted ? CustomSnackBar.show(context: context, title: "Error 404", subTitle: "Try Next Time", type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;  }
  }

  // - - - - - - - - - - - - - - - - - - PICK FRONT IMAGE OF CIN FROM GALLERY- - - - - - - - - - - - - - - - - -  //
  void onPickCinFrontImage({ required BuildContext context }) async{
    try{
      final img = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
      if(img == null){
        return;
      }
      final BeVendorMainState currentState = state as BeVendorMainState;
      emit(currentState.copyWith(cinFrontImage: img.path));
    }catch(_){ context.mounted ? CustomSnackBar.show(context: context, title: "Error 404", subTitle: "Try Next Time", type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;  }
  }

  // - - - - - - - - - - - - - - - - - - PICK IMAGE BACK OF CIN FROM GALLERY- - - - - - - - - - - - - - - - - -  //
  void onPickCinBackImage({ required BuildContext context }) async{
    try{
      final img = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
      if(img == null){
        return;
      }
      final BeVendorMainState currentState = state as BeVendorMainState;
      emit(currentState.copyWith(cinBackImage: img.path));
    }catch(_){ context.mounted ? CustomSnackBar.show(context: context, title: "Error 404", subTitle: "Try Next Time", type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;  }
  }

  // - - - - - - - - - - - - - - - - - - PICK IMAGE OF CAR REGISTRATION FROM GALLERY- - - - - - - - - - - - - - - - - -  //
  void onPickRegistrationCarImage({ required BuildContext context }) async{
    try{
      final img = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
      if(img == null){
        return;
      }
      final BeVendorMainState currentState = state as BeVendorMainState;
      emit(currentState.copyWith(carRegistrationImage: img.path));
    }
    catch(_){ context.mounted ? CustomSnackBar.show(context: context, title: "Error 404", subTitle: "Try Next Time", type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;  }
  }

  // - - - - - - - - - - - - - - - - - - PICK IMAGE OF CAR ASSURANCE FROM GALLERY- - - - - - - - - - - - - - - - - -  //
  void onPickAssuranceCarImage({ required BuildContext context }) async{
    try{
      final img = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
      if(img == null){
        return;
      }
      final BeVendorMainState currentState = state as BeVendorMainState;
      emit(currentState.copyWith(carAssuranceImage: img.path));
    }
  catch(_){ context.mounted ? CustomSnackBar.show(context: context, title: "Error 404", subTitle: "Try Next Time", type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;  }
  }

}

import 'package:berkania/domain/entities/vendor_entity.dart';
import 'package:berkania/domain/repositories/user_repository.dart';
import 'package:berkania/utils/local/storage/local_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/vendor_repository.dart';
part 'be_vendor_state.dart';

class BeVendorCubit extends Cubit<BeVendorState> {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  final ImagePicker _imagePicker = ImagePicker();
  String? uid;

  final VendorRepository vendorRepository;
  final UserRepository userRepository;
  final GetStorage storage;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR - - - - - - - - - - - - - - - - - -  //
  BeVendorCubit({ required this.vendorRepository, required this.userRepository, required this.storage }) : super(BeVendorMainState()){ init(); }

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
        birthdayController: TextEditingController(),
        carAssuranceController: TextEditingController(),
        carRegistrationController: TextEditingController(),
      userEntity: UserEntity()
    ));

    final currentState = state as BeVendorMainState;
    uid = await LocalStorage.read(key: "UID", storage: storage);
    final getUserInfo = await userRepository.getUserInfo(id: uid!);
    if(getUserInfo == null) return;
    emit(currentState.copyWith(userEntity: getUserInfo));
  }

  // - - - - - - - - - - - - - - - - - - NEXT STEP - - - - - - - - - - - - - - - - - -  //
  void continued() async{

    final BeVendorMainState currentState = state as BeVendorMainState;

    if(currentState.currentStep! == 0){
      if(currentState.cinController!.text.trim().length < 6){
        // SHOW SNAKE BAR
        return;
      }
      if(currentState.phoneController!.text.trim().length < 10){
        // SHOW SNAKE BAR
        return;
      }
      if(currentState.birthdayController!.text.trim().isEmpty){
        // SHOW SNAKE BAR
        return;
      }
    }
    if(currentState.currentStep! == 1){
      if(currentState.carAssuranceController!.text.trim().length < 6){
        // SHOW SNAKE BAR
        return;
      }
      if(currentState.carRegistrationController!.text.trim().length <= 6){
        // SHOW SNAKE BAR
        return;
      }
      if(currentState.shopThumbnail == ""){
        // SHOW SNAKE BAR
        return;
      }
    }
    if(currentState .currentStep! == 2) {
      if(currentState.cinFrontImage == ""){
        // SHOW SNAKE BAR
        return;
      }
      if(currentState.cinBackImage == ""){
        // SHOW SNAKE BAR
        return;
      }
      if(currentState.carAssuranceImage == ""){
        // SHOW SNAKE BAR
        return;
      }
      if(currentState.carAssuranceImage == ""){
        // SHOW SNAKE BAR
        return;
      }
    }

    final date = DateTime.now();
    final paperImages = [currentState.cinFrontImage, currentState.cinBackImage, currentState.carAssuranceImage, currentState.carRegistrationImage];

    // ADD NEW VENDOR
    final VendorEntity vendorEntity = VendorEntity(
      id: uid,
      firstName: currentState.userEntity?.firstName,
      lastName: currentState.userEntity?.lastName,
      cin: currentState.cinController?.text.trim(),
      avatar: currentState.userEntity?.avatar,
      email: currentState.userEntity?.email,
      phoneNumber: currentState.userEntity?.phoneNumber,
      gender: currentState.gender,
      shopThumbnail: currentState.shopThumbnail,
      carAssurance: currentState.carAssuranceController?.text.trim(),
      carRegistration: currentState.carRegistrationController?.text.trim(),
      carType: currentState.carType,
      isOnline: false,
      visible: false,
      averageRating: 0.0,
      birthdayYear:int.parse( currentState.birthdayController!.text.trim()),
      totalOrders: 0,
      shopLat: 0.0,
      shopLng: 0.0,
      uploadedPaperImagesAt:  "${date.day}/${date.month}/${date.year}",
      paperImages: paperImages,
      createAt: "${date.day}/${date.month}/${date.year}"
    );

    await vendorRepository.insertNewVendor(vendorEntity : vendorEntity);
    
    if(currentState.currentStep! >= 2) {
      emit(BeVendorLoadingState());
      await Future.delayed(const Duration(seconds: 2000));
      emit(BeVendorSuccessState());
      return;
    }
    final updateCurrentStep = currentState.currentStep! + 1;
    emit(currentState.copyWith(currentStep: updateCurrentStep));
  }

  // - - - - - - - - - - - - - - - - - - STEP BACK - - - - - - - - - - - - - - - - - -  //
  void cancel(){
    final BeVendorMainState currentState = state as BeVendorMainState;
    if(currentState.currentStep! <= 0) return;
    final updateCurrentStep = currentState.currentStep! - 1;
    emit(currentState.copyWith(currentStep: updateCurrentStep));
  }

  // - - - - - - - - - - - - - - - - - - UPDATE CURRENT STEP - - - - - - - - - - - - - - - - - -  //
  void onStepTapped(int step){
    final BeVendorMainState currentState = state as BeVendorMainState;
    emit(currentState.copyWith(currentStep: step));
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
  void onPickCarImage() async{
    final img = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    final BeVendorMainState currentState = state as BeVendorMainState;
    emit(currentState.copyWith(shopThumbnail: img?.path));
  }

  // - - - - - - - - - - - - - - - - - - PICK FRONT IMAGE OF CIN FROM GALLERY- - - - - - - - - - - - - - - - - -  //
  void onPickCinFrontImage() async{
    final img = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    final BeVendorMainState currentState = state as BeVendorMainState;
    emit(currentState.copyWith(cinFrontImage: img?.path));
  }

  // - - - - - - - - - - - - - - - - - - PICK IMAGE BACK OF CIN FROM GALLERY- - - - - - - - - - - - - - - - - -  //
  void onPickCinBackImage() async{
    final img = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    final BeVendorMainState currentState = state as BeVendorMainState;
    emit(currentState.copyWith(cinBackImage: img?.path));
  }

  // - - - - - - - - - - - - - - - - - - PICK IMAGE OF ASSURANCE FROM GALLERY- - - - - - - - - - - - - - - - - -  //
  void onPickAssuranceCarImage() async{
    final img = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    final BeVendorMainState currentState = state as BeVendorMainState;
    emit(currentState.copyWith(carAssuranceImage: img?.path));
  }

  // - - - - - - - - - - - - - - - - - - PICK IMAGE OF REGISTRATION FROM GALLERY- - - - - - - - - - - - - - - - - -  //
  void onPickRegistrationCarImage() async{
    final img = await _imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 25);
    final BeVendorMainState currentState = state as BeVendorMainState;
    emit(currentState.copyWith(carRegistrationImage: img?.path));
  }

}

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'be_vendor_state.dart';

class BeVendorCubit extends Cubit<BeVendorState> {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  final ImagePicker _imagePicker = ImagePicker();

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR - - - - - - - - - - - - - - - - - -  //
  BeVendorCubit() : super(BeVendorMainState()){ init(); }

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
        carRegistrationController: TextEditingController()
    ));
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

    // ADD NEW VENDOR

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

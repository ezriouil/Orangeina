import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'be_vendor_state.dart';

class BeVendorCubit extends Cubit<BeVendorState> {
  BeVendorCubit() : super(BeVendorMainState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  void init() async{
    emit(BeVendorMainState(
      scrollPhysics: const ScrollPhysics(),
      currentStep: 0,
      gender: "Man",
      carType: "",
      shopThumbnail: "",
      cinImage: "",
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
  void continued(){

    final BeVendorMainState currentState = state as BeVendorMainState;
    if(currentState.currentStep! >= 2) return;
    final updateCurrentStep = currentState.currentStep! + 1;

      if(currentState.cinController!.text.trim().length < 6){
        // SHOW SNAKE BAR
        return;
      }
      if(currentState.phoneController!.text.trim().length <= 10){
        // SHOW SNAKE BAR
        return;
      }
      if(currentState.birthdayController!.text.trim().isEmpty){
        // SHOW SNAKE BAR
        return;
    }

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

}

import 'package:berkania/utils/helpers/network.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../../domain/repositories/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {

  final AuthRepository authRepository;
  final GetStorage storage;
  final Connectivity connectivity;

  RegisterCubit({required this.authRepository, required this.storage, required this.connectivity}) : super(RegisterLoadingState()){ init(); }

  init() async {
    emit(RegisterCurrentState(
        firstNameController: TextEditingController(),
        lastNameController: TextEditingController(),
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
        confirmPasswordController: TextEditingController(),
        checkbox: false,
        passwordVisible: false,
        formState: GlobalKey<FormState>()));
  }

  // - - - - - - - - - - - - - - - - - - CREATE ACCOUNT WITH EMAIL AND PASSWORD - - - - - - - - - - - - - - - - - -  //
  Future<void> onCreateNewAccount(RegisterCurrentState state) async{
    try{

      // CHECK THE FORM
      if(!state.formState!.currentState!.validate()){
        /*SHOW SNACK BAR*/
        return;
      }

      // COMPARE PASSWORDS
      if(state.passwordController!.text.trim().toLowerCase() != state.confirmPasswordController!.text.trim().toLowerCase()){
        /*SHOW SNACK BAR*/
        return;
      }

      // CHECKBOX
      if(!state.checkbox!){
        /*SHOW SNACK BAR*/
        return;
      }

      // CHECK CONNECTION INTERNET
      final hasConnection = await Network.hasConnection(connectivity);
      if(!hasConnection){
        /*SHOW SNACK BAR*/
        return;
      }

      // EMIT LOADING STATE
      emit(RegisterLoadingState());

      // REGISTER USER INFO INTO FIRESTORE
      final UserCredential userCredential = await authRepository.register(
          firstName: state.firstNameController!.text.trim(),
          lastName: state.lastNameController!.text.trim(),
          email: state.emailController!.text.trim(),
          password: state.passwordController!.text.trim(),
          confirmPassword: state.confirmPasswordController!.text.trim());

      if(userCredential.user == null){
        emit(RegisterErrorState(message: "Invalid Register"));
        return;
      }


      // CLEAR TEXT FIELDS
      state.firstNameController!.clear();
      state.lastNameController!.clear();
      state.emailController!.clear();
      state.passwordController!.clear();
      state.confirmPasswordController!.clear();

      // NAVIGATE TO HOME SCREEN


    }catch(e){

      // EMIT ERROR STATE
      emit(RegisterErrorState(message: e.toString()));

    }
  }

  // - - - - - - - - - - - - - - - - - - CREATE ACCOUNT WITH GOOGLE - - - - - - - - - - - - - - - - - -  //
  void onCreateNewAccountWithGoogle() {}

  // - - - - - - - - - - - - - - - - - - UPDATE CHECKBOX - - - - - - - - - - - - - - - - - -  //
  void onUpdateCheckbox(RegisterCurrentState state, bool? value) {
    emit(state.copyWith(checkbox: value));
  }

  // - - - - - - - - - - - - - - - - - - UPDATE PASSWORD VISIBILITY - - - - - - - - - - - - - - - - - -  //
  void onUpdatePasswordVisibility(RegisterCurrentState state){
    bool newValue = state.passwordVisible ?? false;
    emit(state.copyWith(passwordVisible: newValue = !newValue));
  }

}

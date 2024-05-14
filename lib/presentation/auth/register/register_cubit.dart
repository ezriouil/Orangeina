import 'package:berkania/domain/entities/userEntity.dart';
import 'package:berkania/domain/repositories/user_repository.dart';
import 'package:berkania/utils/helpers/network.dart';
import 'package:berkania/utils/local/storage/local_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../../domain/repositories/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {

  final AuthRepository authRepository;
  final UserRepository userRepository;
  final GetStorage storage;
  final Connectivity connectivity;

  RegisterCubit({required this.authRepository, required this.userRepository, required this.storage, required this.connectivity}) : super(RegisterLoadingState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
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
  Future<void> onCreateNewAccount({required Function callBack}) async{
    try{


      // CURRENT STATE
      final RegisterCurrentState currentState = (state as RegisterCurrentState);

      // CHECK THE FORM
      if(!currentState.formState!.currentState!.validate()){
        /*SHOW SNACK BAR*/
        return;
      }

      // COMPARE PASSWORDS
      if(currentState.passwordController!.text.trim().toLowerCase() != currentState.confirmPasswordController!.text.trim().toLowerCase()){
        /*SHOW SNACK BAR*/
        return;
      }

      // CHECKBOX
      if(!currentState.checkbox!){
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
          email: currentState.emailController!.text.trim(),
          password: currentState.passwordController!.text.trim()
      );

      if(userCredential.user == null){
        emit(RegisterErrorState(message: "Invalid Register"));
        return;
      }

      // SAVE USER DATA
      final UserEntity userEntity = UserEntity(
        id: userCredential.user?.uid,
        firstName: currentState.firstNameController?.text,
        lastName: currentState.firstNameController?.text,
        avatar: "",
        email: currentState.emailController?.text,
        phoneNumber: "",
        type: "CLIENT",
        createAt: DateTime.now().toString()
      );
      await userRepository.saveUserInfo(userEntity: userEntity);

      // SAVE EMAIL + PASSWORD INTO LOCAL
      await LocalStorage.upsert(key: "UID", value: userEntity.id, storage: storage);
      await LocalStorage.upsert(key: "EMAIL", value: userEntity.email, storage: storage);
      await LocalStorage.upsert(key: "PASSWORD", value: currentState.passwordController?.text, storage: storage);

      // CLEAR TEXT FIELDS
      currentState.firstNameController!.clear();
      currentState.lastNameController!.clear();
      currentState.emailController!.clear();
      currentState.passwordController!.clear();
      currentState.confirmPasswordController!.clear();

      // NAVIGATE TO HOME SCREEN
      emit(currentState);
      callBack.call();

    }catch(e){

      // EMIT ERROR STATE
      emit(RegisterErrorState(message: e.toString()));

    }
  }

  // - - - - - - - - - - - - - - - - - - CREATE ACCOUNT WITH GOOGLE - - - - - - - - - - - - - - - - - -  //
  void onCreateNewAccountWithGoogle() {}

  // - - - - - - - - - - - - - - - - - - UPDATE CHECKBOX - - - - - - - - - - - - - - - - - -  //
  void onUpdateCheckbox(bool? value) {
    final RegisterCurrentState updateState = (state as RegisterCurrentState).copyWith(checkbox: value);
      emit(updateState);
  }

  // - - - - - - - - - - - - - - - - - - UPDATE PASSWORD VISIBILITY - - - - - - - - - - - - - - - - - -  //
  void onUpdatePasswordVisibility(){
    bool newValue = (state as RegisterCurrentState).passwordVisible!;
    final RegisterCurrentState updateState = (state as RegisterCurrentState).copyWith(passwordVisible: newValue = !newValue);
    emit(updateState);
  }

}

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
  Future<void> onCreateNewAccount({required RegisterCurrentState state, required Function callBack}) async{
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
          email: state.emailController!.text.trim(),
          password: state.passwordController!.text.trim()
      );

      if(userCredential.user == null){
        emit(RegisterErrorState(message: "Invalid Register"));
        return;
      }

      // SAVE USER DATA
      final UserEntity userEntity = UserEntity(
        id: userCredential.user?.uid,
        firstName: state.firstNameController?.text,
        lastName: state.firstNameController?.text,
        avatar: "",
        email: state.emailController?.text,
        phoneNumber: "",
        type: "CLIENT",
        createAt: DateTime.now().toString()
      );
      await userRepository.saveUserInfo(userEntity: userEntity);

      // SAVE EMAIL + PASSWORD INTO LOCAL
      await LocalStorage.upsert(key: "UID", value: userEntity.id, storage: storage);
      await LocalStorage.upsert(key: "EMAIL", value: userEntity.email, storage: storage);
      await LocalStorage.upsert(key: "PASSWORD", value: state.passwordController?.text, storage: storage);

      // CLEAR TEXT FIELDS
      state.firstNameController!.clear();
      state.lastNameController!.clear();
      state.emailController!.clear();
      state.passwordController!.clear();
      state.confirmPasswordController!.clear();

      // NAVIGATE TO HOME SCREEN
      emit(state);
      callBack.call();

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

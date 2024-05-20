import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/domain/entities/user_entity.dart';
import 'package:berkania/domain/repositories/user_repository.dart';
import 'package:berkania/presentation/widgets/custom_snackbars.dart';
import 'package:berkania/utils/helpers/network.dart';
import 'package:berkania/utils/local/storage/local_storage.dart';
import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
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
  Future<void> onCreateNewAccount({required BuildContext context, required Function callBack}) async{
    try{


      // CURRENT STATE
      final RegisterCurrentState currentState = (state as RegisterCurrentState);

      // CHECK THE FORM
      if(!currentState.formState!.currentState!.validate()){
        return;
      }

      // COMPARE PASSWORDS IS MATCHED OR NOT
      if(currentState.passwordController!.text.trim().toLowerCase() != currentState.confirmPasswordController!.text.trim().toLowerCase()){
        CustomSnackBar.show(context: context, title: CustomLocale.REGISTER_PASSWORD_NOT_MATCHED_TITLE_ERROR.getString(context), subTitle: CustomLocale.REGISTER_PASSWORD_NOT_MATCHED_SUB_TITLE_ERROR.getString(context), type: ContentType.warning);
        return;
      }

      // CHECKBOX
      if(!currentState.checkbox!){
        CustomSnackBar.show(context: context, title: CustomLocale.REGISTER_CHECK_BOX_TITLE_ERROR.getString(context), subTitle: CustomLocale.REGISTER_CHECK_BOX_SUB_TITLE_ERROR.getString(context), type: ContentType.warning);
        return;
      }

      // CHECK CONNECTION INTERNET
      final hasConnection = await Network.hasConnection(connectivity);
      if(!hasConnection && context.mounted){
        CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
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

  // - - - - - - - - - - - - - - - - - - CREATE ACCOUNT WITH GOOGLE - - - - - - - - - - - - - - - - - -  //
  void onCreateNewAccountWithGoogle({ required BuildContext context, required Function callBack }) async{

    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }

    // CALL LOGIN METHODE
    final UserCredential userCredential = await authRepository.loginWithGoogle();
    try{
      if(userCredential.user == null){
        emit(RegisterErrorState(message: "Invalid Login"));
        return;
      }

      // CHECK THE USER HIS INFO ALREADY EXIST OR NOT
      final bool result = await userRepository.existUser(userId: userCredential.user!.uid);
      if(!result){
        // SAVE USER DATA
        final UserEntity userEntity = UserEntity(
            id: userCredential.user?.uid,
            firstName: userCredential.user?.displayName?.split(" ").first,
            lastName: userCredential.user?.displayName?.split(" ").last,
            avatar: userCredential.user?.photoURL,
            email: userCredential.user?.email,
            phoneNumber: userCredential.user?.phoneNumber,
            type: "CLIENT",
            createAt: DateTime.now().toString()
        );
        await userRepository.saveUserInfo(userEntity: userEntity);

        // SAVE EMAIL + PASSWORD INTO LOCAL
        await LocalStorage.upsert(key: "UID", value: userEntity.id, storage: storage);
        await LocalStorage.upsert(key: "EMAIL", value: userEntity.email, storage: storage);
      }

      // NAVIGATE TO HOME SCREEN
      emit((state as RegisterCurrentState));
      callBack.call();

    }catch(e){
      // EMIT ERROR STATE
      emit(RegisterErrorState(message: "Cannot login with this email"));
    }
  }

  // - - - - - - - - - - - - - - - - - - TRY AGAIN BUTTON IN ERROR STATE - - - - - - - - - - - - - - - - - -  //
  void onTryAgain() async{
    emit(RegisterLoadingState());
    await Future.delayed(const Duration(milliseconds: 1000));
    init();
  }

}

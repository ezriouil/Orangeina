import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../utils/helpers/network.dart';
import '../../../utils/localisation/custom_locale.dart';
import '../../widgets/custom_snackbars.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {

  final AuthRepository authRepository;
  final Connectivity connectivity;

  ForgetPasswordCubit({required this.authRepository, required this.connectivity}) : super(ForgetPasswordMainState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init(){
    emit(ForgetPasswordMainState(emailController: TextEditingController(), formState: GlobalKey<FormState>()));
  }

  // - - - - - - - - - - - - - - - - - - SEND EMAIL LINK RESET THE PASSWORD - - - - - - - - - - - - - - - - - -  //
  onSend({required BuildContext context, required Function callBack}) async{

    // CURRENT STATE
    final ForgetPasswordMainState currentState = state as ForgetPasswordMainState;

    try{

      // CHECK THE FORM
      if(!currentState.formState!.currentState!.validate()) return;

      // CHECK CONNECTION INTERNET
      final hasConnection = await Network.hasConnection(connectivity);
      if(!hasConnection && context.mounted){
        CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
        return;
      }

      // EMIT LOADING STATE
      emit(ForgetPasswordLoadingState());

      // CHECK THE EMAIL IS EXIST OR NOT
      final isExist1 = await authRepository.emailExist(collection: "USERS", email: currentState.emailController!.text);
      final isExist2 = await authRepository.emailExist(collection: "VENDORS", email: currentState.emailController!.text);

      if(!isExist1 && !isExist2){
        emit(currentState);
        CustomSnackBar.show(context: context, title: "Email Not Found", subTitle: "Please Try Another Email", type: ContentType.warning);
        return;
      }

      // SEND RESET PASSWORD LINK
      await authRepository.forgetPassword(email: currentState.emailController!.text);

      // CLEAR TEXT FIELDS
      currentState.emailController!.clear();

      // NAVIGATE TO HOME SCREEN
      emit(currentState);
      CustomSnackBar.show(context: context, title: "Please Check Your Email", subTitle: "We Sent The Link To Reset Your Password", type: ContentType.warning);
      callBack.call();

    }catch(e){
      // EMIT ERROR STATE
      emit(currentState);
      CustomSnackBar.show(context: context, title: "Server Error", subTitle: "Please Try Again", type: ContentType.warning);
    }
  }

}

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

  ForgetPasswordCubit({required this.authRepository, required this.connectivity}) : super(ForgetPasswordCurrentState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init(){
    emit(ForgetPasswordCurrentState(emailController: TextEditingController()));
  }

  // - - - - - - - - - - - - - - - - - - SEND EMAIL LINK RESET THE PASSWORD - - - - - - - - - - - - - - - - - -  //
  onSend({required BuildContext context, required Function callBack}) async{
    try{


      // CURRENT STATE
      final ForgetPasswordCurrentState currentState = (state as ForgetPasswordCurrentState);

      // CHECK CONNECTION INTERNET
      final hasConnection = await Network.hasConnection(connectivity);
      if(!hasConnection && context.mounted){
        CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
        return;
      }

      // CHECK EMAIL FIELD
      if( (currentState.emailController!.text.trim().length < 7 || !currentState.emailController!.text.contains("@")) && context.mounted){
        CustomSnackBar.show(context: context, title: CustomLocale.FORGET_PASSOWRD_EMAIL_TITLE_INVALID.getString(context), subTitle: CustomLocale.FORGET_PASSOWRD_EMAIL_SUB_TITLE_INVALID.getString(context), type: ContentType.warning);
        return;
      }

      // EMIT LOADING STATE
      emit(ForgetPasswordLoadingState());

      // SEND RESET PASSWORD LINK
      await authRepository.forgetPassword(email: currentState.emailController!.text);

      // CLEAR TEXT FIELDS
      currentState.emailController!.clear();

      // NAVIGATE TO HOME SCREEN
      emit(currentState);
      callBack.call();

    }catch(e){
      // EMIT ERROR STATE
      emit(ForgetPasswordErrorState(message: e.toString()));
    }
  }

  // - - - - - - - - - - - - - - - - - - TRY AGAIN BUTTON IN ERROR STATE - - - - - - - - - - - - - - - - - -  //
  void onTryAgain() async{
    emit(ForgetPasswordLoadingState());
    await Future.delayed(const Duration(milliseconds: 1000));
    init();
  }

}

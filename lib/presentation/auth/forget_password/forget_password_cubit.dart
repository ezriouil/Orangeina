import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/auth_repository.dart';
import '../../../utils/helpers/network.dart';

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
  onSend({required Function callBack}) async{
    try{


      // CURRENT STATE
      final ForgetPasswordCurrentState currentState = (state as ForgetPasswordCurrentState);

      // CHECK CONNECTION INTERNET
      final hasConnection = await Network.hasConnection(connectivity);
      if(!hasConnection){
        /*SHOW SNACK BAR*/
        return;
      }

      // CHECK EMAIL FIELD
      if(currentState.emailController!.text.trim().length < 7 || !currentState.emailController!.text.contains("@")){
        /*SHOW SNACK BAR*/
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
}

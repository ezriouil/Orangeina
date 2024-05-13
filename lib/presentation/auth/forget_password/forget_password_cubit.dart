import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitialState());

  onSend(){
    try{

      // EMIT LOADING STATE
      emit(ForgetPasswordLoadingState());

      // REGISTER USER INFO INTO FIRESTORE


      // EMIT SUCCESS STATE
      //emit(RegisterSuccess(userCredential: userCredential));


    }catch(e){

      // EMIT ERROR STATE
      emit(ForgetPasswordErrorState(message: e.toString()));

    }
  }

}

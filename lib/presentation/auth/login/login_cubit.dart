import 'package:berkania/domain/repositories/auth_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  final AuthRepository authRepository;
  LoginCubit({required this.authRepository}) : super(LoginCurrentState());

  onLogin() async{
    try{

      // // REGISTER USER INFO INTO FIRESTORE
      // final UserCredential userCredential = await authRepository.register(email: "MohamedEzriouil@gmail.com", password: "Mohamed2024");
      //
      // print("+++++++++");
      // print(userCredential.user?.uid ?? "Doesn't work");
      // print("+++++++++");



    }catch(e){

      // EMIT ERROR STATE
      emit(LoginErrorState(message: e.toString()));

    }
  }

}

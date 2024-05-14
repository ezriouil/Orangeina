import 'package:berkania/domain/repositories/auth_repository.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/localisation/custom_locale.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  final FlutterLocalization localization = FlutterLocalization.instance;

  final AuthRepository authRepository;
  LoginCubit({required this.authRepository}) : super(LoginCurrentState()){  init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init() async {
    emit(LoginCurrentState(
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
        passwordVisible: false,
        arabicLang:  false,
        frenchLang: false,
        englishLang: true,
        formState: GlobalKey<FormState>()));
  }

  // - - - - - - - - - - - - - - - - - - LOGIN WITH EMAIL AND PASSWORD - - - - - - - - - - - - - - - - - -  //
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

  // - - - - - - - - - - - - - - - - - - TRANSLATION - - - - - - - - - - - - - - - - - -  //
  onShowDialog({ required BuildContext context, required LoginCurrentState state }) async{
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // - - - - - - - - - - - - - - - - - - IMAGE - - - - - - - - - - - - - - - - - -  //
                        ClipRRect(borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2), child: Image.asset(CustomImageStrings.FLAG_MOROCCO, height: 30, width: 40, fit: BoxFit.cover,)),

                        // - - - - - - - - - - - - - - - - - - TEXT - - - - - - - - - - - - - - - - - -  //
                        Text("العربية", style: Theme.of(context).textTheme.headlineSmall),

                        // - - - - - - - - - - - - - - - - - - CHECKBOX - - - - - - - - - - - - - - - - - -  //
                        Checkbox(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                            value: state.arabicLang,
                            onChanged: (value) {
                              if(!state.arabicLang!){
                                localization.translate(CustomLocale.AR);
                                emit(state.copyWith(arabicLang: true, frenchLang: false, englishLang: false));
                                context.pop();
                              }
                            }),
                      ]),
                  const Divider(color: CustomColors.GRAY_LIGHT),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // - - - - - - - - - - - - - - - - - - IMAGE - - - - - - - - - - - - - - - - - -  //
                        ClipRRect(borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2), child: Image.asset(CustomImageStrings.FLAG_FRANCE, height: 30, width: 40, fit: BoxFit.cover,)),

                        // - - - - - - - - - - - - - - - - - - TEXT - - - - - - - - - - - - - - - - - -  //
                        Text("Francais", style: Theme.of(context).textTheme.headlineSmall),

                        // - - - - - - - - - - - - - - - - - - CHECKBOX - - - - - - - - - - - - - - - - - -  //
                        Checkbox(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                            value: state.frenchLang,
                            onChanged: (value) {
                              if(!state.frenchLang!){
                                localization.translate(CustomLocale.FR);
                                emit(state.copyWith(frenchLang: true, arabicLang: false, englishLang: false));
                                context.pop();
                              }
                            }),
                      ]),
                  const Divider(color: CustomColors.GRAY_LIGHT),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        // - - - - - - - - - - - - - - - - - - IMAGE - - - - - - - - - - - - - - - - - -  //
                        ClipRRect(borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2), child: Image.asset(CustomImageStrings.FLAG_ENGLAND, height: 30, width: 40, fit: BoxFit.cover,)),

                        // - - - - - - - - - - - - - - - - - - TEXT - - - - - - - - - - - - - - - - - -  //
                        Text("English", style: Theme.of(context).textTheme.headlineSmall),

                        // - - - - - - - - - - - - - - - - - - CHECKBOX - - - - - - - - - - - - - - - - - -  //
                        Checkbox(
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                            value: state.englishLang,
                            onChanged: (value) {
                              if(!state.englishLang!){
                                localization.translate(CustomLocale.EN);
                                emit(state.copyWith(englishLang: true, arabicLang: false, frenchLang: false));
                                context.pop();
                              }
                            }),
                      ]),
                ],
              ),
            ),
          );
        });
  }

}

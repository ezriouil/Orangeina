import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/domain/repositories/auth_repository.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/local/storage/local_storage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_storage/get_storage.dart';

import '../../../domain/entities/userEntity.dart';
import '../../../domain/repositories/user_repository.dart';
import '../../../utils/helpers/network.dart';
import '../../../utils/localisation/custom_locale.dart';
import '../../widgets/custom_snackbars.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  final FlutterLocalization localization = FlutterLocalization.instance;

  final AuthRepository authRepository;
  final UserRepository userRepository;
  final GetStorage storage;
  final Connectivity connectivity;

  LoginCubit({required this.authRepository, required this.userRepository, required this.storage, required this.connectivity}) : super(LoginCurrentState()){  init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init() async {
    emit(LoginCurrentState(
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
        passwordVisible: false,
        arabicLang:  false,
        frenchLang: false,
        englishLang:  false,
        formState: GlobalKey<FormState>()));
    final String lang = await LocalStorage.read(key: "LANGUAGE", storage: storage) ?? CustomLocale.EN;
    final LoginCurrentState currentState = (state as LoginCurrentState);
    emit(currentState.copyWith(
      frenchLang: lang == CustomLocale.FR ? true : false,
      arabicLang: lang == CustomLocale.AR ? true : false,
      englishLang: lang == CustomLocale.EN ? true : false,
    ));
  }

  // - - - - - - - - - - - - - - - - - - LOGIN WITH EMAIL AND PASSWORD - - - - - - - - - - - - - - - - - -  //
  onLogin({required BuildContext context, required Function callBack}) async{
    try{

      // CURRENT STATE
      final LoginCurrentState currentState = (state as LoginCurrentState);

      // CHECK THE FORM
      if(!currentState.formState!.currentState!.validate()) return;

      // CHECK CONNECTION INTERNET
      final hasConnection = await Network.hasConnection(connectivity);
      if(!hasConnection && context.mounted){
        CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
        return;
      }

      // EMIT LOADING STATE
      emit(LoginLoadingState());

      // CALL LOGIN METHODE
      final UserCredential userCredential = await authRepository.login(
          email: currentState.emailController!.text.trim(),
          password: currentState.passwordController!.text.trim()
      );

      if(userCredential.user == null){
        emit(LoginErrorState(message: "Invalid Login"));
        return;
      }

      // CLEAR TEXT FIELDS
      currentState.emailController!.clear();
      currentState.passwordController!.clear();

      // NAVIGATE TO HOME SCREEN
      emit(currentState);
      callBack.call();

    }catch(e){

      // EMIT ERROR STATE
      emit(LoginErrorState(message: e.toString()));

    }
  }

  // - - - - - - - - - - - - - - - - - - LOGIN WITH GOOGLE - - - - - - - - - - - - - - - - - -  //
  void loginWithGoogle({ required BuildContext context, required Function callBack }) async{

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
        emit(LoginErrorState(message: "Invalid Login"));
        return;
      }

      // CHECK THE USER HIS INFO ALREADY EXIST OR NOT
      final bool result = await userRepository.isExist(userId: userCredential.user!.uid);
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
      emit((state as LoginCurrentState));
      callBack.call();

    }catch(e){
      // EMIT ERROR STATE
      emit(LoginErrorState(message: "Cannot login with this email"));
    }
  }

  // - - - - - - - - - - - - - - - - - - UPDATE PASSWORD VISIBILITY - - - - - - - - - - - - - - - - - -  //
  void onUpdatePasswordVisibility(){
    bool newValue = (state as LoginCurrentState).passwordVisible!;
    final LoginCurrentState updateState = (state as LoginCurrentState).copyWith(passwordVisible: newValue = !newValue);
    emit(updateState);
  }

  // - - - - - - - - - - - - - - - - - - SHOW DIALOG LANGUAGES - - - - - - - - - - - - - - - - - -  //
  onUpdateLanguage({ required BuildContext context, required Function callBack }) async{

    final LoginCurrentState currentState = (state as LoginCurrentState);
    String langSelected = "";

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
                            value: currentState.arabicLang,
                            onChanged: (value) async{
                              if(!currentState.arabicLang!){
                                langSelected = CustomLocale.AR;
                                localization.translate(CustomLocale.AR);
                                emit(currentState.copyWith(arabicLang: true, frenchLang: false, englishLang: false));
                                callBack.call();
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
                            value: currentState.frenchLang,
                            onChanged: (value) async{
                              if(!currentState.frenchLang!){
                                langSelected = CustomLocale.FR;
                                localization.translate(CustomLocale.FR);
                                emit(currentState.copyWith(frenchLang: true, arabicLang: false, englishLang: false));
                                callBack.call();
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
                            value: currentState.englishLang,
                            onChanged: (value) async{
                              if(!currentState.englishLang!){
                                langSelected = CustomLocale.EN;
                                localization.translate(CustomLocale.EN);
                                emit(currentState.copyWith(englishLang: true, arabicLang: false, frenchLang: false));
                                callBack.call();
                              }
                            }),
                      ]),
                ],
              ),
            ),
          );
        });

    if(langSelected == "") return;
    await LocalStorage.upsert(key: "LANGUAGE", value: langSelected, storage: storage);
  }

  // - - - - - - - - - - - - - - - - - - TRY AGAIN BUTTON IN ERROR STATE - - - - - - - - - - - - - - - - - -  //
  void onTryAgain() async{
    emit(LoginLoadingState());
    await Future.delayed(const Duration(milliseconds: 1000));
    init();
  }

}
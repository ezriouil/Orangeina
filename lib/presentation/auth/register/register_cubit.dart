import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/domain/entities/user_entity.dart';
import 'package:berkania/domain/repositories/user_repository.dart';
import 'package:berkania/presentation/be_vendor/be_vendor_cubit.dart';
import 'package:berkania/presentation/home/home_cubit.dart';
import 'package:berkania/presentation/index/index_cubit.dart';
import 'package:berkania/presentation/notification/notification_cubit.dart';
import 'package:berkania/presentation/settings/settings_cubit.dart';
import 'package:berkania/presentation/vendor_details/vendor_details_cubit.dart';
import 'package:berkania/presentation/vendor_new_order/vendor_new_order_cubit.dart';
import 'package:berkania/presentation/vendor_orders/vendor_orders_cubit.dart';
import 'package:berkania/presentation/widgets/custom_snackbars.dart';
import 'package:berkania/presentation/wishlist/wishlist_cubit.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:berkania/utils/constants/custom_txt_strings.dart';
import 'package:berkania/utils/helpers/network.dart';
import 'package:berkania/utils/local/storage/local_storage.dart';
import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/repositories/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {

  final AuthRepository authRepository;
  final UserRepository userRepository;
  final GetStorage storage;
  final Connectivity connectivity;
  final BuildContext context;

  RegisterCubit({required this.context, required this.authRepository, required this.userRepository, required this.storage, required this.connectivity}) : super(RegisterLoadingState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init() async {
    emit(RegisterMainState(
        firstNameController: TextEditingController(),
        lastNameController: TextEditingController(),
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
        confirmPasswordController: TextEditingController(),
        checkbox: false,
        obscureText: false,
        formState: GlobalKey<FormState>()));
  }

  // - - - - - - - - - - - - - - - - - - CREATE ACCOUNT WITH EMAIL AND PASSWORD - - - - - - - - - - - - - - - - - -  //
  Future<void> onCreateNewAccount({required BuildContext context, required Function callBack}) async{
    final RegisterMainState currentState = (state as RegisterMainState);
    try{

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
        CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.REGISTER_ERROR_EMAIL_INVALID_SUB_TITLE.getString(context), type: ContentType.warning);
        return;
      }
      // SAVE USER DATA
      final date = DateTime.now();
      final UserEntity userEntity = UserEntity(
        id: userCredential.user?.uid,
        firstName: currentState.firstNameController?.text,
        lastName: currentState.firstNameController?.text,
        avatar: CustomImageStrings.DEFAULT_IMAGE_PROFILE,
        email: currentState.emailController?.text,
        phoneNumber: "",
        createAt: "${date.year}/${date.month}/${date.day} ${date.hour}:${date.minute}:${date.second} ",
      );
      await userRepository.saveUserInfo(userEntity: userEntity);

      // SAVE EMAIL + PASSWORD INTO LOCAL
      await LocalStorage.upsert(key: "UID", value: userCredential.user?.uid, storage: storage);

      // CLEAR TEXT FIELDS
      currentState.firstNameController!.clear();
      currentState.lastNameController!.clear();
      currentState.emailController!.clear();
      currentState.passwordController!.clear();
      currentState.confirmPasswordController!.clear();

      // NAVIGATE TO HOME SCREEN
      emit(currentState);
      CustomSnackBar.show(context: context, title: CustomLocale.SUCCESS_TITLE.getString(context), subTitle: CustomLocale.REGISTER_SUCCESS_SUB_TITLE.getString(context), type: ContentType.warning);
      callBack.call();

    }catch(e){
      emit(currentState);
      CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.REGISTER_ERROR_EMAIL_INVALID_SUB_TITLE.getString(context), type: ContentType.warning);
    }
  }

  // - - - - - - - - - - - - - - - - - - UPDATE CHECKBOX - - - - - - - - - - - - - - - - - -  //
  void onUpdateCheckbox(bool? value) {
    final RegisterMainState updateState = (state as RegisterMainState).copyWith(checkbox: value);
      emit(updateState);
  }

  // - - - - - - - - - - - - - - - - - - UPDATE PASSWORD VISIBILITY - - - - - - - - - - - - - - - - - -  //
  void onUpdatePasswordVisibility(){
    bool newValue = (state as RegisterMainState).obscureText!;
    final RegisterMainState updateState = (state as RegisterMainState).copyWith(obscureText: newValue = !newValue);
    emit(updateState);
  }

  // - - - - - - - - - - - - - - - - - - ON NAVIGATE TO TERMS OF USE - - - - - - - - - - - - - - - - - -  //
  void onNavigateToTermsOfUse({ required BuildContext context }) async{

    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }

    await launchUrl(Uri.parse(CustomTextStrings.TERMS_LINK), mode: LaunchMode.inAppWebView);
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
        CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.REGISTER_ERROR_EMAIL_INVALID_SUB_TITLE.getString(context), type: ContentType.warning);
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
            avatar: userCredential.user?.photoURL ??  CustomImageStrings.DEFAULT_IMAGE_PROFILE,
            email: userCredential.user?.email,
            phoneNumber: userCredential.user?.phoneNumber ?? "",
            createAt: DateTime.now().toString()
        );
        await userRepository.saveUserInfo(userEntity: userEntity);
      }

      await LocalStorage.upsert(key: "UID", value: userCredential.user?.uid, storage: storage);
      await LocalStorage.upsert(key: "INIT_LOCATION", value: "INDEX", storage: storage);

      // NAVIGATE TO HOME SCREEN
      context.read<IndexCubit>().init();
      context.read<HomeCubit>().init(context: context);
      context.read<HomeCubit>().getAllVendors();
      context.read<BeVendorCubit>().init();
      context.read<NotificationCubit>().init(context: context);
      context.read<SettingsCubit>().init(context: context);
      context.read<VendorDetailsCubit>().init(context: context);
      context.read<VendorNewOrderCubit>().init();
      context.read<VendorOrdersCubit>().init(context: context);
      context.read<WishlistCubit>().init(context: context);

      // NAVIGATE TO HOME SCREEN
      callBack.call();

    }catch(_){
      CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.REGISTER_ERROR_EMAIL_INVALID_SUB_TITLE.getString(context), type: ContentType.warning);
    }
  }
}

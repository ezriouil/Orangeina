import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/presentation/auth/login/login_cubit.dart';
import 'package:berkania/presentation/widgets/custom_error_screen.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/extensions/validator.dart';
import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/state/custom_state.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_snackbars.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends CustomState {
  const LoginScreen({super.key});

  @override
  Widget run(BuildContext context) {

    return Scaffold(
      body: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          switch(state){
            case LoginCurrentState():
              {
                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: CustomSizes.SPACE_DEFAULT),
                  child: Form(
                      key: state.formState!,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                          // - - - - - - - - - - - - - - - - - - LOGO - - - - - - - - - - - - - - - - - -  //
                          Image.asset(CustomImageStrings.APP_LOGO_ICON, height: 80),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                          // - - - - - - - - - - - - - - - - - - TITLE - - - - - - - - - - - - - - - - - -  //
                          Text(CustomLocale.LOGIN_TITLE.getString(context), style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1)),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                          // - - - - - - - - - - - - - - - - - - SUBTITLE - - - - - - - - - - - - - - - - - -  //
                          Text(CustomLocale.LOGIN_SUB_TITLE.getString(context), style: Theme.of(context).textTheme.bodyMedium),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                          // - - - - - - - - - - - - - - - - - - EMAIL - - - - - - - - - - - - - - - - - -  //
                          CustomTextField(
                              leadingIcon: Iconsax.direct_right,
                              controller: state.emailController!,
                              validator: (value) => Validator.validateEmailField(CustomLocale.EMAIL_VALIDATOR.getString(context), value),
                              hint: CustomLocale.EMAIL.getString(context),
                              textInputType: TextInputType.emailAddress),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 4),

                          // - - - - - - - - - - - - - - - - - - PASSWORD - - - - - - - - - - - - - - - - - -  //
                          CustomTextField(
                              leadingIcon: Iconsax.password_check,
                              controller: state.passwordController!,
                              validator: (value) => Validator.validatePasswordField(CustomLocale.PASSWORD_VALIDATOR.getString(context), value),
                              hint: CustomLocale.PASSWORD.getString(context),
                              textInputType: TextInputType.visiblePassword,
                              obscureText: state.passwordVisible!  ,
                              trailingIcon: InkWell(
                                  onTap: context.read<LoginCubit>().onUpdatePasswordVisibility,
                                  borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                  child: Icon(state.passwordVisible! ? Iconsax.eye_slash : Iconsax.eye, color: darkLightColor(context)))
                          ),

                          // - - - - - - - - - - - - - - - - - - FORGET THE PASSWORD - - - - - - - - - - - - - - - - - -  //
                          SizedBox(width: getWidth(context), child: InkWell(onTap: (){ context.pushNamed(CustomRouter.FORGET_PASSWORD); }, borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS), overlayColor: MaterialStateProperty.all(CustomColors.TRANSPARENT), child: Text(CustomLocale.LOGIN_FORGET_THE_PASSWORD.getString(context), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.end))),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                          // - - - - - - - - - - - - - - - - - - BUTTON LOGIN - - - - - - - - - - - - - - - - - -  //
                          CustomElevatedButton(
                            onClick: (){
                              context.read<LoginCubit>().onLogin( context:context, callBack : (){
                                CustomSnackBar.show(context: context, title: "New", subTitle: "New Sanck bar", type: ContentType.success);
                                context.pushReplacement(CustomRouter.INDEX);
                              }); },
                            width: getWidth(context),
                            withDefaultPadding: false,
                            child: Text(CustomLocale.LOGIN_LOGIN.getString(context)),
                          ),

                          // - - - - - - - - - - - - - - - - - - BUTTON REGISTER - - - - - - - - - - - - - - - - - -  //
                          CustomElevatedButton(
                            onClick: (){ context.pushNamed(CustomRouter.REGISTER);},
                            width: getWidth(context),
                            backgroundColor: greenColor(context),
                            withDefaultPadding: false,
                            child: Text(CustomLocale.LOGIN_CREATE_NEW_ACCOUNT.getString(context)),
                          ),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                          // - - - - - - - - - - - - - - - - - - TEXT - - - - - - - - - - - - - - - - - -  //
                          Row(
                            children: [
                              Expanded(child: Divider(color: grayColor(context).withOpacity(0.4), indent: CustomSizes.SPACE_DEFAULT)),
                              Text("   ${CustomLocale.OR.getString(context)}   ", style: Theme.of(context).textTheme.bodyMedium),
                              Expanded(child: Divider(color: grayColor(context).withOpacity(0.4), endIndent: CustomSizes.SPACE_DEFAULT)),
                            ],
                          ),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                          // - - - - - - - - - - - - - - - - - - BUTTON GOOGLE - - - - - - - - - - - - - - - - - -  //
                          CustomElevatedButton(
                              onClick: () {context.read<LoginCubit>().loginWithGoogle(context: context, callBack: (){ context.pushReplacement(CustomRouter.INDEX); } );},
                              height: 74,
                              withDefaultPadding: false,
                              backgroundColor: darkLightColor(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(CustomImageStrings.ICON_GOOGLE, width: 18, height: 18),
                                  Text("  ${CustomLocale.LOGIN_LOGIN_WITH_GOOGLE.getString(context)}", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: darkDarkLightLightColor(context), letterSpacing: 1))
                                ],
                              )),

                          // - - - - - - - - - - - - - - - - - - BUTTON TRANSLATION - - - - - - - - - - - - - - - - - -  //
                          CustomElevatedButton(
                              onClick: () { context.read<LoginCubit>().onUpdateLanguage(context: context, callBack: (){ context.pop(); } ); },
                              height: 76,
                              withDefaultPadding: false,
                              backgroundColor: darkLightColor(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(state.englishLang! ? CustomImageStrings.FLAG_ENGLAND : state.frenchLang! ? CustomImageStrings.FLAG_FRANCE :CustomImageStrings.FLAG_MOROCCO , width: 20, height: 20),
                                  Text("  ${CustomLocale.LOGIN_CHANGE_THE_LANGUAGE.getString(context)}", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: darkDarkLightLightColor(context), letterSpacing: 1))
                                ],
                              )),
                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),
                        ],
                      )),
                );
              }
            case LoginLoadingState():
              {
                return const CustomLoadingScreen();
              }
            case LoginErrorState():
              {
                return CustomErrorScreen(onClick: context.read<LoginCubit>().onTryAgain);
              }
          }
        },
      ),
    );
  }
}
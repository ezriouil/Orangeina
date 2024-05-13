import 'package:berkania/presentation/auth/register/register_cubit.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/extensions/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/localisation/custom_locale.dart';
import '../../../utils/state/custom_state.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';

class RegisterScreen extends CustomState {
  const RegisterScreen({super.key});

  @override
  Widget run(BuildContext context) {

    // - - - - - - - - - - - - - - - - - - HIDE THE TOP STATUS BAR AND SYSTEM BOTTOM BAR - - - - - - - - - - - - - - - - - -  //
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            context.pop();
          },
          borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
          child: Icon(
              isArabic(context) ? Iconsax.arrow_left_24 : Iconsax.arrow_left_24,
              color: darkLightColor(context)),
        ),
      ),
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          switch(state){
            case RegisterCurrentState():
            {
                 return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: CustomSizes.SPACE_DEFAULT),
                  child: Form(
                    key: state.formState,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                          Text(CustomLocale.REGISTER_TITLE.getString(context), style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.5)),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_DEFAULT),

                          Row(
                            children: [
                              // - - - - - - - - - - - - - - - - - - FIRST NAME - - - - - - - - - - - - - - - - - -  //
                              Expanded(
                                child: CustomTextField(
                                    leadingIcon: Iconsax.user,
                                    hint: CustomLocale.REGISTER_FIRST_NAME.getString(context),
                                    controller: state.firstNameController!,
                                    validator: (value) => Validator.validateEmptyField(CustomLocale.REGISTER_FIRST_NAME_VALIDATOR.getString(context), value),
                                    textInputType: TextInputType.emailAddress),
                              ),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                              // - - - - - - - - - - - - - - - - - - LAST NAME - - - - - - - - - - - - - - - - - -  //
                              Expanded(
                                child: CustomTextField(
                                    leadingIcon: Iconsax.user,
                                    hint: CustomLocale.REGISTER_LAST_NAME.getString(context),
                                    controller: state.lastNameController!,
                                    validator: (value) => Validator.validateEmptyField(CustomLocale.REGISTER_LAST_NAME_VALIDATOR.getString(context), value),
                                    textInputType: TextInputType.emailAddress),
                              ),
                            ],
                          ),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 4),

                          // - - - - - - - - - - - - - - - - - - EMAIL - - - - - - - - - - - - - - - - - -  //
                          CustomTextField(
                              leadingIcon: Iconsax.direct_right,
                              hint: CustomLocale.EMAIL.getString(context),
                              controller: state.emailController!,
                              validator: (value) => Validator.validateEmailField(CustomLocale.EMAIL_VALIDATOR.getString(context), value),
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
                              obscureText: state.passwordVisible!,
                              trailingIcon: InkWell(
                                  onTap: () => context.read<RegisterCubit>().onUpdatePasswordVisibility(state),
                                  borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                  child: Icon(state.passwordVisible! ? Iconsax.eye_slash : Iconsax.eye, color: darkLightColor(context)))
                          ),
                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 4),

                          // - - - - - - - - - - - - - - - - - - CONFIRM PASSWORD - - - - - - - - - - - - - - - - - -  //
                          CustomTextField(
                            leadingIcon: Iconsax.password_check,
                            controller:state.confirmPasswordController!,
                            validator: (value) => Validator.validatePasswordField(CustomLocale.REGISTER_CONFIRM_PASSWORD_VALIDATOR.getString(context), value),
                            hint: CustomLocale.REGISTER_CONFIRM_PASSWORD.getString(context),
                            textInputType: TextInputType.visiblePassword,
                            obscureText: state.passwordVisible!,
                            trailingIcon: InkWell(
                                onTap: () => context.read<RegisterCubit>().onUpdatePasswordVisibility(state),
                                borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                child: Icon(state.passwordVisible! ? Iconsax.eye_slash : Iconsax.eye, color: darkLightColor(context))),
                          ),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                          // - - - - - - - - - - - - - - - - - - CHECKBOX + SPACER + TEXT - - - - - - - - - - - - - - - - - -  //
                          Row(children: [
                            // - - - - - - - - - - - - - - - - - - CHECKBOX - - - - - - - - - - - - - - - - - -  //
                            Checkbox(
                                visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
                                value: state.checkbox,
                                onChanged: (value){ context.read<RegisterCubit>().onUpdateCheckbox(state, value); }),

                            // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                            const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                            // - - - - - - - - - - - - - - - - - - TEXT - - - - - - - - - - - - - - - - - -  //
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                    text: CustomLocale.REGISTER_IM_AGREE.getString(context),
                                    style: Theme.of(context).textTheme.bodySmall,
                                    children: [
                                      TextSpan(text: ' ${CustomLocale.REGISTER_TERMS_OF_USE.getString(context)}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: primaryColor(context)), recognizer: TapGestureRecognizer()..onTap = () {}),
                                      TextSpan(text: ' &', style: Theme.of(context).textTheme.bodySmall),
                                      TextSpan(text: ' ${CustomLocale.REGISTER_PRIVACY_POLICY.getString(context)}', style: Theme.of(context).textTheme.bodySmall?.copyWith(color: primaryColor(context)), recognizer: TapGestureRecognizer()..onTap = () {})
                                    ]),
                              ),
                            ),
                          ]),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                          // - - - - - - - - - - - - - - - - - - BUTTON REGISTER - - - - - - - - - - - - - - - - - -  //
                          CustomElevatedButton(
                            onClick: () { context.read<RegisterCubit>().onCreateNewAccount(state); },
                            width: getWidth(context),
                            withDefaultPadding: false,
                            child: Text(CustomLocale.REGISTER_CREATE_ACCOUNT.getString(context)),
                          ),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                          // - - - - - - - - - - - - - - - - - - TEXT - - - - - - - - - - - - - - - - - -  //
                          Row(
                            children: [
                              Expanded(child: Divider(color: grayColor(context).withOpacity(0.4), indent: CustomSizes.SPACE_DEFAULT)),
                              Text("   ${CustomLocale.OR.getString(context)}   ", style: Theme.of(context).textTheme.bodyMedium),
                              Expanded(child: Divider(color: grayColor(context).withOpacity(0.4), endIndent: CustomSizes.SPACE_DEFAULT)),
                            ],
                          ),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                          // - - - - - - - - - - - - - - - - - - BUTTON GOOGLE - - - - - - - - - - - - - - - - - -  //
                          CustomElevatedButton(
                              onClick: context.read<RegisterCubit>().onCreateNewAccountWithGoogle,
                              height: 74,
                              withDefaultPadding: false,
                              backgroundColor: darkLightColor(context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(CustomImageStrings.ICON_GOOGLE, width: 18, height: 18),
                                  Text("   ${CustomLocale.REGISTER_WITH_GOOGLE.getString(context)}", style: Theme.of(context).textTheme.titleMedium?.copyWith(color: darkDarkLightLightColor(context), letterSpacing: 1))
                                ],
                              )),

                          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                        ],
                      )),
                );
              }
            case RegisterLoadingState():
              {
                 return Center(child: CircularProgressIndicator(color: primaryColor(context)));
              }
            case RegisterErrorState():
              {
                 return Center(child: Text(state.message, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center));
              }
          }
        },
      ),
    );
  }
}

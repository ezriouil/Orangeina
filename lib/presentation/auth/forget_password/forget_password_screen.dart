import 'package:berkania/presentation/auth/forget_password/forget_password_cubit.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/localisation/custom_locale.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_error_screen.dart';
import '../../widgets/custom_loading_screen.dart';
import '../../widgets/custom_text_field.dart';

class ForgetPasswordScreen extends CustomState {
  const ForgetPasswordScreen({super.key});

  @override
  Widget run(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () { context.pop(); },
          borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
          child: Icon(Iconsax.arrow_right_3, color: darkLightColor(context)),
        ),
      ),
      body: BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
        builder: (context, state) {
          switch (state) {
            case ForgetPasswordMainState():
              {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: CustomSizes.SPACE_BETWEEN_ITEMS),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                        // - - - - - - - - - - - - - - - - - - TITLE - - - - - - - - - - - - - - - - - -  //
                        Text(CustomLocale.FORGET_PASSOWRD_TITLE.getString(context), style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),

                        // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                        // - - - - - - - - - - - - - - - - - - SUB_TITLE - - - - - - - - - - - - - - - - - -  //
                        Text(CustomLocale.FORGET_PASSOWRD_SUB_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.0)),

                        // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS * 2),

                        // - - - - - - - - - - - - - - - - - - IMAGE - - - - - - - - - - - - - - - - - -  //
                        Center(child: ClipRRect(borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS), child: Image.asset(CustomImageStrings.SEND_EMAIL, height: 150, width: 150, color: primaryColor(context), colorBlendMode: BlendMode.color))),

                        // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                        // - - - - - - - - - - - - - - - - - - EMAIL - - - - - - - - - - - - - - - - - -  //
                        CustomTextField(
                            leadingIcon: Iconsax.direct_right,
                            hint: CustomLocale.EMAIL.getString(context),
                            controller: state.emailController!,
                            textInputType: TextInputType.emailAddress),

                        // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                        // - - - - - - - - - - - - - - - - - - BUTTON - - - - - - - - - - - - - - - - - -  //
                        CustomElevatedButton(
                          onClick: () { context.read<ForgetPasswordCubit>().onSend(context: context, callBack: (){ context.pop(); }); },
                          width: getWidth(context),
                          child: Text(CustomLocale.FORGET_PASSOWRD_SEND.getString(context)),
                        ),

                      ],
                    ),
                  ),
                );
              }
            case ForgetPasswordLoadingState():
              {
                return const CustomLoadingScreen();
              }
            case ForgetPasswordErrorState():
              {
                return CustomErrorScreen(onClick: context.read<ForgetPasswordCubit>().onTryAgain);
              }
          }
        },
      ),
    );
  }
}

import 'package:berkania/presentation/be_vendor/be_vendor_cubit.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/presentation/widgets/custom_error_screen.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_sizes.dart';
import '../../utils/localisation/custom_locale.dart';
import '../widgets/custom_text_field.dart';

class BeVendorScreen extends CustomState {
  const BeVendorScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: context.pop,
          borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
          child: Icon( Iconsax.arrow_left_24, color: darkLightColor(context)),
        ),
        title: Text(CustomLocale.BE_VENDOR_TITLE.getString(context), style: Theme.of(context).textTheme.titleMedium)
      ),
      body: BlocBuilder<BeVendorCubit, BeVendorState>(
        builder: (context, state) {
          switch(state){
            case BeVendorMainState():
              {
                return Stepper(
                    physics: state.scrollPhysics!,
                    currentStep: state.currentStep!,
                    connectorColor: MaterialStateProperty.all(primaryColor(context)),
                    onStepTapped: context.read<BeVendorCubit>().onStepTapped,
                    onStepContinue: context.read<BeVendorCubit>().continued,
                    onStepCancel: context.read<BeVendorCubit>().cancel,
                    controlsBuilder: (BuildContext context, ControlsDetails details){
                      return Row(
                        children: [
                          Expanded(child: CustomElevatedButton(onClick: details.onStepContinue, height: 76, child: Text(CustomLocale.BE_VENDOR_BUTTON_CONTINUE_TITLE.getString(context)))),
                          Expanded(child: CustomElevatedButton(onClick: details.onStepCancel, height: 76, child: Text(CustomLocale.BE_VENDOR_BUTTON_BACK_TITLE.getString(context)))),
                        ],
                      );
                    },
                    steps: [
                      Step(
                          title: Text(CustomLocale.BE_VENDOR_STEP_1_TITLE.getString(context)),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // - - - - - - - - - - - - - - - - - - CIN - - - - - - - - - - - - - - - - - -  //
                              Text(CustomLocale.BE_VENDOR_TITLE_1.getString(context), style: Theme.of(context).textTheme.titleLarge),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                              // - - - - - - - - - - - - - - - - - - CIN - - - - - - - - - - - - - - - - - -  //
                              CustomTextField(
                                  leadingIcon: Iconsax.card,
                                  controller: state.cinController!,
                                  hint: CustomLocale.BE_VENDOR_CIN.getString(context),
                                  textInputType: TextInputType.emailAddress,
                              ),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 8),

                              // - - - - - - - - - - - - - - - - - - CALL - - - - - - - - - - - - - - - - - -  //
                              CustomTextField(
                                  leadingIcon: Iconsax.call,
                                  controller: state.phoneController!,
                                  hint: CustomLocale.BE_VENDOR_PHONE.getString(context),
                                  textInputType: TextInputType.emailAddress),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 8),

                              // - - - - - - - - - - - - - - - - - - BIRTHDAY - - - - - - - - - - - - - - - - - -  //
                              CustomTextField(
                                  leadingIcon: Iconsax.cake,
                                  controller: state.birthdayController!,
                                  hint: CustomLocale.BE_VENDOR_BIRTHDAY.getString(context),
                                  textInputType: TextInputType.emailAddress),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                              // - - - - - - - - - - - - - - - - - - GENDER - - - - - - - - - - - - - - - - - -  //
                              Row(
                                children: [
                                  Text(CustomLocale.BE_VENDOR_GENDER_TITLE.getString(context), style: Theme.of(context).textTheme.titleLarge),
                                  const Spacer(),
                                  Row(
                                    children: [
                                      Radio(value: "Man", groupValue: state.gender, onChanged: context.read<BeVendorCubit>().onChangeGender, visualDensity: const VisualDensity(vertical: 0, horizontal: -2), activeColor: primaryColor(context)),
                                      Text(CustomLocale.BE_VENDOR_GENDER_MAN_TITLE.getString(context), style: Theme.of(context).textTheme.bodyMedium)
                                    ],
                                  ),
                                  const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                                  Row(
                                    children: [
                                      Radio(value: "Woman", groupValue: state.gender, onChanged: context.read<BeVendorCubit>().onChangeGender, visualDensity: const VisualDensity(vertical: 0, horizontal: -2), activeColor: primaryColor(context)),
                                      Text(CustomLocale.BE_VENDOR_GENDER_WOMAN_TITLE.getString(context), style: Theme.of(context).textTheme.bodyMedium)
                                    ],
                                  )
                                ],
                              ),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                            ],
                          ),
                          isActive: state.currentStep! >= 0,
                          state: state.currentStep! > 0 ? StepState.complete : StepState.disabled),
                      Step(
                          title: const Text("Step 2"),
                          content: const Text("Content 2"),
                          isActive: state.currentStep! >= 1,
                          state: state.currentStep! > 1 ? StepState.complete : StepState.disabled),
                      Step(
                          title: const Text("Step 3"),
                          content: const Text("Content 3"),
                          isActive: state.currentStep! >= 2,
                          state: state.currentStep! > 2 ? StepState.complete : StepState.disabled),
                    ]
                );
              }
            case BeVendorLoadingState(): return const CustomLoadingScreen();
            case BeVendorErrorState(): return CustomErrorScreen(onClick: (){});
          }
        },
      ),
    );
  }
}

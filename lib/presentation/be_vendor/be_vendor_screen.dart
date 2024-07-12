import 'dart:io';

import 'package:berkania/presentation/be_vendor/be_vendor_cubit.dart';
import 'package:berkania/presentation/be_vendor/widgets/step_personal_info.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/presentation/widgets/custom_success_screen.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_sizes.dart';
import '../../utils/extensions/validator.dart';
import '../../utils/localisation/custom_locale.dart';
import '../widgets/custom_text_field.dart';

class BeVendorScreen extends CustomState {
  const BeVendorScreen({super.key});

  @override
  Widget run(BuildContext context) {
    context.read<BeVendorCubit>().init(context: context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: context.pop,
            borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
            child: Builder(builder: (context) {
              return Icon(isArabic(context) ? Iconsax.arrow_right_3 : Iconsax.arrow_left_24, color: darkLightColor(context));
            })
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
                    onStepTapped: null,
                    onStepContinue: (){ context.read<BeVendorCubit>().continued(context: context); },
                    onStepCancel: context.read<BeVendorCubit>().cancel,
                    controlsBuilder: (BuildContext context, ControlsDetails details) => Row( children: [
                          Expanded(child: CustomElevatedButton(onClick: details.onStepCancel, height: 76, child: Text(CustomLocale.BE_VENDOR_BUTTON_BACK_TITLE.getString(context)))),
                          Expanded(child: CustomElevatedButton(onClick: details.onStepContinue, height: 76, child: Text(CustomLocale.BE_VENDOR_BUTTON_CONTINUE_TITLE.getString(context)))),
                        ] ),
                    steps: [
                      Step(
                          isActive: state.currentStep! >= 0,
                          state: state.currentStep! > 0 ? StepState.complete : StepState.disabled,
                          title: Text(CustomLocale.BE_VENDOR_STEP_1_TITLE.getString(context)),
                          content: StepPersonalInfo(
                            formState: state.personalInfoFormState!,
                              cinController: state.cinController,
                              phoneController: state.phoneController,
                              ageController: state.ageController,
                              gender: state.gender,
                              onChangeGender: context.read<BeVendorCubit>().onChangeGender)),
                      Step(
                          title: Text(CustomLocale.BE_VENDOR_STEP_2_TITLE.getString(context)),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // - - - - - - - - - - - - - - - - - - TITLE - - - - - - - - - - - - - - - - - -  //
                              Text(CustomLocale.BE_VENDOR_TITLE_2.getString(context), style: Theme.of(context).textTheme.titleLarge),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_DEFAULT),

                              // - - - - - - - - - - - - - - - - - - TITLE - - - - - - - - - - - - - - - - - -  //
                              Text(CustomLocale.BE_VENDOR_PICK_CAR_TYPE_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                              // - - - - - - - - - - - - - - - - - - RADIO BUTTONS VEHICLE TYPES - - - - - - - - - - - - - - - - - -  //
                              Row(
                                children: [
                                  Expanded(child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                                              border: Border.all(color: darkLightColor(context))),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                                            child: Image.asset(CustomImageStrings.CAR,
                                              height: getHeight(context),
                                              width: getWidth(context),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      Radio(
                                          value: "Car",
                                          groupValue: state.carType,
                                          onChanged: context.read<BeVendorCubit>().onChangeCarType,
                                          visualDensity: const VisualDensity(vertical: -2, horizontal: 0),
                                          activeColor: primaryColor(context)),
                                    ],
                                  )),
                                  const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                                  Expanded(child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                                              border: Border.all(color: darkLightColor(context))),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                                            child: Image.asset(CustomImageStrings.TRIPORTEUR,
                                              height: getHeight(context),
                                              width: getWidth(context),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      Radio(
                                          value: "Triporteur",
                                          groupValue: state.carType,
                                          onChanged: context.read<BeVendorCubit>().onChangeCarType,
                                          visualDensity: const VisualDensity(vertical: -2, horizontal: 0),
                                          activeColor: primaryColor(context)),
                                    ],
                                  )),
                                  const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                                  Expanded(child: Column(
                                    children: [
                                      Container(
                                          height: 70,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS /2 ),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                                            child: Image.asset(CustomImageStrings.HONDS,
                                              height: getHeight(context),
                                              width: getWidth(context),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      Radio(
                                          value: "Pick Up",
                                          groupValue: state.carType,
                                          onChanged: context.read<BeVendorCubit>().onChangeCarType,
                                          visualDensity: const VisualDensity(vertical: -2, horizontal: 0),
                                          activeColor: primaryColor(context)),
                                    ],
                                  )),
                                ],
                              ),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                              // - - - - - - - - - - - - - - - - - - TITLE - - - - - - - - - - - - - - - - - -  //
                              Text(CustomLocale.BE_VENDOR_CAR_THUMBNAIL_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                              // - - - - - - - - - - - - - - - - - - IMAGE - - - - - - - - - - - - - - - - - -  //
                              InkWell(
                                onTap: (){
                                  context.read<BeVendorCubit>().onPickCarImage(context: context);
                                },
                                borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                                child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                                        child: SizedBox(
                                          width: getWidth(context),
                                          height: 180.0,
                                          child: state.shopThumbnail! == "" ?
                                          Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                                  border: Border.all(color: darkLightColor(context))),
                                              child: Icon(Iconsax.car, size: 30.0, color: grayColor(context))) :
                                          Image.file(File(state.shopThumbnail!),
                                              height: getHeight(context),
                                              width: getWidth(context),
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, url, error) =>
                                                  Container(
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                                          border: Border.all(color: darkLightColor(context))),
                                                      child: Icon(Iconsax.car, size: 30.0, color: grayColor(context)))),
                                    ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                              padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 4),
                                              decoration: BoxDecoration(
                                                  color: darkDarkLightLightColor(context),
                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2))),
                                              child: Icon(
                                                Iconsax.gallery_edit,
                                                color: darkLightColor(context),
                                                size: 20.0,
                                              ))),
                                    ]
                                ),
                              ),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                              // - - - - - - - - - - - - - - - - - - TITLE - - - - - - - - - - - - - - - - - -  //
                              Text(CustomLocale.BE_VENDOR_CAR_INFO_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                              Form(
                                key: state.carInfoFormState,
                                child: Column(
                                  children: [
                                    // - - - - - - - - - - - - - - - - - - ASSURANCE NUMBER - - - - - - - - - - - - - - - - - -  //
                                    CustomTextField(
                                      leadingIcon: Iconsax.bookmark,
                                      controller: state.carAssuranceController!,
                                      hint: CustomLocale.BE_VENDOR_CAR_ASSURANCE_NUMBER_TITLE.getString(context),
                                      validator: (value) => Validator.validateCustomField(value, CustomLocale.VALIDATOR_CUSTOM_FIELD_ERROR1.getString(context)),
                                      textInputType: TextInputType.number,
                                    ),

                                    // - - - - - - - - - - - - - - - - - - REGISTRATION NUMBER - - - - - - - - - - - - - - - - - -  //
                                    CustomTextField(
                                        leadingIcon: Iconsax.bookmark,
                                        controller: state.carRegistrationController!,
                                        hint: CustomLocale.BE_VENDOR_CAR_REGISTRATION_NUMBER_TITLE.getString(context),
                                        validator: (value) => Validator.validateCustomField(value, CustomLocale.VALIDATOR_CUSTOM_FIELD_ERROR1.getString(context)),
                                        textInputType: TextInputType.number),
                                  ],
                                ),
                              ),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),
                            ],
                          ),
                          isActive: state.currentStep! >= 1,
                          state: state.currentStep! > 1 ? StepState.complete : StepState.disabled),
                      Step(
                          title: Text(CustomLocale.BE_VENDOR_STEP_3_TITLE.getString(context)),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // - - - - - - - - - - - - - - - - - - TITLE - - - - - - - - - - - - - - - - - -  //
                              Text(CustomLocale.BE_VENDOR_TITLE_3.getString(context), style: Theme.of(context).textTheme.titleLarge),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                              // - - - - - - - - - - - - - - - - - - TITLE CIN FRONT - - - - - - - - - - - - - - - - - -  //
                              Text(CustomLocale.BE_VENDOR_CIN_FRONT_THUMBNAIL_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                              // - - - - - - - - - - - - - - - - - - IMAGE CIN ( FRONT ) - - - - - - - - - - - - - - - - - -  //
                              InkWell(
                                onTap: (){ context.read<BeVendorCubit>().onPickCinFrontImage(context: context); },
                                borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                                child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                                        child: SizedBox(
                                          width: getWidth(context),
                                          height: 180,
                                          child:state.cinFrontImage == ""
                                              ? Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                                  border: Border.all(color: darkLightColor(context))),
                                              child: Icon(Iconsax.card, size: 30.0, color: grayColor(context)))
                                              : Image.file(File(state.cinFrontImage!),
                                              height: getHeight(context),
                                              width: getWidth(context),
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, url, error) =>
                                                  Container(
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                                          border: Border.all(color: darkLightColor(context))),
                                                      child: Icon(Iconsax.card, size: 30.0, color: grayColor(context)))),
                                        ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                              padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 4),
                                              decoration: BoxDecoration(
                                                  color: darkDarkLightLightColor(context),
                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2))),
                                              child: Icon(
                                                Iconsax.gallery_edit,
                                                color: darkLightColor(context),
                                                size: 20.0,
                                              ))),
                                    ]
                                ),
                              ),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_DEFAULT),

                              // - - - - - - - - - - - - - - - - - - TITLE CIN BACK- - - - - - - - - - - - - - - - - -  //
                              Text(CustomLocale.BE_VENDOR_CIN_BACK_THUMBNAIL_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                              // - - - - - - - - - - - - - - - - - - IMAGE CIN ( BACK ) - - - - - - - - - - - - - - - - - -  //
                              InkWell(
                                onTap: (){ context.read<BeVendorCubit>().onPickCinBackImage(context: context); },
                                borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                                child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                                        child: SizedBox(
                                          width: getWidth(context),
                                          height: 180,
                                          child: state.cinBackImage == ""
                                              ? Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                                  border: Border.all(color: darkLightColor(context))),
                                              child: Icon(Iconsax.card, size: 30.0, color: grayColor(context)))
                                              : Image.file(File(state.cinBackImage!),
                                              height: getHeight(context),
                                              width: getWidth(context),
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, url, error) =>
                                                  Container(
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                                          border: Border.all(color: darkLightColor(context))),
                                                      child: Icon(Iconsax.card, size: 30.0, color: grayColor(context)))),
                                        ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                              padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 4),
                                              decoration: BoxDecoration(
                                                  color: darkDarkLightLightColor(context),
                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2))),
                                              child: Icon(
                                                Iconsax.gallery_edit,
                                                color: darkLightColor(context),
                                                size: 20.0,
                                              ))),
                                    ]
                                ),
                              ),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_DEFAULT),

                              // - - - - - - - - - - - - - - - - - - TITLE CAR ASSURANCE - - - - - - - - - - - - - - - - - -  //
                              Text(CustomLocale.BE_VENDOR_CAR_ASSURANCE_NUMBER_THUMBNAIL_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                              // - - - - - - - - - - - - - - - - - - IMAGE CAR ASSURANCE - - - - - - - - - - - - - - - - - -  //
                              InkWell(
                                onTap: (){ context.read<BeVendorCubit>().onPickAssuranceCarImage(context: context); },
                                borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                                child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                                        child: SizedBox(
                                          width: getWidth(context),
                                          height: 180,
                                          child:
                                          state.carAssuranceImage == ""
                                              ? Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                                  border: Border.all(color: darkLightColor(context))),
                                              child: Icon(Iconsax.bookmark, size: 30.0, color: grayColor(context)))
                                              : Image.file(File(state.carAssuranceImage!),
                                              height: getHeight(context),
                                              width: getWidth(context),
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, url, error) =>
                                                  Container(
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                                          border: Border.all(color: darkLightColor(context))),
                                                      child: Icon(Iconsax.bookmark, size: 30.0, color: grayColor(context)))),
                                        ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                              padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 4),
                                              decoration: BoxDecoration(
                                                  color: darkDarkLightLightColor(context),
                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2))),
                                              child: Icon(
                                                Iconsax.gallery_edit,
                                                color: darkLightColor(context),
                                                size: 20.0,
                                              ))),
                                    ]
                                ),
                              ),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_DEFAULT),

                              // - - - - - - - - - - - - - - - - - - TITLE CAR REGISTRATION - - - - - - - - - - - - - - - - - -  //
                              Text(CustomLocale.BE_VENDOR_CAR_REGISTRATION_NUMBER_THUMBNAIL_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                              // - - - - - - - - - - - - - - - - - - IMAGE CAR REGISTRATION - - - - - - - - - - - - - - - - - -  //
                              InkWell(
                                onTap: (){ context.read<BeVendorCubit>().onPickRegistrationCarImage(context: context); },
                                borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                                child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                                        child: SizedBox(
                                          width: getWidth(context),
                                          height: 180,
                                          child:
                                          state.carRegistrationImage == ""
                                              ? Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                                  border: Border.all(color: darkLightColor(context))),
                                              child: Icon(Iconsax.archive_book, size: 30.0, color: grayColor(context)))
                                              : Image.file(File(state.carRegistrationImage!),
                                              height: getHeight(context),
                                              width: getWidth(context),
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, url, error) =>
                                                  Container(
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                                          border: Border.all(color: darkLightColor(context))),
                                                      child: Icon(Iconsax.archive_book, size: 30.0, color: grayColor(context)))),
                                        ),
                                      ),
                                      Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                              padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 4),
                                              decoration: BoxDecoration(
                                                  color: darkDarkLightLightColor(context),
                                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2))),
                                              child: Icon(
                                                Iconsax.gallery_edit,
                                                color: darkLightColor(context),
                                                size: 20.0,
                                              ))),
                                    ]
                                ),
                              ),

                              // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                              const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                            ],
                          ),
                          isActive: state.currentStep! >= 2,
                          state: state.currentStep! > 2 ? StepState.complete : StepState.disabled),
                    ]
                );
              }
            case BeVendorLoadingState(): return const CustomLoadingScreen();
            case BeVendorSuccessState():
              return CustomSuccessScreen(
                title: CustomLocale.BE_VENDOR_SUCCESS_STATE_TITLE.getString(context),
                subTitle: CustomLocale.BE_VENDOR_SUCCESS_STATE_SUB_TITLE.getString(context),
                buttonTitle: CustomLocale.BE_VENDOR_SUCCESS_STATE_BUTTON_TITLE.getString(context),
                onClick: context.pop,
              );
          }
        },
      ),
    );
  }
}

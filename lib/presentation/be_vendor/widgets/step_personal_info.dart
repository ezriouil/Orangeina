import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/extensions/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/localisation/custom_locale.dart';
import '../../../utils/state/custom_state.dart';
import '../../widgets/custom_text_field.dart';

class StepPersonalInfo extends CustomState {
  final TextEditingController? cinController, phoneController, ageController;
  final GlobalKey<FormState> formState;
  final String? gender;
  final void Function(String? value) onChangeGender;

  const StepPersonalInfo({super.key, required this.formState, this.cinController, this.phoneController, this.ageController, this.gender, required this.onChangeGender, });

  @override
  Widget run(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // - - - - - - - - - - - - - - - - - - TITLE - - - - - - - - - - - - - - - - - -  //
          Text(CustomLocale.BE_VENDOR_TITLE_1.getString(context), style: Theme.of(context).textTheme.titleLarge),

          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
          const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

          // - - - - - - - - - - - - - - - - - - CIN - - - - - - - - - - - - - - - - - -  //
          CustomTextField(
            leadingIcon: Iconsax.card,
            controller: cinController!,
            hint: CustomLocale.BE_VENDOR_CIN.getString(context),
            validator: (value) => Validator.validateEmptyField("Cin Required", value),
            textInputType: TextInputType.emailAddress,
          ),

          // - - - - - - - - - - - - - - - - - - CALL - - - - - - - - - - - - - - - - - -  //
          CustomTextField(
              leadingIcon: Iconsax.call,
              controller: phoneController!,
              hint: CustomLocale.BE_VENDOR_PHONE.getString(context),
              validator: (value) => Validator.validateMobilePhone(value),
              textInputType: TextInputType.phone),


          // - - - - - - - - - - - - - - - - - - BIRTHDAY - - - - - - - - - - - - - - - - - -  //
          CustomTextField(
              leadingIcon: Iconsax.cake,
              controller: ageController!,
              hint: CustomLocale.BE_VENDOR_BIRTHDAY.getString(context),
            validator: (value) => Validator.validateAge(value),
            textInputType: TextInputType.number,
          ),

          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

          // - - - - - - - - - - - - - - - - - - GENDER - - - - - - - - - - - - - - - - - -  //
          Row(
            children: [
              Text(CustomLocale.BE_VENDOR_GENDER_TITLE.getString(context), style: Theme.of(context).textTheme.titleLarge),
              const Spacer(),
              Row(
                children: [
                  Radio(value: "Man", groupValue: gender, onChanged: onChangeGender, visualDensity: const VisualDensity(vertical: 0, horizontal: -2), activeColor: primaryColor(context)),
                  Text(CustomLocale.BE_VENDOR_GENDER_MAN_TITLE.getString(context), style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
              const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
              Row(
                children: [
                  Radio(value: "Woman", groupValue: gender, onChanged: onChangeGender, visualDensity: const VisualDensity(vertical: 0, horizontal: -2), activeColor: primaryColor(context)),
                  Text(CustomLocale.BE_VENDOR_GENDER_WOMAN_TITLE.getString(context), style: Theme.of(context).textTheme.bodyMedium)
                ],
              )
            ],
          ),

          // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

        ],
      ),
    );
  }
}

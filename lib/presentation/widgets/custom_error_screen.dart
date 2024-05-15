import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../../utils/localisation/custom_locale.dart';
import '../../utils/state/custom_state.dart';

class CustomErrorScreen extends CustomState {
  final GestureTapCallback onClick;

  const CustomErrorScreen({super.key, required this.onClick});

  @override
  Widget run(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(CustomImageStrings.IMAGE_404, height: 150, width: getWidth(context)),
        const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
        Text(CustomLocale.ERROR_TITLE.getString(context), style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
        const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
        Text(CustomLocale.ERROR_SUB_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
        const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),
        InkWell(
            onTap:  onClick,
            borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
            overlayColor: MaterialStateProperty.all(CustomColors.TRANSPARENT),
            child: Text(
                CustomLocale.ERROR_BUTTON_TITLE.getString(context),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: primaryColor(context), letterSpacing: 0.5)
            )
        ),
      ],
    );
  }
}

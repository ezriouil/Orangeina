import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/custom_animations_strings.dart';
import '../../utils/constants/custom_colors.dart';

class CustomSuccessScreen extends CustomState {

  final String title, subTitle, buttonTitle;
  final GestureTapCallback onClick;
  const CustomSuccessScreen({ super.key, required this.title, required this.subTitle, required this.buttonTitle, required this.onClick });

  @override
  Widget run(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: getHeight(context),
        width: getWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              CustomAnimationStrings.SUCCESS_ANIMATION,
              width: 150.0,
              height: 150.0,
              repeat: true,
            ),

            const SizedBox(height: CustomSizes.SPACE_DEFAULT),
            Text(title, style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
            Text(subTitle, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
            const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),
            InkWell(
                onTap:  onClick,
                borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                overlayColor: MaterialStateProperty.all(CustomColors.TRANSPARENT),
                child: Text(buttonTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: primaryColor(context), letterSpacing: 0.5)
                )
            ),
          ],
        ),
      ),
    );
  }
}

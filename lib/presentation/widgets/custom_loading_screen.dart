import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/custom_animations_strings.dart';
import '../../utils/localisation/custom_locale.dart';

class CustomLoadingScreen extends CustomState {

  const CustomLoadingScreen({super.key});

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
              isDark(context) ? CustomAnimationStrings.LOADING_ANIMATION_LIGHT : CustomAnimationStrings.LOADING_ANIMATION_DARK,
              width: 120.0,
              height: 120.0,
              repeat: true,
            ),
            const SizedBox(height: CustomSizes.SPACE_DEFAULT ),
            Text(CustomLocale.LOADING_TITLE.getString(context), style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
            const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
            Text(CustomLocale.LOADING_SUB_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}

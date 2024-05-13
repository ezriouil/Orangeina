import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/custom_animations_strings.dart';

class CustomLoading {
  CustomLoading._();

  // - - - - - - - - - - - - - - - - - - START LOADING - - - - - - - - - - - - - - - - - -  //
  static Future<void> start() {
    return Get.defaultDialog(
        title: "Loading ...",
        titleStyle: Theme.of(Get.context!).textTheme.titleMedium,
        content: LottieBuilder.asset(
          Get.isDarkMode ? CustomAnimationStrings.LOADING_ANIMATION_LIGHT : CustomAnimationStrings.LOADING_ANIMATION_DARK,
          repeat: true,
          width: 90.0,
          height: 90.0,
        ),
        onWillPop: ()async{ return false;},
        titlePadding: const EdgeInsets.only(top: CustomSizes.SPACE_BETWEEN_ITEMS),
        contentPadding: EdgeInsets.zero,
        barrierDismissible: false);
  }

  // - - - - - - - - - - - - - - - - - - STOP LOADING - - - - - - - - - - - - - - - - - -  //
  static void stop() => Get.back();

}

/*
import 'package:flutter/material.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:iconsax/iconsax.dart';

class CustomSnackBars {
  CustomSnackBars._();

  // - - - - - - - - - - - - - - - - - - SUCCESS SNACK BAR - - - - - - - - - - - - - - - - - -  //
  static success({required String title, required String message, int duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: CustomColors.WHITE,
        backgroundColor: CustomColors.GREEN_DARK,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(8),
        overlayBlur: 1,
        icon: const Icon(
          Iconsax.chart_success,
          color: CustomColors.WHITE,
        ));
  }

  // - - - - - - - - - - - - - - - - - - ERROR SNACK BAR - - - - - - - - - - - - - - - - - -  //
  static error({required String title, required String message, int duration = 3, IconData? icon}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: CustomColors.WHITE,
        backgroundColor: CustomColors.RED_LIGHT,
        overlayBlur: 1,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(8),
        icon: Icon(icon ?? Icons.error_outline, color: CustomColors.WHITE));
  }

  // - - - - - - - - - - - - - - - - - - WARNING SNACK BAR - - - - - - - - - - - - - - - - - -  //
  static warning({required String title, required String message, int duration = 3}) {Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: CustomColors.BLACK,
        backgroundColor: CustomColors.YELLOW_DARK,
        overlayBlur: 1,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(8),
        icon: const Icon(Iconsax.warning_2, color: CustomColors.BLACK));
  }

}
*/

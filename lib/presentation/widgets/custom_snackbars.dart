import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:flutter/material.dart';

class CustomSnackBar {
  CustomSnackBar._();

  static void show({required BuildContext context,required String title,required String subTitle,required ContentType type, Color? color}){
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
          SnackBar(
            elevation: 0,
            width: double.infinity,
            behavior: SnackBarBehavior.floating,
            dismissDirection: DismissDirection.down,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              color: color ?? CustomColors.PRIMARY_LIGHT,
              title: title,
              message: subTitle,
              contentType: type,
            ),
          )
      );
  }

}
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';

import '../../utils/state/custom_state.dart';

class CustomElevatedButton extends CustomState {
  final Widget child;
  final void Function()? onClick;
  final double? width, height;
  final Color? backgroundColor, foregroundColor;
  final bool withDefaultPadding;

  const CustomElevatedButton(
      {super.key,
      required this.child,
      required this.onClick,
      this.width,
      this.height,
      this.backgroundColor,
      this.foregroundColor,
      this.withDefaultPadding = true});

  @override
  Widget run(BuildContext context) {
    return SizedBox(
      height: height ?? 74,
      width: width ?? getWidth(context),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: withDefaultPadding ? CustomSizes.SPACE_BETWEEN_ITEMS / 2 : 0,
            vertical: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
        child: ElevatedButton(
          onPressed: onClick,
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              backgroundColor: MaterialStateProperty.all(backgroundColor ?? primaryColor(context)),
              foregroundColor: MaterialStateProperty.all(foregroundColor ?? CustomColors.WHITE), 
              side: MaterialStateProperty.all(BorderSide(color: backgroundColor ?? CustomColors.PRIMARY_DARK.withOpacity(0.8))),
            shadowColor: MaterialStateProperty.all(backgroundColor ?? primaryColor(context))
          ),
          child: child,
        ),
      ),
    );
  }
}

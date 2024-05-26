import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/custom_sizes.dart';
import '../../../utils/state/custom_state.dart';

class CustomSettingTile extends CustomState {
  final String title, subTitle;
  final IconData icon;
  final Widget? trailing;
  final  GestureTapCallback? onClick;
  final double? titleSize, subTitleSize, iconSize;

  const CustomSettingTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.icon,
       this.onClick,
      this.iconSize = 32.0,
      this.titleSize = 14.0,
      this.subTitleSize = 12.0,
      this.trailing
      });

  @override
  Widget run(BuildContext context) {
    return InkWell(
      onTap: onClick,
      overlayColor: MaterialStateProperty.all(CustomColors.TRANSPARENT),
      child: Row(
        children: [
          Icon(icon, size:iconSize, color: grayColor(context)),
          const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS),
          Expanded(
            flex: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style : Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: titleSize)),
                Text(
                  subTitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: subTitleSize),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Spacer(),
          if(trailing != null ) Expanded(flex: 3, child: trailing!)
        ],
      ),
    );
  }
}

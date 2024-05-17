import 'package:flutter/material.dart';

import '../../../utils/constants/custom_sizes.dart';
import '../../../utils/state/custom_state.dart';

class CustomSettingTile extends CustomState {
  final String title, subTitle;
  final IconData icon;
  final Widget trailing;

  const CustomSettingTile(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.icon,
      required this.trailing});

  @override
  Widget run(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size:32, color: grayColor(context)),
        const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS),
        Expanded(
          flex: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style : Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14)),
              Text(
                subTitle, style:
                    Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const Spacer(),
        Expanded(flex: 3, child: trailing)
      ],
    );
  }
}

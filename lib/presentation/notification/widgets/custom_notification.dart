import 'package:berkania/domain/entities/notification_entity.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/custom_image_strings.dart';
import '../../../utils/localisation/custom_locale.dart';
import '../../../utils/state/custom_state.dart';

class CustomNotification extends CustomState {

  final NotificationEntity notificationEntity;
  final void Function(NotificationEntity notification) onClick;
  final void Function(String) onDelete;
  const CustomNotification({super.key, required this.notificationEntity, required this.onClick, required this.onDelete});

  @override
  Widget run(BuildContext context) {

    return InkWell(
      onTap: (){ onClick(notificationEntity); },
      overlayColor: MaterialStateProperty.all(CustomColors.TRANSPARENT),
      child: Container(
        padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
        margin: const EdgeInsets.symmetric(vertical : CustomSizes.SPACE_BETWEEN_ITEMS / 4, horizontal : CustomSizes.SPACE_BETWEEN_ITEMS / 2),
        decoration: BoxDecoration(border: Border.all(color: grayColor(context)), borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2), color: notificationEntity.isRead! ? CustomColors.TRANSPARENT : primaryColor(context).withOpacity(0.2)),
        width: getWidth(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Image.asset(CustomImageStrings.APP_LOGO_ICON, height: 24, width: 24),
              Text("  ${ CustomLocale.NOTIFICATION_TITLE.getString(context) }", style: Theme.of(context).textTheme.bodySmall),
              const Spacer(),
              Text("${notificationEntity.createAt!}  ", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.0)),
              InkWell(onTap: (){ onDelete(notificationEntity.id!); }, borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT), child: Transform.rotate(angle: 0.8, child: Icon(Iconsax.add_circle, size: 22.0, color: darkLightColor(context).withOpacity(0.4)))),
            ]),
            const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
            Text(notificationEntity.title ?? "", style: Theme.of(context).textTheme.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
            Text(
                notificationEntity.body!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

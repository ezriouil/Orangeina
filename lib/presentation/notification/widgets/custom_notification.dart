import 'package:berkania/domain/entities/notification_entity.dart';
import 'package:berkania/domain/entities/wishList_entity.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/state/custom_state.dart';

class CustomNotification extends CustomState {
  final NotificationEntity notificationEntity;
  final void Function(String id) onDelete;
  const CustomNotification({super.key, required this.notificationEntity, required this.onDelete});

  @override
  Widget run(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 4),
      margin: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
      decoration: BoxDecoration(border: Border.all(color: grayColor(context)), borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2)),
      width: getWidth(context),
      height: 120,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(children: [
                  Icon(Iconsax.user, size: 14.0, color: darkLightColor(context)),
                  Expanded(child: Text("  ${wishListEntity.fullName}", style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis)),
                  InkWell(onTap: (){ onDelete(wishListEntity.id ?? ""); }, borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT), child: Transform.rotate(angle: 0.8, child: Icon(Iconsax.add_circle, size: 22.0, color: darkLightColor(context)))),
                ]),
                Row(children: [
                  Icon(Iconsax.call, size: 14.0, color: darkLightColor(context)),
                  Expanded(child: Text("  ${wishListEntity.phone}", style: Theme.of(context).textTheme.bodySmall)),
                ]),
                Row(children: [
                  Icon(Iconsax.timer_1, size: 14.0, color: darkLightColor(context)),
                  Expanded(child: Text("  ${wishListEntity.createAt}", style: Theme.of(context).textTheme.bodySmall)),
                ]),
                RatingBar.builder(
                  itemCount: 5,
                  initialRating: wishListEntity.rating ?? 3,
                  maxRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemSize: 20.0,
                  itemPadding: EdgeInsets.zero,
                  itemBuilder: (context, _) => const Icon(Iconsax.star5, color: CustomColors.YELLOW_LIGHT),
                  onRatingUpdate: (double value) {  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

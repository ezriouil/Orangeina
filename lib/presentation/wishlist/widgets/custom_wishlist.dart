import 'package:berkania/domain/entities/wishList_entity.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/state/custom_state.dart';

class CustomWishList extends CustomState {
  final WishListEntity wishListEntity;
  final void Function(String id) onDelete;
  final GestureTapCallback onClick;
  const CustomWishList({super.key, required this.wishListEntity, required this.onDelete, required this.onClick});

  @override
  Widget run(BuildContext context) {

    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
      child: Container(
        padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 4),
        margin: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
        decoration: BoxDecoration(border: Border.all(color: grayColor(context)), borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2)),
        width: getWidth(context),
        height: 100,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                child: SizedBox(
                  width: getWidth(context),
                  height: getHeight(context),
                  child: Image.network( wishListEntity.avatar ?? "",
                      height: getHeight(context),
                      width: getWidth(context),
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) => loadingProgress == null ? child : Container(alignment: Alignment.center, decoration: BoxDecoration(borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS  / 2), border: Border.all(color: darkLightColor(context))), child: CircularProgressIndicator(color: primaryColor(context))),
                      errorBuilder: (context, url, error) => Container(alignment: Alignment.center, decoration: BoxDecoration(borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2), border: Border.all(color: darkLightColor(context))), child: Icon(Iconsax.gallery_remove, size: 30.0, color: grayColor(context)))),
                ),
              ),
            ),
            const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                  children: [
                    Icon(Iconsax.user, size: 14.0, color: darkLightColor(context)),
                    Expanded(child: Text("  ${wishListEntity.fullName}", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.0), maxLines: 1, overflow: TextOverflow.ellipsis)),
                    InkWell(onTap: (){ onDelete(wishListEntity.id ?? ""); }, borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT), child: Icon(Iconsax.close_circle, size: 22.0, color: darkLightColor(context))),
                  ]),
                  Row(children: [
                    Icon(Iconsax.call, size: 14.0, color: darkLightColor(context)),
                    Expanded(child: Text("  +212 ${wishListEntity.phoneNumber}", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.0))),
                  ]),
                  Row(children: [
                    Icon(Iconsax.timer_1, size: 14.0, color: darkLightColor(context)),
                    Expanded(child: Text("  ${wishListEntity.createAt}", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.0))),
                  ]),
                  RatingBar.builder(
                    itemCount: 5,
                    initialRating: (wishListEntity.rating ?? 3).toDouble(),
                    maxRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemSize: 18.0,
                    itemPadding: EdgeInsets.zero,
                    itemBuilder: (context, _) => const Icon(Iconsax.star5, color: CustomColors.PRIMARY_LIGHT),
                    onRatingUpdate: (double value) {  },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

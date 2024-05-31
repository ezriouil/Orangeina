import 'package:berkania/domain/entities/vendor_entity.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/state/custom_state.dart';

class CustomVendor extends CustomState {
  final VendorEntity vendorEntity;
  final  Function(VendorEntity vendorEntity) onClick;

  const CustomVendor({ super.key, required this.vendorEntity, required this.onClick });

  @override
  Widget run(BuildContext context) {

    return InkWell(
      onTap: (){ onClick(vendorEntity); },
      child: Container(
        padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 4),
        margin: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 4),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2), color: darkDarkLightLightColor(context)),
        height: 90,
        width: 250,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                child: SizedBox(
                  width: getWidth(context),
                  height: getHeight(context),
                  child: Image.network(vendorEntity.avatar ?? CustomImageStrings.DEFAULT_IMAGE_PROFILE,
                      height: getHeight(context),
                      width: getWidth(context),
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) => loadingProgress == null ? child : Container(alignment: Alignment.center, decoration: BoxDecoration(borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS  / 2), border: Border.all(color: darkDarkLightLightColor(context))), child: CircularProgressIndicator(color: primaryColor(context))),
                      errorBuilder: (context, url, error) => Container(alignment: Alignment.center, decoration: BoxDecoration(borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2), border: Border.all(color: darkDarkLightLightColor(context))), child: Icon(Iconsax.gallery_remove, size: 30.0, color: grayColor(context)))),
                ),
              ),
            ),
            const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("${vendorEntity.firstName} ${vendorEntity.lastName}", style: Theme.of(context).textTheme.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                  RatingBar.builder(
                    itemCount: 5,
                    initialRating: (vendorEntity.averageRating ?? 3.5).toDouble(),
                    maxRating: 5,
                    minRating: 1,
                    unratedColor: grayColor(context),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemSize: 12.0,
                    itemPadding: EdgeInsets.zero,
                    itemBuilder: (context, _) => const Icon(Iconsax.star5, color: CustomColors.PRIMARY_LIGHT),
                    onRatingUpdate: (double value) {  },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Iconsax.call, size: 12, color: darkLightColor(context)),
                      Text(" ${vendorEntity.phoneNumber ?? "06 00 00 00 00"}" , style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.0, color: darkLightColor(context)), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
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

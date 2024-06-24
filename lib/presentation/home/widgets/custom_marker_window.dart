import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/state/custom_state.dart';

class CustomMarkerWindow extends CustomState {
  final String id, firstName, lastName, avatar;
  final double distance;
  final num rating;

  const CustomMarkerWindow(
      {super.key,
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.avatar,
      required this.rating,
      required this.distance});

  @override
  Widget run(BuildContext context) {

    return InkWell(
      onTap: (){
        context.pushNamed(CustomRouter.VENDOR_DETAILS, pathParameters: { 'id' : id}); },
      child: Container(
        padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 4),
        margin: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
        decoration: BoxDecoration(border:Border.all(color: darkDarkLightLightColor(context)), borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2), color: darkLightColor(context)),
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
                  child: Image.network(avatar,
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
                  Text("$firstName $lastName", style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: darkDarkLightLightColor(context)), maxLines: 1, overflow: TextOverflow.ellipsis),
                  RatingBar.builder(
                    itemCount: 5,
                    initialRating: rating.toDouble(),
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
                      Icon(Iconsax.arrow_up, size: 15, color: darkDarkLightLightColor(context)),
                      Text("${distance.toStringAsFixed(2)} Km", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.0, color: darkDarkLightLightColor(context)), maxLines: 1, overflow: TextOverflow.ellipsis),
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

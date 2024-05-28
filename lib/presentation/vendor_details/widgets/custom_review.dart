import 'package:berkania/domain/entities/review_entity.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/state/custom_state.dart';

class CustomReview extends CustomState {
  final ReviewEntity review;

  const CustomReview(
      {super.key, required this.review });

  @override
  Widget run(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
      padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
      width: getWidth(context),
      decoration: BoxDecoration(border: Border.all( color: darkLightColor(context).withOpacity(0.2), width: 0.6 ), borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                child: SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: Image.network(review.avatar ?? CustomImageStrings.DEFAULT_IMAGE_PROFILE,
                      height: getHeight(context),
                      width: getWidth(context),
                      fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) => loadingProgress == null ? child : Container(alignment: Alignment.center, decoration: BoxDecoration(borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT), border: Border.all(color: darkLightColor(context))), child: CircularProgressIndicator(color: primaryColor(context))),
                      errorBuilder: (context, url, error) => Container(alignment: Alignment.center, decoration: BoxDecoration(borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT), border: Border.all(color: darkLightColor(context))), child: Icon(Iconsax.gallery_remove, size: 30.0, color: grayColor(context)))),
                ),
              ),
              const SizedBox(width: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // - - - - - - - - - - - - - - - - - -  FULL NAME - - - - - - - - - - - - - - - - - -  //
                    Text(review.fullName ?? "", style: Theme.of(context).textTheme.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // - - - - - - - - - - - - - - - - - -  RATING - - - - - - - - - - - - - - - - - -  //
                        RatingBar.builder(
                          itemCount: 5,
                          initialRating:  3,
                          maxRating: 5,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemSize: 12.0,
                          itemPadding: EdgeInsets.zero,
                          itemBuilder: (context, _) => const Icon(Iconsax.star5, color: CustomColors.PRIMARY_LIGHT),
                          onRatingUpdate: (double value) {  },
                        ),
                        // - - - - - - - - - - - - - - - - - -  CREATE AT - - - - - - - - - - - - - - - - - -  //
                        Text(review.createAt ?? "01/01/2025", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.0), maxLines: 1, overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

          // - - - - - - - - - - - - - - - - - -  REPORT BODY - - - - - - - - - - - - - - - - - -  //
          Text(review.reviewBody ?? "No Body" , style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

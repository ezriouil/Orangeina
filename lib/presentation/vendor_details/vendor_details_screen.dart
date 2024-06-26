import 'package:berkania/presentation/vendor_details/vendor_details_cubit.dart';
import 'package:berkania/presentation/vendor_details/widgets/custom_review.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:berkania/utils/constants/custom_txt_strings.dart';
import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_colors.dart';
import '../../utils/constants/custom_sizes.dart';

class VendorDetailsScreen extends CustomState {
  final String id;
  const VendorDetailsScreen({super.key, required this.id});

  @override
  Widget run(BuildContext context) {
    String idCheckVendor = "";
    return BlocBuilder<VendorDetailsCubit, VendorDetailsState>(
      builder: (context, state) {

        if(id != idCheckVendor){
          context.read<VendorDetailsCubit>().getVendorInfo(argumentId: id, context: context);
          idCheckVendor = id;
        }

        return Scaffold(
          appBar: switch(state){
            VendorDetailsMainState() => AppBar(
              leading: InkWell(
                  onTap: context.pop,
                  borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                  child: Icon(Iconsax.arrow_left_24, color: darkLightColor(context))),
              title: Text(CustomLocale.VENDOR_DETAILS_TITLE.getString(context), style: Theme.of(context).textTheme.bodyLarge),
              actions: [
                InkWell(
                  onTap: context.read<VendorDetailsCubit>().upsertVendorWishList,
                  borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                  child: Padding(
                    padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS),
                    child:  Icon(state.wishListId != "" ? Iconsax.heart5 : Iconsax.heart , color: state.wishListId != "" ? redColor(context) : darkLightColor(context)),
                  ),
                )
              ],
            ),
            VendorDetailsLoadingState() => null,
          },
          body: switch(state){
            VendorDetailsMainState() => Column(
              children: [
                Center(
                  child: ClipRRect(borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                    child: SizedBox(
                      width: 140.0,
                      height: 140.0,
                      child: Image.network(state.vendor?.shopThumbnail ?? CustomImageStrings.DEFAULT_IMAGE_PROFILE,
                          height: getHeight(context),
                          width: getWidth(context),
                          fit: BoxFit.cover,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) => loadingProgress == null
                              ? child
                              : Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
                                  border: Border.all(color: darkLightColor(context))),
                              child: CircularProgressIndicator(
                                  color: primaryColor(context))),
                          errorBuilder: (context, url, error) => Container(
                              alignment: Alignment.center,
                              decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT), border: Border.all(color: darkLightColor(context))),
                              child: Icon(Iconsax.gallery_remove, size: 30.0, color: grayColor(context)))),
                    ),
                  ),
                ),
                // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                const SizedBox(height: CustomSizes.SPACE_DEFAULT),

                // - - - - - - - - - - - - - - - - - -  SECTION TITLE ( JOB || VENDOR SECTION ) - - - - - - - - - - - - - - - - - -  //
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "${state.vendor?.firstName} ${state.vendor?.lastName} ",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(letterSpacing: 0.6),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    const Icon(Iconsax.verify5,
                        color: CustomColors.BLUE_LIGHT, size: 14.0)
                  ],
                ),

                // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                // - - - - - - - - - - - - - - - - - -  RATING - - - - - - - - - - - - - - - - - -  //
                RatingBar.builder(
                  itemCount: 5,
                  initialRating: state.vendorRating!,
                  maxRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemSize: 20.0,
                  itemPadding: EdgeInsets.zero,
                  itemBuilder: (context, _) => const Icon(Iconsax.star5, color: CustomColors.PRIMARY_LIGHT),
                  onRatingUpdate: (double value) {},
                ),

                // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                // - - - - - - - - - - - - - - - - - -  BUTTONS - - - - - - - - - - - - - - - - - -  //
                Row(
                  children: [
                    Expanded(
                        child: CustomElevatedButton(
                            backgroundColor: darkLightColor(context),
                            foregroundColor:
                            darkDarkLightLightColor(context),
                            onClick: () {
                              context.read<VendorDetailsCubit>().onGiveFeedback(context: context,
                                  argumentId: id,
                                  callBack: () {
                                    context.pop();
                                    context.read<VendorDetailsCubit>().getReviews(argumentId: id, context: context);
                                  });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Iconsax.star, size: 18.0),
                                Text("  ${CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_FEEDBACK.getString(context)}"),
                              ],
                            ))),
                    Expanded(
                        child: CustomElevatedButton(
                            backgroundColor: CustomColors.RED_LIGHT,
                            onClick: () {
                              context.read<VendorDetailsCubit>().onReport(
                                  context: context,
                                  callBack: () {
                                    context.pop(); //SNACK BAR
                                  });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Iconsax.danger, size: 18.0),
                                Text(
                                    "  ${CustomLocale.VENDOR_DETAILS_TITLE_BUTTON_REPORT.getString(context)}"),
                              ],
                            )))
                  ],
                ),

                // - - - - - - - - - - - - - - - - - -  TAB VIEW - - - - - - - - - - - - - - - - - -  //
                Expanded(
                  child: DefaultTabController(
                      length: 2,
                      child: Scaffold(
                        appBar: AppBar(
                          toolbarHeight: 44.0,
                          automaticallyImplyLeading: false,
                          flexibleSpace: TabBar(
                              dividerColor: CustomColors.TRANSPARENT,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicatorColor: darkLightColor(context),
                              tabs: [
                                Tab(
                                    icon: Text(
                                        CustomLocale.VENDOR_DETAILS_TITLE_TAB_MAP.getString(context),
                                        style: Theme.of(context).textTheme.bodyLarge,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)),
                                Tab(
                                    icon: Text(
                                        CustomLocale.VENDOR_DETAILS_TITLE_TAB_REVIEWS.getString(context),
                                        style: Theme.of(context).textTheme.bodyLarge,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)),
                              ]),
                        ),
                        body: TabBarView(children: [
                          
                          GoogleMap(
                            initialCameraPosition: const CameraPosition(target: LatLng(CustomTextStrings.INITAIL_LAT, CustomTextStrings.INITAIL_LNG), zoom: 5.0),
                            zoomControlsEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            trafficEnabled: false,
                            onTap: (latLng) {},
                            onMapCreated: context.read<VendorDetailsCubit>().onMapCompleted,
                            markers: state.markers!,
                          ),

                          RefreshIndicator(
                            onRefresh: () async{ context.read<VendorDetailsCubit>().refreshReviews(argumentId: id, context: context);},
                            color: primaryColor(context),
                            backgroundColor: darkLightColor(context),
                            child:
                            state.reviews!.isEmpty ?
                            Center(child: Text(CustomLocale.VENDOR_DETAILS_REVIEWS_EMPTY_LIST.getString(context), style: Theme.of(context).textTheme.bodyLarge)) :
                            ListView.builder(itemCount: state.reviews!.length, itemBuilder: (context, index) => CustomReview(review: state.reviews![index])))
                          ]),
                      )),
                )
              ],
            ),
            VendorDetailsLoadingState() => const CustomLoadingScreen(),
          },
        );
      },
    );
  }
}

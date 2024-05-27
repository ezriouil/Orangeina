import 'package:berkania/presentation/vendor_details/vendor_details_cubit.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/presentation/widgets/custom_error_screen.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: context.pop, borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS), child: Icon( Iconsax.arrow_left_24, color: darkLightColor(context))),
        title: Text("Vendor Details", style: Theme.of(context).textTheme.bodyLarge),
        actions: [Padding(
          padding: const EdgeInsets.symmetric(horizontal: CustomSizes.SPACE_BETWEEN_ITEMS / 1.5),
          child: InkWell(
            onTap: null,
            borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
            child: Icon( Iconsax.heart, color: darkLightColor(context)),
          ),
        )],
      ),
      body: BlocBuilder<VendorDetailsCubit, VendorDetailsState>(
        builder: (context, state) {
          switch(state){
            case VendorDetailsMainState():
              {
                context.read<VendorDetailsCubit>().argumentId = id;
                return Column(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                        child: SizedBox(
                          width: 140.0,
                          height: 140.0,
                          child: Image.network("https://lh3.googleusercontent.com/a/ACg8ocJQ7TblAi7I_QcIsp1krDRaAGnO5CaXF851LJcqKx_8CI9imcFD=s96-c",
                              height: getHeight(context),
                              width: getWidth(context),
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) => loadingProgress == null ? child : Container(alignment: Alignment.center, decoration: BoxDecoration(borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT), border: Border.all(color: darkLightColor(context))), child: CircularProgressIndicator(color: primaryColor(context))),
                              errorBuilder: (context, url, error) => Container(alignment: Alignment.center, decoration: BoxDecoration(borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT), border: Border.all(color: darkLightColor(context))), child: Icon(Iconsax.gallery_remove, size: 30.0, color: grayColor(context)))),
                        ),
                      ),
                    ),
                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_DEFAULT),

                    // - - - - - - - - - - - - - - - - - -  SECTION TITLE ( JOB || VENDOR SECTION ) - - - - - - - - - - - - - - - - - -  //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Mohamed Ezriouil ", style: Theme.of(context).textTheme.titleLarge?.copyWith(letterSpacing: 0.6), maxLines: 1, overflow: TextOverflow.ellipsis),
                         const Icon(Iconsax.verify5, color: CustomColors.BLUE_LIGHT, size: 14.0)
                      ],
                    ),

                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                    // - - - - - - - - - - - - - - - - - -  RATING - - - - - - - - - - - - - - - - - -  //
                    RatingBar.builder(
                      itemCount: 5,
                      initialRating:  3,
                      maxRating: 5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      itemSize: 20.0,
                      itemPadding: EdgeInsets.zero,
                      itemBuilder: (context, _) => const Icon(Iconsax.star5, color: CustomColors.PRIMARY_LIGHT),
                      onRatingUpdate: (double value) {  },
                    ),

                    // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                    // - - - - - - - - - - - - - - - - - -  BUTTONS - - - - - - - - - - - - - - - - - -  //
                    Row(
                      children: [
                        Expanded(
                            child: CustomElevatedButton(
                                backgroundColor: darkLightColor(context),
                                foregroundColor: darkDarkLightLightColor(context),
                                onClick: () { context.read<VendorDetailsCubit>().onGiveFeedback(context: context,callBack: (){
                                  context.pop();
                                  //SNACK BAR
                                }); },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.star, size: 18.0),
                            Text("  Feedback"),
                          ],
                        ))),
                        Expanded(
                            child: CustomElevatedButton(
                                backgroundColor: CustomColors.RED_LIGHT,
                                onClick: () {
                                  context.read<VendorDetailsCubit>().onReport(
                                      context: context,
                                      callBack: () {context.pop();//SNACK BAR
                                      });
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Iconsax.danger, size: 18.0),
                                    Text("  Report"),
                                  ],
                                )))
                      ],
                    ),

                    // - - - - - - - - - - - - - - - - - -  TAB VIEW - - - - - - - - - - - - - - - - - -  //
                    Expanded(
                      child: DefaultTabController(length: 2, child: Scaffold(
                            appBar: AppBar(toolbarHeight: 44.0,
                              flexibleSpace: TabBar(dividerColor: CustomColors.TRANSPARENT,indicatorSize: TabBarIndicatorSize.tab,  indicatorColor: darkLightColor(context), tabs: [
                                Tab(icon: Text("Map", style: Theme.of(context).textTheme.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis)),
                                Tab(icon: Text("Reviews", style: Theme.of(context).textTheme.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis)),
                              ]),
                            ),
                            body:
                        TabBarView( children: [
                          GoogleMap(
                            initialCameraPosition: const CameraPosition(target: LatLng(31.7071858, -7.9518629), zoom: 8.0),
                            zoomControlsEnabled: true,
                            myLocationButtonEnabled: false,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            trafficEnabled: false,
                            onTap: (latLng){  },
                            onMapCreated: context.read<VendorDetailsCubit>().onMapCompleted,
                            markers : state.markers!,
                          ),
                          SingleChildScrollView(child:
                              Container(
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
                                            child: Image.network("https://lh3.googleusercontent.com/a/ACg8ocJQ7TblAi7I_QcIsp1krDRaAGnO5CaXF851LJcqKx_8CI9imcFD=s96-c",
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
                                              Text("Mohamed Ezriouil", style: Theme.of(context).textTheme.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis),
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
                                                  Text("27/05/2024", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10.0), maxLines: 1, overflow: TextOverflow.ellipsis),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                                    // - - - - - - - - - - - - - - - - - -  FULL NAME - - - - - - - - - - - - - - - - - -  //
                                    Text("Mohamed Ezriouil", style: Theme.of(context).textTheme.bodyMedium),
                                  ],
                                ),
                              )
                          )
                        ]),
                      )),
                    )
                  ],
                 );
              }
            case VendorDetailsLoadingState(): return const CustomLoadingScreen();
            case VendorDetailsErrorState(): return CustomErrorScreen(onClick: (){});
          }
        },
      ),
    );
  }
}

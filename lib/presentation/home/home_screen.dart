import 'package:berkania/domain/entities/vendor_entity.dart';
import 'package:berkania/presentation/home/home_cubit.dart';
import 'package:berkania/presentation/home/widgets/custom_vendor.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_sizes.dart';
import '../widgets/custom_loading_screen.dart';

class HomeScreen extends CustomState {
  const HomeScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch(state){

            case HomeMainState() : {
              return Stack(
                children: [

                  GoogleMap(
                    initialCameraPosition: state.cameraCurrentLocation == null ? state.myCurrentLocation! : state.cameraCurrentLocation!,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    mapToolbarEnabled: false,
                    mapType: state.mapSatelliteEnabled! ? MapType.satellite : MapType.normal,
                    myLocationEnabled: state.mapMyLocationEnabled!,
                    trafficEnabled: state.mapTrafficEnabled!,
                    onTap: (latLng){
                      if(state.polyline!.isNotEmpty){
                        state.customInfoWindowController?.hideInfoWindow!();
                        state.polyline!.clear();
                      }
                      },
                    onCameraMove: context.read<HomeCubit>().onCameraMoved,
                    onMapCreated: context.read<HomeCubit>().onMapCompleted,
                    markers : state.markers!,
                    polylines: state.polyline!
                    ),

                  state.vendors!.isEmpty ?
                  Positioned(bottom: 0, child: Container(
                      width: getWidth(context),
                      height: 40,
                      alignment: Alignment.center,
                      color: primaryColor(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Iconsax.danger, size: 18.0, color: darkDarkLightLightColor(context)),
                          Text(CustomLocale.HOME_ERROR_VENDORS_NOT_FOUND.getString(context), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: darkDarkLightLightColor(context))),
                        ],
                      )
                  )) :
                  Positioned(bottom: 0,child: SizedBox(
                    width: getWidth(context),
                    height: state.vendors!.isEmpty ? 40 : 100,
                    child: FirestorePagination(
                      limit: state.vendors!.length >= 2 ? 2 : 1,
                      scrollDirection: Axis.horizontal,
                      viewType: ViewType.list,
                      bottomLoader: Center(child: CircularProgressIndicator(color: primaryColor(context))),
                      onEmpty: Container(
                          width: getWidth(context),
                          height: 40,
                          alignment: Alignment.center,
                          color: primaryColor(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Iconsax.danger, size: 18.0, color: darkDarkLightLightColor(context)),
                              Text(CustomLocale.HOME_ERROR_VENDORS_NOT_FOUND.getString(context), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: darkDarkLightLightColor(context))),
                            ],
                          )
                      ),
                      query: context.read<HomeCubit>().getAllVendors(),
                      itemBuilder: (context, documentSnapshot, index) {
                        final data = VendorEntity.fromJson(documentSnapshot.data() as Map<String, dynamic>);
                        return CustomVendor(
                            vendorEntity: data,
                            onClick: (VendorEntity vendor) {
                              context.read<HomeCubit>().onVendorClick(lat: vendor.shopLat, lng: vendor.shopLng, context: context);
                              },
                            myCurrentLocation: state.myCurrentLocation!.target);
                      },
                    ),
                  )),

                  SizedBox(
                    width: getWidth(context),
                    height: getHeight(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(height: CustomSizes.SPACE_DEFAULT),
                          FloatingActionButton(
                            heroTag: "hero1",
                            backgroundColor: primaryColor(context),
                            onPressed: (){ context.read<HomeCubit>().onMapSettings(context: context); },
                            child: const Icon(Iconsax.setting, size: 20.0, color: CustomColors.WHITE),
                          ),
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                          if(state.mapRefreshEnabled!)  FloatingActionButton(
                                heroTag: "hero2",
                                backgroundColor: primaryColor(context),
                            onPressed: (){ context.read<HomeCubit>().onRefreshVendors(context: context); },
                                child: const Icon(Iconsax.refresh, size: 20.0, color: CustomColors.WHITE),
                          ),
                          if(state.mapRefreshEnabled!) const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                          if(state.mapMyLocationEnabled!) FloatingActionButton(
                              heroTag: "hero3",
                              backgroundColor: primaryColor(context),
                              onPressed: (){context.read<HomeCubit>().onGetMyLocation(context: context);},
                              child: const Icon(Iconsax.gps, color: CustomColors.WHITE)
                          ),
                        ],
                      ),
                    ),
                  ),

                  CustomInfoWindow(
                    controller: state.customInfoWindowController!,
                    height: 90,
                    width: 250,
                    offset: 40,
                  ),

                ],
              );
            }
            case HomeLoadingState(): return const CustomLoadingScreen();
          }
        },
      ),
    );
  }
}


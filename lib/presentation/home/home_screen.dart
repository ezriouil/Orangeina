import 'package:berkania/presentation/home/home_cubit.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    onTap: (latLng){ state.customInfoWindowController!.hideInfoWindow!(); },
                    onCameraMove: context.read<HomeCubit>().onCameraMoved,
                    onMapCreated: context.read<HomeCubit>().onMapCompleted,
                    markers : state.markers!,
                    ),
                  SizedBox(
                    width: getWidth(context),
                    height: getHeight(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                            onPressed: (){ context.read<HomeCubit>().onMapSettings(context: context); },
                            child: Icon(Iconsax.setting, size: 20.0, color: darkLightColor(context)),
                          ),
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                          if(state.mapVendorsEnabled!) FloatingActionButton(
                                child: Icon(Iconsax.shop, size: 20.0, color: darkLightColor(context)),
                                onPressed: () { /*context.read<HomeCubit>().showVendors();*/ },
                          ),
                          if(state.mapVendorsEnabled!) const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                          if(state.mapRefreshEnabled!)  FloatingActionButton(
                                onPressed: context.read<HomeCubit>().onRefreshVendors,
                                child: Icon(Iconsax.refresh, size: 20.0, color: darkLightColor(context)),
                          ),
                          if(state.mapRefreshEnabled!) const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                          if(state.mapFilterEnabled!) FloatingActionButton(
                              onPressed: context.read<HomeCubit>().filterVendors,
                              child: Icon(Iconsax.filter, size: 20.0, color: darkLightColor(context))
                          ),
                          if(state.mapFilterEnabled!)  const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                          if(state.mapMyLocationEnabled!) FloatingActionButton(
                              onPressed: context.read<HomeCubit>().onGetMyLocation,
                              child: Icon(Iconsax.gps, color: darkLightColor(context))
                          ),
                          if(state.mapMyLocationEnabled!) const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                        ],
                      ),
                    ),
                  ),
                  CustomInfoWindow(
                    controller: state.customInfoWindowController!,
                    height: 90,
                    width: 250,
                    offset: 40,
                  )
                ],
              );
            }
            case HomeLoadingState(): return const CustomLoadingScreen();
            case HomeErrorState(): return Center(child: Text(state.message, style: Theme.of(context).textTheme.bodyLarge));
          }
        },
      ),
    );
  }
}

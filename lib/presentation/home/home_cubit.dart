import 'dart:async';

import 'package:berkania/domain/entities/vendor_entity.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../domain/repositories/vendor_repository.dart';
import '../settings/widgets/custom_settings_tile.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  final VendorRepository vendorRepository;

  // - - - - - - - - - - - - - - - - - - CONTRACTURE - - - - - - - - - - - - - - - - - -  //
  HomeCubit({ required this.vendorRepository }) : super(HomeLoadingState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  void init() async{

    final vendors = await vendorRepository.getAllVendors();
    final Position currentPosition = await Geolocator.getCurrentPosition();
    emit(HomeCurrentState(
        mapController:  Completer<GoogleMapController>(),
        cameraCurrentLocation:  null,
        mapMyLocationEnabled: true,
        mapRefreshEnabled: true,
        mapFilterEnabled: true,
        mapTrafficEnabled: false,
        mapSatelliteEnabled: false,
        mapVendorsEnabled: true,
        myCurrentLocation: CameraPosition(target: LatLng(currentPosition.latitude,currentPosition.longitude), zoom: 18.0),
        vendors:  vendors,
        markers: const {}
    ));

  }

  // - - - - - - - - - - - - - - - - - - CHECK IF MAP IS SETUP IT - - - - - - - - - - - - - - - - - -  //
  onMapCompleted(GoogleMapController mapController) {
    final HomeCurrentState updateState = state as HomeCurrentState;
    if(updateState.mapController!.isCompleted) return;
    updateState.mapController!.complete(mapController);
    emit(updateState);
  }

  // - - - - - - - - - - - - - - - - - - SHOW MY CURRENT LOCATION - - - - - - - - - - - - - - - - - -  //
  void onGetMyLocation() async{
    final currentState = state as HomeCurrentState;
    emit(HomeLoadingState());
    await Future.delayed(const Duration(milliseconds: 1000));
    emit(currentState.copyWith(cameraCurrentLocation: currentState.myCurrentLocation));
  }

  // - - - - - - - - - - - - - - - - - - CAMERA MOVED - - - - - - - - - - - - - - - - - -  //
  void onCameraMoved(CameraPosition newPosition){
    emit((state as HomeCurrentState).copyWith(cameraCurrentLocation: CameraPosition(target: newPosition.target, zoom: newPosition.zoom)));
  }

  // - - - - - - - - - - - - - - - - - - ADD MARKER TO MY POSITION - - - - - - - - - - - - - - - - - -  //
  Marker customMarker({required double lat, required double lng, required String title,  required String snippet, BitmapDescriptor? icon}){
    return Marker(
      markerId: MarkerId("$lat $lng"),
      position: LatLng(lat, lng),
      icon: icon ?? BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow( title: title, snippet: snippet ),
    );
  }

  // - - - - - - - - - - - - - - - - - -  UPDATE VENDORS LIST  - - - - - - - - - - - - - - - - - -  //
  Future<void> onRefreshVendors() async {
    final currentState = state as HomeCurrentState;
    final getVendors = await vendorRepository.getAllVendors();
    final markers = <Marker>{};
    final vendors = <VendorEntity>[];

    emit(HomeLoadingState());
    await Future.delayed(const Duration(milliseconds: 1000));

    for (VendorEntity vendor in getVendors) {
      vendors.add(vendor);
      markers.add(customMarker(lat: vendor.shopLat!, lng: vendor.shopLng!, title: "${vendor.firstName} ${vendor.lastName}", snippet: vendor.email!));
    }
    emit(currentState.copyWith(vendors: vendors, markers: markers));
  }

  // - - - - - - - - - - - - - - - - - -  MAP SETTINGS  - - - - - - - - - - - - - - - - - -  //
  void onMapSettings({ required BuildContext context}) async{
    final currentState = state as HomeCurrentState;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 300,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomSettingTile(
                    title: "Show My Location",
                    subTitle: "Enjoy the new theme design for you ...",
                    icon: Iconsax.location,
                    iconSize: 24.0,
                    titleSize: 12.0,
                    subTitleSize: 10.0,
                    trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                            value: currentState.mapMyLocationEnabled!,
                            onChanged: (value) {
                              emit(currentState.copyWith(mapMyLocationEnabled: value));
                              context.pop();
                            })),
                  ),
                  CustomSettingTile(
                    title: "Enable Map Satellite",
                    subTitle: "Enjoy the new theme design for you ...",
                    icon: Iconsax.map_1,
                    iconSize: 24.0,
                    titleSize: 12.0,
                    subTitleSize: 10.0,
                    trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                            value: currentState.mapSatelliteEnabled!,
                            onChanged: (value) {
                              emit(currentState.copyWith(mapSatelliteEnabled: value));
                              context.pop();
                            })
                    ),
                  ),
                  CustomSettingTile(
                    title: "Enable Map Traffic",
                    subTitle: "Enjoy the new theme design for you ...",
                    icon: Iconsax.route_square,
                    iconSize: 24.0,
                    titleSize: 12.0,
                    subTitleSize: 10.0,
                    trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                            value: currentState.mapTrafficEnabled!,
                            onChanged: (value) {
                              emit(currentState.copyWith(mapTrafficEnabled: value));
                              context.pop();
                            })
                    ),
                  ),
                  CustomSettingTile(
                    title: "Enable Map Filter",
                    subTitle: "Enjoy the new theme design for you ...",
                    icon: Iconsax.filter,
                    iconSize: 24.0,
                    titleSize: 12.0,
                    subTitleSize: 10.0,
                    trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                            value: currentState.mapFilterEnabled!,
                            onChanged: (value) {
                              emit(currentState.copyWith(mapFilterEnabled: value));
                              context.pop();
                            })
                    ),
                  ),
                  CustomSettingTile(
                    title: "Enable Map Refresh",
                    subTitle: "Enjoy the new theme design for you ...",
                    icon: Iconsax.refresh,
                    iconSize: 24.0,
                    titleSize: 12.0,
                    subTitleSize: 10.0,
                    trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                            value: currentState.mapRefreshEnabled!,
                            onChanged: (value) {
                              emit(currentState.copyWith(mapRefreshEnabled: value));
                              context.pop();
                            })
                    ),
                  ),
                  CustomSettingTile(
                    title: "Enable Map Vendors",
                    subTitle: "Enjoy the new theme design for you ...",
                    icon: Iconsax.shop,
                    iconSize: 24.0,
                    titleSize: 12.0,
                    subTitleSize: 10.0,
                    trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                            value: currentState.mapVendorsEnabled!,
                            onChanged: (value) {
                              emit(currentState.copyWith(mapVendorsEnabled: value));
                              context.pop();
                            })
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  // - - - - - - - - - - - - - - - - - -  FILTER VENDORS ON MAP  - - - - - - - - - - - - - - - - - -  //
  filterVendors() {}

}

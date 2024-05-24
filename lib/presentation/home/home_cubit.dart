import 'dart:async';
import 'dart:ui' as ui;

import 'package:berkania/domain/entities/vendor_entity.dart';
import 'package:berkania/presentation/home/widgets/custom_marker_window.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../domain/repositories/vendor_repository.dart';
import '../../utils/local/storage/local_storage.dart';
import '../../utils/localisation/custom_locale.dart';
import '../settings/widgets/custom_settings_tile.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  final VendorRepository vendorRepository;
  final GetStorage storage;
  String? uid;

  // - - - - - - - - - - - - - - - - - - CONTRACTURE - - - - - - - - - - - - - - - - - -  //
  HomeCubit({ required this.vendorRepository, required this.storage }) : super(HomeLoadingState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  void init() async{

    /// GET ALL VENDORS
    final vendors = await vendorRepository.getAllVendors();


    /// CHECK PERMISSION IS GRANTED OR NOT TO GET CURRENT LOCATION
    final Position? currentPosition;
    final isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    final permission = await Geolocator.checkPermission();
    if (!isLocationServiceEnabled || permission == LocationPermission.denied || permission == LocationPermission.deniedForever) { currentPosition = null; }
    else { currentPosition =  await Geolocator.getCurrentPosition(); }

    /// EMIT STATE
    emit(HomeMainState(
        mapController:  Completer<GoogleMapController>(),
        cameraCurrentLocation:  null,
        mapMyLocationEnabled: true,
        mapRefreshEnabled: true,
        mapFilterEnabled: true,
        mapTrafficEnabled: false,
        mapSatelliteEnabled: false,
        mapVendorsEnabled: true,
        customInfoWindowController: CustomInfoWindowController(),
        myCurrentLocation: CameraPosition(target: LatLng(currentPosition?.latitude ?? 31.6538843,currentPosition?.longitude ?? -7.4565771), zoom: currentPosition == null ? 6.0 : 18.0),
        vendors:  vendors,
        markers: const {}
    ));

    uid = await LocalStorage.read(key: "UID", storage: storage) ?? "";

    await onRefreshVendors();

    /// PERIODIC TIMER TO REFRESH VENDORS ON MAP
    Timer.periodic(const Duration(minutes: 1), (time) async{ await onRefreshVendors(); });
  }

  // - - - - - - - - - - - - - - - - - - CHECK IF MAP IS SETUP IT - - - - - - - - - - - - - - - - - -  //
  onMapCompleted(GoogleMapController mapController) {
    final HomeMainState updateState = state as HomeMainState;
    if(updateState.mapController!.isCompleted) return;
    updateState.mapController!.complete(mapController);
    updateState.customInfoWindowController!.googleMapController = mapController;
    emit(updateState);
  }

  // - - - - - - - - - - - - - - - - - - SHOW MY CURRENT LOCATION - - - - - - - - - - - - - - - - - -  //
  void onGetMyLocation() async{
    final currentState = state as HomeMainState;
    emit(HomeLoadingState());
    final currentPosition = await Geolocator.getCurrentPosition();
    await Future.delayed(const Duration(milliseconds: 500));
    emit(currentState.copyWith(cameraCurrentLocation: CameraPosition(target: LatLng(currentPosition.latitude, currentPosition.longitude),zoom: 18.0 )));
  }

  // - - - - - - - - - - - - - - - - - - CAMERA MOVED - - - - - - - - - - - - - - - - - -  //
  void onCameraMoved(CameraPosition newPosition){
    final currentState = (state as HomeMainState);
    currentState.customInfoWindowController!.onCameraMove!();
    emit(currentState.copyWith(cameraCurrentLocation: CameraPosition(target: newPosition.target, zoom: newPosition.zoom)));
  }

  // - - - - - - - - - - - - - - - - - -  UPDATE VENDORS LIST  - - - - - - - - - - - - - - - - - -  //
  Future<void> onRefreshVendors() async {

    final currentState = state as HomeMainState;
    final getVendors = await vendorRepository.getAllVendors();
    final markers = <Marker>{};
    final vendors = <VendorEntity>[];

    for (VendorEntity vendor in getVendors) {
      if(vendor.id! == uid) continue;
      vendors.add(vendor);
      markers.add(await customMarker(
          lat: vendor.shopLat!,
          lng: vendor.shopLng!,
          avatar: vendor.avatar!,
          firstName: vendor.firstName!,
          lastName: vendor.lastName!,
          rating: vendor.averageRating!,
          distance: 135.8));

    }

    emit(currentState.copyWith(vendors: vendors, markers: markers));

  }

  // - - - - - - - - - - - - - - - - - -  MAP SETTINGS  - - - - - - - - - - - - - - - - - -  //
  void onMapSettings({ required BuildContext context}) async{
    final currentState = state as HomeMainState;
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
                    title: CustomLocale.HOME_SHOW_MY_LOCATION_TITLE.getString(context),
                    subTitle: CustomLocale.HOME_SHOW_MY_LOCATION_SUB_TITLE.getString(context),
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
                    title: CustomLocale.HOME_ENABLE_MAP_SATELLITE_TITLE.getString(context),
                    subTitle: CustomLocale.HOME_ENABLE_MAP_SATELLITE_SUB_TITLE.getString(context),
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
                    title: CustomLocale.HOME_ENABLE_MAP_TRAFFIC_TITLE.getString(context),
                    subTitle: CustomLocale.HOME_ENABLE_MAP_TRAFFIC_SUB_TITLE.getString(context),
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
                    title: CustomLocale.HOME_ENABLE_MAP_FILTER_TITLE.getString(context),
                    subTitle: CustomLocale.HOME_ENABLE_MAP_FILTER_SUB_TITLE.getString(context),
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
                    title: CustomLocale.HOME_ENABLE_MAP_REFRESH_TITLE.getString(context),
                    subTitle: CustomLocale.HOME_ENABLE_MAP_REFRESH_SUB_TITLE.getString(context),
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
                    title: CustomLocale.HOME_ENABLE_MAP_VENDORS_TITLE.getString(context),
                    subTitle: CustomLocale.HOME_ENABLE_MAP_VENDORS_SUB_TITLE.getString(context),
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

  // - - - - - - - - - - - - - - - - - - MARKER - - - - - - - - - - - - - - - - - -  //
  Future<Marker> customMarker(
      {required double lat,
      required double lng,
      required String avatar,
      required String firstName,
      required String lastName,
      required num rating,
      required double distance}) async{
    final customIcon = BitmapDescriptor.fromBytes(await _getBytesFromAsset(CustomImageStrings.MARKER_SELLER, 120));
    return Marker(
        markerId: MarkerId("$lat $lng"),
        position: LatLng(lat, lng),
        icon: customIcon,
        onTap: () {
          (state as HomeMainState).customInfoWindowController!.addInfoWindow!(
              CustomMarkerWindow(
                  firstName: firstName,
                  lastName: lastName,
                  avatar: avatar,
                  rating: rating,
                  distance: distance),
              LatLng(lat, lng));
        });
  }

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

}

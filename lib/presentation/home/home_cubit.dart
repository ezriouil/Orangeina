import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/domain/entities/vendor_entity.dart';
import 'package:berkania/presentation/home/widgets/custom_marker_window.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:berkania/utils/constants/custom_txt_strings.dart';
import 'package:berkania/utils/helpers/network.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../domain/repositories/vendor_repository.dart';
import '../../utils/local/storage/local_storage.dart';
import '../../utils/localisation/custom_locale.dart';
import '../settings/widgets/custom_settings_tile.dart';
import '../widgets/custom_snackbars.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  final VendorRepository vendorRepository;
  final GetStorage storage;
  final Connectivity connectivity;
  String? uid;
  final BuildContext context;

  // - - - - - - - - - - - - - - - - - - CONTRACTURE - - - - - - - - - - - - - - - - - -  //
  HomeCubit({ required this.context, required this.vendorRepository, required this.storage, required this.connectivity }) : super(
      HomeMainState(
        mapController:  Completer<GoogleMapController>(),
        cameraCurrentLocation:  null,
        mapMyLocationEnabled: true,
        mapRefreshEnabled: false,
        mapTrafficEnabled: false,
        mapSatelliteEnabled: false,
        customInfoWindowController: CustomInfoWindowController(),
        myCurrentLocation: const CameraPosition(target: LatLng(CustomTextStrings.INITAIL_LAT,CustomTextStrings.INITAIL_LNG), zoom: 6.0),
        vendors: const [],
        markers: const {},
        polyline: const {},
      )
  ){ init(context: context); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  void init({ required BuildContext context }) async{

    final currentState = state as HomeMainState;

    emit(HomeLoadingState());

    try{
      /// GET ALL VENDORS + CLEAR POLY LIEN
      if(currentState.polyline!.isNotEmpty) {
        currentState.polyline!.clear();
        emit(currentState.copyWith(cameraCurrentLocation: const CameraPosition(target: LatLng(CustomTextStrings.INITAIL_LAT,CustomTextStrings.INITAIL_LNG), zoom: 6.0)));
      }

      final vendors = await vendorRepository.getAllVendors();

      /// CHECK PERMISSION IS GRANTED OR NOT TO GET CURRENT LOCATION
      final Position? currentPosition;
      final isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
      final permission = await Geolocator.checkPermission();
      if (!isLocationServiceEnabled || permission == LocationPermission.denied || permission == LocationPermission.deniedForever) { currentPosition = null; }
      else { currentPosition =  await Geolocator.getCurrentPosition(); }

      /// EMIT STATE
      emit(currentState.copyWith(
        myCurrentLocation: CameraPosition(
            target: LatLng(
                currentPosition?.latitude ?? CustomTextStrings.INITAIL_LAT,
                currentPosition?.longitude ?? CustomTextStrings.INITAIL_LNG),
            zoom: 6.0),
        vendors:  vendors,
      ));

      uid = await LocalStorage.read(key: "UID", storage: storage);

      if(uid == null) {
        await LocalStorage.upsert(key: "INIT_LOCATION", value: "LOGIN", storage: storage);
        context.pushReplacementNamed(CustomRouter.LOGIN);
        return;
      }

      /// PERIODIC TIMER TO REFRESH VENDORS ON MAP
      await onRefreshVendors(context: context);
      Timer.periodic(const Duration(minutes: 1), (time) async{
        await onRefreshVendors(context: context); });
    }catch(_){ emit(currentState); }

  }

  // - - - - - - - - - - - - - - - - - - CHECK IF MAP IS SETUP IT - - - - - - - - - - - - - - - - - -  //
  onMapCompleted(GoogleMapController mapController) {
    final HomeMainState updateState = state as HomeMainState;
    updateState.customInfoWindowController!.googleMapController = mapController;
    if(updateState.mapController!.isCompleted) return;
    updateState.mapController!.complete(mapController);
    emit(updateState);
  }

  // - - - - - - - - - - - - - - - - - - GET VENDORS - - - - - - - - - - - - - - - - - -  //
  Query<Map<String, dynamic>> getAllVendors() => FirebaseFirestore.instance.collection('VENDORS').where('visible', isEqualTo: true).where('isOnline', isEqualTo: true).where('id', isNotEqualTo: uid);

  // - - - - - - - - - - - - - - - - - - CLICK SPECIFIC VENDOR - - - - - - - - - - - - - - - - - -  //
  onVendorClick({ required num? lat, required num? lng , required BuildContext context}) async{

    try{

      // CHECK CONNECTION INTERNET
      final hasConnection = await Network.hasConnection(connectivity);
      if(!hasConnection && context.mounted){
        CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
        return;
      }

      final currentState = state as HomeMainState;
      final polyline = <Polyline>{};

      const String apiKey = CustomTextStrings.GOOGLE_API_KEY;
      final String start = '${currentState.myCurrentLocation!.target.longitude},${currentState.myCurrentLocation!.target.latitude}';
      final String end = '${(lng ?? 0.0) as double},${(lat ?? 0.0) as double}';
      final String uri = '${CustomTextStrings.POLYLINE_BASE_URI}?api_key=$apiKey&start=$start&end=$end';

      final response = await http.get(Uri.parse(uri));
      final List<dynamic> listOfPoints = jsonDecode(response.body)['features'][0]['geometry']['coordinates'];
      final points = listOfPoints.map((p) => LatLng(p[1].toDouble(), p[0].toDouble())).toList();

      polyline.add(Polyline(polylineId: const PolylineId("polylineId"), points: points, width: 8, color: CustomColors.PRIMARY_LIGHT, startCap: Cap.roundCap, endCap: Cap.roundCap));

      emit(HomeLoadingState());
      await Future.delayed(const Duration(milliseconds: 300));

      emit(currentState.copyWith(
          cameraCurrentLocation: CameraPosition(target: LatLng((lat as double), (lng as double)),zoom: 14.0 ),
          polyline: polyline
      ));
    }catch(_){
    CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.HOME_ERROR_GET_VENDOR_SUB_TITLE.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT);
    }
  }

  // - - - - - - - - - - - - - - - - - - SHOW MY CURRENT LOCATION - - - - - - - - - - - - - - - - - -  //
  void onGetMyLocation({ required BuildContext context }) async{
    try{

      // CHECK CONNECTION INTERNET
      final hasConnection = await Network.hasConnection(connectivity);
      if(!hasConnection && context.mounted){
        CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
        return;
      }

      final currentState = state as HomeMainState;
      emit(HomeLoadingState());
      final currentPosition = await Geolocator.getCurrentPosition();
      await Future.delayed(const Duration(milliseconds: 300));
      emit(currentState.copyWith(cameraCurrentLocation: CameraPosition(target: LatLng(currentPosition.latitude, currentPosition.longitude),zoom: 18.0 )));
    }catch(_){
      if(context.mounted) CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.HOME_ERROR_GET_CURRENT_LOCATION_SUB_TITLE.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT);
    }
  }

  // - - - - - - - - - - - - - - - - - - CAMERA MOVED - - - - - - - - - - - - - - - - - -  //
  void onCameraMoved(CameraPosition newPosition){
    final currentState = state as HomeMainState;
    currentState.customInfoWindowController!.onCameraMove!();
    emit(currentState.copyWith(cameraCurrentLocation: CameraPosition(target: newPosition.target, zoom: newPosition.zoom)));
  }

  // - - - - - - - - - - - - - - - - - -  UPDATE VENDORS LIST  - - - - - - - - - - - - - - - - - -  //
  Future<void> onRefreshVendors({ required BuildContext context }) async {
    final currentState = state as HomeMainState;
    final getVendors = await vendorRepository.getAllVendors();
    final markers = <Marker>{};
    final vendors = <VendorEntity>[];

    for (VendorEntity vendor in getVendors) {

      if(vendor.id! == uid) continue;
      vendors.add(vendor);
      markers.add(await customMarker(
        context: context,
          lat: vendor.shopLat! as double,
          lng: vendor.shopLng! as double,
          avatar: vendor.shopThumbnail!,
          id: vendor.id!,
          firstName: vendor.firstName!,
          lastName: vendor.lastName!,
          rating: vendor.averageRating!,
          distance: 104.5
      ));
    }

    emit(currentState.copyWith(vendors: vendors, markers: markers));

  }

  // - - - - - - - - - - - - - - - - - -  MAP SETTINGS  - - - - - - - - - - - - - - - - - -  //
  void onMapSettings({ required BuildContext context}) async{

    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }

    final currentState = state as HomeMainState;
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              height: 200,
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
                ],
              ),
            ),
          );
        });
  }

  // - - - - - - - - - - - - - - - - - - MARKER - - - - - - - - - - - - - - - - - -  //
  Future<Marker> customMarker({required BuildContext context, required double lat, required double lng, required String avatar, required String id, required String firstName, required String lastName, required num rating, required double distance}) async{
    final customIcon = BitmapDescriptor.fromBytes(await _getBytesFromAsset(CustomImageStrings.MARKER_SELLER, 120));
    return Marker(
        markerId: MarkerId("$lat $lng"),
        position: LatLng(lat, lng),
        icon: customIcon,
        onTap: () async{

          // CHECK CONNECTION INTERNET
          final hasConnection = await Network.hasConnection(connectivity);
          if(!hasConnection) return;

          final currentState = state as HomeMainState;

            // POLYLINE
            final polyline = <Polyline>{};
            const String apiKey = CustomTextStrings.GOOGLE_API_KEY;
            final String start = '${currentState.myCurrentLocation!.target.longitude},${currentState.myCurrentLocation!.target.latitude}';
            final String end = '$lng,$lat';
            final String uri = '${CustomTextStrings.POLYLINE_BASE_URI}?api_key=$apiKey&start=$start&end=$end';
            try{
              final response = await http.get(Uri.parse(uri));
              final List<dynamic> listOfPoints = jsonDecode(response.body)['features'][0]['geometry']['coordinates'];
              final points = listOfPoints.map((p) => LatLng(p[1].toDouble(), p[0].toDouble())).toList();
              polyline.add(Polyline(polylineId: const PolylineId("polylineId"), points: points, width: 6, color: CustomColors.PRIMARY_LIGHT, startCap: Cap.roundCap, endCap: Cap.roundCap));

              // CALCULATE DISTANCE
              const double p = 0.017453292519943295;
              final double a = 0.5 - cos((lat - currentState.myCurrentLocation!.target.latitude) * p) / 2 + cos(currentState.myCurrentLocation!.target.latitude * p) * cos(lat * p) * (1 - cos((lng - currentState.myCurrentLocation!.target.longitude) * p)) / 2;
              final double distance = ((12742 * asin(sqrt(a))));


              // ADD WINDOW INFO
              currentState.customInfoWindowController!.addInfoWindow!(
                CustomMarkerWindow(
                    id: id,
                    firstName: firstName,
                    lastName: lastName,
                    avatar: avatar,
                    rating: rating,
                    distance: distance),
                LatLng(lat, lng),
              );
              emit(currentState.copyWith(polyline: polyline));
            }
            catch(e){
              CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.HOME_ERROR_GET_VENDOR_SUB_TITLE.getString(context), type: ContentType.failure, color: CustomColors.RED_LIGHT);
              FirebaseCrashlytics.instance.log("Error Adding Polyline"); }
        }
        );
  }
  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // Radius of the Earth in kilometers
    final dLat = _degToRad(lat2 - lat1);
    final dLon = _degToRad(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degToRad(lat1)) * cos(_degToRad(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);
    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return R * c; // Distance in kilometers
  }

  double _degToRad(double deg) {
    return deg * (pi / 180);
  }
}

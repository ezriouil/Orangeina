import 'dart:async';

import 'package:berkania/domain/entities/vendor_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/repositories/vendor_repository.dart';

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
        myCurrentLocation: CameraPosition(target: LatLng(currentPosition.latitude,currentPosition.longitude), zoom: 19.0),
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
  void myLocation() async{
    final currentState = state as HomeCurrentState;
    emit(HomeLoadingState());
    await Future.delayed(const Duration(milliseconds: 1000));
    emit(currentState.copyWith(cameraCurrentLocation: currentState.myCurrentLocation));
  }

  // - - - - - - - - - - - - - - - - - - CAMERA POSITION - - - - - - - - - - - - - - - - - -  //
  void onCameraMoved(CameraPosition newPosition){
    emit((state as HomeCurrentState).copyWith(cameraCurrentLocation: CameraPosition(target: newPosition.target, zoom: newPosition.zoom)));
  }

  // - - - - - - - - - - - - - - - - - - ADD MARKER TO MY POSITION - - - - - - - - - - - - - - - - - -  //
  Marker customMarker({required double lat, required double lng, required String title,  required String snippet, BitmapDescriptor? icon}){
    return Marker(
      markerId: const MarkerId('place_name'),
      position: LatLng(lat, lng),
       icon: icon ?? BitmapDescriptor.defaultMarker,
      infoWindow: InfoWindow(
        title: title,
        snippet: snippet,
      ),
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

  // - - - - - - - - - - - - - - - - - -  FILTER VENDORS ON MAP  - - - - - - - - - - - - - - - - - -  //
  filterVendors() {}

}

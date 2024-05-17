import 'dart:async';

import 'package:berkania/domain/entities/vendor_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/repositories/vendor_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final VendorRepository vendorRepository;
  HomeCubit({ required this.vendorRepository }) : super(HomeLoadingState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  void init() async{

    await Future.delayed(const Duration(milliseconds: 1000));

    final isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    final isLocationPermissionGranted = await Geolocator.isLocationServiceEnabled();
    if(!isLocationServiceEnabled || !isLocationPermissionGranted){
      emit(HomePermissionState());
      return;
    }

    await onRequestPermission();

  }

  // - - - - - - - - - - - - - - - - - - CHECK IF MAP IS SETUP IT - - - - - - - - - - - - - - - - - -  //
  onMapCompleted(GoogleMapController mapController) {
    final HomeCurrentState updateState = state as HomeCurrentState;
    if(updateState.mapController!.isCompleted) return;
    updateState.mapController!.complete(mapController);
    emit(updateState);
  }

  // - - - - - - - - - - - - - - - - - - GO TO DESTINATION - - - - - - - - - - - - - - - - - -  //
  void animateTo({ required LatLng latLng}) async{
    final currentState = state as HomeCurrentState;
    final mapController = await currentState.mapController?.future;
    final newPosition = CameraPosition(target: LatLng(latLng.latitude, latLng.longitude), zoom: 18);
    await mapController?.animateCamera(CameraUpdate.newCameraPosition(newPosition));
  }

  // - - - - - - - - - - - - - - - - - - SHOW MY CURRENT LOCATION - - - - - - - - - - - - - - - - - -  //
  void myLocation({required double lat, required double lng}) async{
    final isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    final isLocationPermissionGranted = await Geolocator.isLocationServiceEnabled();
    if(!isLocationServiceEnabled || !isLocationPermissionGranted){
      emit(HomePermissionState());
      return;
    }
    animateTo(latLng: LatLng(lat, lng));
  }

  // - - - - - - - - - - - - - - - - - - ADD MARKER TO MY POSITION - - - - - - - - - - - - - - - - - -  //
  Marker marker({required double lat, required double lng, BitmapDescriptor? icon}){
    return Marker(
      markerId: const MarkerId('place_name'),
      position: LatLng(lat, lng),
       icon: icon ?? BitmapDescriptor.defaultMarker,
      infoWindow: const InfoWindow(
        title: 'title',
        snippet: 'address',
      ),
    );
  }

  // - - - - - - - - - - - - - - - - - -  PERMISSION - - - - - - - - - - - - - - - - - -  //
  Future<void> onRequestPermission() async{
    LocationPermission permission;

    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Geolocator.openAppSettings();
      return;
    }

    final vendors = await vendorRepository.getAllVendors();

    final Position currentPosition = await Geolocator.getCurrentPosition();

    emit(HomeCurrentState(
        cameraPosition: CameraPosition(target: LatLng(currentPosition.latitude, currentPosition.longitude), zoom: 12),
        mapController:  Completer(),
        myCurrentLocation: LatLng(currentPosition.latitude,currentPosition.longitude),
        vendors:  vendors
    ));
  }

  Future<void> onRefreshVendors() async {
    final currentState = state as HomeCurrentState;
    emit(HomeLoadingState());
    await Future.delayed(const Duration(milliseconds: 1000));
    final vendors = await vendorRepository.getAllVendors();
    emit(currentState.copyWith(vendors: vendors));
  }

   filterVendors() {}

}

part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeCurrentState extends HomeState {
  final Completer<GoogleMapController>? mapController;
  final CameraPosition? myCurrentLocation, cameraCurrentLocation;
 final bool? mapMyLocationEnabled, mapTrafficEnabled, mapRefreshEnabled, mapSatelliteEnabled, mapVendorsEnabled, mapFilterEnabled;
  final  List<VendorEntity>? vendors;
  final  Set<Marker>? markers;

  HomeCurrentState(
      {this.mapController,
      this.myCurrentLocation,
      this.mapMyLocationEnabled,
      this.mapTrafficEnabled,
      this.mapSatelliteEnabled,
      this.mapRefreshEnabled,
      this.mapVendorsEnabled,
      this.mapFilterEnabled,
      this.cameraCurrentLocation,
      this.markers,
      this.vendors});

  HomeCurrentState copyWith(
          {Completer<GoogleMapController>? mapController,
          CameraPosition? myCurrentLocation,
          CameraPosition? cameraCurrentLocation, bool? mapMyLocationEnabled, bool? mapTrafficEnabled, bool? mapRefreshEnabled, bool? mapFilterEnabled, bool? mapVendorsEnabled, bool? mapSatelliteEnabled,
          List<VendorEntity>? vendors,
          Set<Marker>? markers
          }) =>
      HomeCurrentState(
          mapController: mapController ?? this.mapController,
          myCurrentLocation: myCurrentLocation ?? this.myCurrentLocation,
          cameraCurrentLocation: cameraCurrentLocation ?? this.cameraCurrentLocation,
          mapMyLocationEnabled: mapMyLocationEnabled ?? this.mapMyLocationEnabled,
          mapTrafficEnabled: mapTrafficEnabled ?? this.mapTrafficEnabled,
          mapRefreshEnabled: mapRefreshEnabled ?? this.mapRefreshEnabled,
          mapFilterEnabled: mapFilterEnabled ?? this.mapFilterEnabled,
          mapVendorsEnabled: mapVendorsEnabled ?? this.mapVendorsEnabled,
          mapSatelliteEnabled: mapSatelliteEnabled ?? this.mapSatelliteEnabled,
          vendors: vendors ?? this.vendors,
           markers: markers ?? this.markers
      );
}

final class HomeLoadingState extends HomeState {}

final class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required this.message});
}



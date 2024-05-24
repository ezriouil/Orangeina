part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeMainState extends HomeState {
  final Completer<GoogleMapController>? mapController;
  final CameraPosition? myCurrentLocation, cameraCurrentLocation;
  final CustomInfoWindowController? customInfoWindowController;
 final bool? mapMyLocationEnabled, mapTrafficEnabled, mapRefreshEnabled, mapSatelliteEnabled, mapVendorsEnabled, mapFilterEnabled;
  final  List<VendorEntity>? vendors;
  final  Set<Marker>? markers;

  HomeMainState(
      {this.mapController,
      this.myCurrentLocation,
      this.mapMyLocationEnabled,
      this.mapTrafficEnabled,
      this.mapSatelliteEnabled,
      this.customInfoWindowController,
      this.mapRefreshEnabled,
      this.mapVendorsEnabled,
      this.mapFilterEnabled,
      this.cameraCurrentLocation,
      this.markers,
      this.vendors});

  HomeMainState copyWith(
          {Completer<GoogleMapController>? mapController,
          CameraPosition? myCurrentLocation,
          CustomInfoWindowController? customInfoWindowController,
          CameraPosition? cameraCurrentLocation, bool? mapMyLocationEnabled, bool? mapTrafficEnabled, bool? mapRefreshEnabled, bool? mapFilterEnabled, bool? mapVendorsEnabled, bool? mapSatelliteEnabled,
          List<VendorEntity>? vendors,
          Set<Marker>? markers
          }) =>
      HomeMainState(
          mapController: mapController ?? this.mapController,
          myCurrentLocation: myCurrentLocation ?? this.myCurrentLocation,
          cameraCurrentLocation: cameraCurrentLocation ?? this.cameraCurrentLocation,
          mapMyLocationEnabled: mapMyLocationEnabled ?? this.mapMyLocationEnabled,
          mapTrafficEnabled: mapTrafficEnabled ?? this.mapTrafficEnabled,
          mapRefreshEnabled: mapRefreshEnabled ?? this.mapRefreshEnabled,
          mapFilterEnabled: mapFilterEnabled ?? this.mapFilterEnabled,
          customInfoWindowController: customInfoWindowController ?? this.customInfoWindowController,
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



part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeCurrentState extends HomeState {
  final CameraPosition? cameraPosition;
  final Completer<GoogleMapController>? mapController;
  final LatLng? myCurrentLocation;
  final  List<Marker>? vendors;

  HomeCurrentState({this.cameraPosition, this.mapController, this.myCurrentLocation, this.vendors});

  HomeCurrentState copyWith(
          {CameraPosition? cameraPosition,
          Completer<GoogleMapController>? mapController,
          LatLng? myCurrentLocation,
          List<Marker>? vendors
          }) =>
      HomeCurrentState(
          cameraPosition: cameraPosition ?? this.cameraPosition,
          mapController: mapController ?? this.mapController,
          myCurrentLocation: myCurrentLocation ?? this.myCurrentLocation,
          vendors: vendors ?? this.vendors
      );
}

final class HomeLoadingState extends HomeState {}

final class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required this.message});
}

final class HomePermissionState extends HomeState {}

part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeCurrentState extends HomeState {
  final Completer<GoogleMapController>? mapController;
  final CameraPosition? myCurrentLocation, cameraCurrentLocation;
  final  List<VendorEntity>? vendors;
  final  Set<Marker>? markers;

  HomeCurrentState({this.mapController, this.myCurrentLocation, this.cameraCurrentLocation, this.markers, this.vendors});

  HomeCurrentState copyWith(
          {Completer<GoogleMapController>? mapController,
          CameraPosition? myCurrentLocation,
          CameraPosition? cameraCurrentLocation,
          List<VendorEntity>? vendors,
          Set<Marker>? markers
          }) =>
      HomeCurrentState(
          mapController: mapController ?? this.mapController,
          myCurrentLocation: myCurrentLocation ?? this.myCurrentLocation,
          cameraCurrentLocation: cameraCurrentLocation ?? this.cameraCurrentLocation,
          vendors: vendors ?? this.vendors,
           markers: markers ?? this.markers
      );
}

final class HomeLoadingState extends HomeState {}

final class HomeErrorState extends HomeState {
  final String message;
  HomeErrorState({required this.message});
}



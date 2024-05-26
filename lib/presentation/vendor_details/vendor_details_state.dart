part of 'vendor_details_cubit.dart';

@immutable
sealed class VendorDetailsState {}

final class VendorDetailsMainState extends VendorDetailsState {
  final TextEditingController? feedbackController;
  final String? reportReason;
  final double? feedback;
  final Completer<GoogleMapController>? mapController;
  final VendorEntity? vendor;
  final  Set<Marker>? markers;

  VendorDetailsMainState(
      {this.feedbackController, this.reportReason, this.feedback,
        this.mapController,
        this.vendor,
        this.markers});

  VendorDetailsMainState copyWith(
      {
        TextEditingController? feedbackController,
        String? reportReason,
        double? feedback,
        Completer<GoogleMapController>? mapController,
        CameraPosition? myCurrentLocation,
        CameraPosition? vendorLocation,
        VendorEntity? vendor,
        Set<Marker>? markers
      }) =>
      VendorDetailsMainState(
          feedbackController: feedbackController ?? this.feedbackController,
          reportReason: reportReason ?? this.reportReason,
          feedback: feedback ?? this.feedback,
          mapController: mapController ?? this.mapController,
          vendor: vendor ?? this.vendor,
          markers: markers ?? this.markers
      );

}

final class VendorDetailsLoadingState extends VendorDetailsState {}

final class VendorDetailsErrorState extends VendorDetailsState {}

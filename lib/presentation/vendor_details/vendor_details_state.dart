part of 'vendor_details_cubit.dart';

@immutable
sealed class VendorDetailsState {}

final class VendorDetailsMainState extends VendorDetailsState {
  final TextEditingController? feedbackController;
  final String? reportReason, wishListId;
  final double? feedback, vendorRating;
  final Completer<GoogleMapController>? mapController;
  final VendorEntity? vendor;
  final  List<ReviewEntity>? reviews;
  final  Set<Marker>? markers;
  final  GlobalKey<FormState>? reportFormState, feedBackFormState;

  VendorDetailsMainState(
      {this.feedbackController, this.reportReason, this.feedback,
        this.mapController,
        this.wishListId,
        this.vendor,
        this.reviews,
        this.vendorRating,
        this.markers,
        this.reportFormState,
        this.feedBackFormState,
      });

  VendorDetailsMainState copyWith(
      {
        TextEditingController? feedbackController,
        String? reportReason,
        String? wishListId,
        double? feedback,
        double? vendorRating,
        Completer<GoogleMapController>? mapController,
        CameraPosition? myCurrentLocation,
        CameraPosition? vendorLocation,
        VendorEntity? vendor,
        List<ReviewEntity>? reviews,
        Set<Marker>? markers,
        GlobalKey<FormState>? reportFormState,
        GlobalKey<FormState>? feedBackFormState,
      }) =>
      VendorDetailsMainState(
          feedbackController: feedbackController ?? this.feedbackController,
          reportReason: reportReason ?? this.reportReason,
          wishListId: wishListId ?? this.wishListId,
          feedback: feedback ?? this.feedback,
          vendorRating: vendorRating ?? this.vendorRating,
          mapController: mapController ?? this.mapController,
          vendor: vendor ?? this.vendor,
          reviews: reviews ?? this.reviews,
          markers: markers ?? this.markers,
          reportFormState: reportFormState ?? this.reportFormState,
          feedBackFormState: feedBackFormState ?? this.feedBackFormState
      );

}

final class VendorDetailsLoadingState extends VendorDetailsState {}

part of 'vendor_details_cubit.dart';

@immutable
sealed class VendorDetailsState {}

final class VendorDetailsMainState extends VendorDetailsState {}

final class VendorDetailsLoadingState extends VendorDetailsState {}

final class VendorDetailsErrorState extends VendorDetailsState {}

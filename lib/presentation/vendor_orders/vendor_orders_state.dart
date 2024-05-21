part of 'vendor_orders_cubit.dart';

@immutable
sealed class VendorOrdersState {}

final class VendorOrdersMainState extends VendorOrdersState {}

final class VendorOrdersLoadingState extends VendorOrdersState {}

final class VendorOrdersErrorState extends VendorOrdersState {}

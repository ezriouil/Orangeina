part of 'vendor_orders_cubit.dart';

@immutable
sealed class VendorOrdersState {}

final class VendorOrdersMainState extends VendorOrdersState {
  final List<OrderEntity>? orders;

  VendorOrdersMainState({ this.orders });

  VendorOrdersMainState copyWith({ List<OrderEntity>? orders}) => VendorOrdersMainState(orders: orders ?? this.orders);

}

final class VendorOrdersEmptyState extends VendorOrdersState {}

final class VendorOrdersLoadingState extends VendorOrdersState {}

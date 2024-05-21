part of 'vendor_new_order_cubit.dart';

@immutable
sealed class VendorNewOrderState {}

final class VendorNewOrderMainState extends VendorNewOrderState {
  final int? counter;
  final DateTime? date;
  final double? priceKg, total;
  final String? dateTimeLocalization;

  VendorNewOrderMainState({this.counter, this.date, this.dateTimeLocalization, this.priceKg, this.total});

  VendorNewOrderMainState copyWith({int? counter, DateTime? date, String? dateTimeLocalization, double? priceKg, double? total}) => VendorNewOrderMainState(
    counter: counter ?? this.counter,
    date: date ?? this.date,
    dateTimeLocalization: dateTimeLocalization ?? this.dateTimeLocalization,
    priceKg: priceKg ?? this.priceKg,
    total: total ?? this.total,
  );
}

final class VendorNewOrderLoadingState extends VendorNewOrderState {}

final class VendorNewOrderErrorState extends VendorNewOrderState {}

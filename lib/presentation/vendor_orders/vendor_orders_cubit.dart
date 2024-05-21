import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'vendor_orders_state.dart';

class VendorOrdersCubit extends Cubit<VendorOrdersState> {
  VendorOrdersCubit() : super(VendorOrdersMainState());
}

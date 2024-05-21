import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'vendor_details_state.dart';

class VendorDetailsCubit extends Cubit<VendorDetailsState> {
  VendorDetailsCubit() : super(VendorDetailsMainState());
}

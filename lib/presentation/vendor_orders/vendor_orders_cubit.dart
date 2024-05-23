import 'package:berkania/domain/repositories/vendor_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../domain/entities/order_entity.dart';
import '../../utils/local/storage/local_storage.dart';

part 'vendor_orders_state.dart';

class VendorOrdersCubit extends Cubit<VendorOrdersState> {

  final VendorRepository vendorRepository;
  final GetStorage storage;
  VendorOrdersCubit({ required this.storage, required this.vendorRepository }) : super(VendorOrdersLoadingState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init() async{
    await getAllOrders();
  }

  // - - - - - - - - - - - - - - - - - - REFRESH - - - - - - - - - - - - - - - - - -  //
  void onRefresh()async{
    emit(VendorOrdersLoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    await getAllOrders();
  }

  // - - - - - - - - - - - - - - - - - - GET / REFRESH ORDERS - - - - - - - - - - - - - - - - - -  //
  Future<void> getAllOrders()async {
    try{
      final String? uid = await LocalStorage.read(key: "UID", storage: storage);
      if(uid == null) {
        emit(VendorOrdersEmptyState());
        return;
      }
      final List<OrderEntity> orders = await vendorRepository.getAllOrders(vendorId: uid);

      if(orders.isEmpty) {
        emit(VendorOrdersEmptyState());
        return;
      }
      emit(VendorOrdersMainState(orders: orders));
    }catch(_){
      emit(VendorOrdersErrorState());
    }
  }

}

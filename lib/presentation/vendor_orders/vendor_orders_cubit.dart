import 'package:berkania/domain/repositories/vendor_repository.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/order_entity.dart';
import '../../utils/local/storage/local_storage.dart';

part 'vendor_orders_state.dart';

class VendorOrdersCubit extends Cubit<VendorOrdersState> {

  final VendorRepository vendorRepository;
  final GetStorage storage;
  final BuildContext context;

  VendorOrdersCubit({ required this.context, required this.storage, required this.vendorRepository }) : super(VendorOrdersLoadingState()){ init(context: context); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  void init({ required BuildContext context }) async{ await getAllOrders(context: context); }

  // - - - - - - - - - - - - - - - - - - REFRESH - - - - - - - - - - - - - - - - - -  //
  void onRefresh({ required BuildContext context })async{
    emit(VendorOrdersLoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    await getAllOrders(context: context.mounted ? context : context);
  }

  // - - - - - - - - - - - - - - - - - - GET / REFRESH ORDERS - - - - - - - - - - - - - - - - - -  //
  Future<void> getAllOrders({ required BuildContext context })async {
    try{
      final String? uid = await LocalStorage.read(key: "UID", storage: storage);
      if(uid == null) {
        await LocalStorage.upsert(key: "INIT_LOCATION", value: "LOGIN", storage: storage);
        context.pushReplacementNamed(CustomRouter.LOGIN);
        return;
      }
      final List<OrderEntity> orders = await vendorRepository.getAllOrders(vendorId: uid);

      if(orders.isEmpty) {
        emit(VendorOrdersEmptyState());
        return;
      }
      emit(VendorOrdersMainState(orders: orders));
    }catch(_){
      emit(VendorOrdersEmptyState());
    }
  }

}

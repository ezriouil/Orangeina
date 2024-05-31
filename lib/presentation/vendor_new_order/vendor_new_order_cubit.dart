import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/domain/entities/order_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_storage/get_storage.dart';

import '../../domain/repositories/vendor_repository.dart';
import '../../utils/helpers/network.dart';
import '../../utils/local/storage/local_storage.dart';
import '../../utils/localisation/custom_locale.dart';
import '../widgets/custom_snackbars.dart';

part 'vendor_new_order_state.dart';

class VendorNewOrderCubit extends Cubit<VendorNewOrderState> {

  final VendorRepository vendorRepository;
  final Connectivity connectivity;
  final GetStorage storage;

  VendorNewOrderCubit({ required this.storage,  required this.connectivity, required this.vendorRepository }) : super(VendorNewOrderMainState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init() async{
    emit(VendorNewOrderMainState(
      counter: 00,
      date: DateTime.now(),
      dateTimeLocalization: CustomLocale.EN,
      priceKg: 0.0,
      total: 00.0,
    ));
    final double getCurrentPrice = await vendorRepository.getProductCurrentPrice();
    final String? lang = await LocalStorage.read(key: "LANGUAGE", storage: storage) ?? CustomLocale.EN;
    emit((state as VendorNewOrderMainState).copyWith(priceKg: getCurrentPrice, dateTimeLocalization: lang));
  }

  // - - - - - - - - - - - - - - - - - - INCREMENT COUNTER - - - - - - - - - - - - - - - - - -  //
  increment() {
    final currentState = state as VendorNewOrderMainState;
    int newCounter = currentState.counter! + 1;
    double newTotal = currentState.total! + currentState.priceKg!;
    emit(currentState.copyWith(counter: newCounter, total: newTotal));
  }

  // - - - - - - - - - - - - - - - - - - DECREMENT COUNTER - - - - - - - - - - - - - - - - - -  //
  decrement(){
    final currentState = state as VendorNewOrderMainState;
    if(currentState.counter! <= 1) return;
    int newCounter = currentState.counter! - 1;
    double newTotal = currentState.total! - currentState.priceKg!;
    emit(currentState.copyWith(counter: newCounter, total: newTotal));
  }

  // - - - - - - - - - - - - - - - - - - PICK DATE - - - - - - - - - - - - - - - - - -  //
  onPickDate(DateTime date){
    emit((state as VendorNewOrderMainState).copyWith(date: date));
  }

  // - - - - - - - - - - - - - - - - - - CONFIRM ORDER - - - - - - - - - - - - - - - - - -  //
  onConfirm({ required BuildContext context, required Function callback}) async{
    try{

      final String uid = await LocalStorage.read(key: "UID", storage: storage);
      final String? firstName = await LocalStorage.read(key: "FIRST_NAME", storage: storage) ?? "Vendor";
      final String? lastName = await LocalStorage.read(key: "FIRST_NAME", storage: storage) ?? "Vendor";
      final currentState = state as VendorNewOrderMainState;
      final currentDateTime = DateTime.now();

      emit(VendorNewOrderLoadingState());

      // CHECK CONNECTION INTERNET
      final hasConnection = await Network.hasConnection(connectivity);
      if(!hasConnection && context.mounted){
        CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
        emit(currentState);
        return;
      }

      // VALIDATION
      if(currentState.counter! < 1 && context.mounted){
        emit(currentState);
        CustomSnackBar.show(context: context, title: "Empty Field", subTitle: "Please Insert How Many KG You Want.", type: ContentType.failure);
        return;
      }

      final OrderEntity orderEntity = OrderEntity(
        vendorFullName: "$firstName $lastName",
        vendorId: uid,
        priceEachKg: currentState.priceKg,
        total: currentState.total,
        quantity: currentState.counter,
        selectedDate: "${currentState.date!.day < 10 ? "0${currentState.date!.day}" : currentState.date!.day}/${currentState.date!.month < 10 ? "0${currentState.date!.month}" : currentState.date!.month}/${currentState.date!.year}",
        status: "PENDING",
        createAt: "${currentDateTime.day < 10 ? "0${currentDateTime.day}" : currentDateTime.day}/${currentDateTime.month < 10 ? "0${currentDateTime.month}" : currentDateTime.month}/${currentDateTime.year}",
      );

      await vendorRepository.newOrder(orderEntity: orderEntity);

      // CALL BACK
      emit(currentState);
      callback.call();

    }catch(_){
      context.mounted ? CustomSnackBar.show(context: context, title: "Error 404", subTitle: "Try Next Time", type: ContentType.failure) : null;
    }
  }

}

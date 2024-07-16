import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/domain/entities/wishList_entity.dart';
import 'package:berkania/utils/helpers/network.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

import '../../domain/repositories/wishList_repository.dart';
import '../../utils/constants/custom_colors.dart';
import '../../utils/local/storage/local_storage.dart';
import '../../utils/localisation/custom_locale.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_snackbars.dart';

part 'wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {

  final WishListRepository wishListRepository;
  final GetStorage storage;
  final Connectivity connectivity;
  final BuildContext context;
  String? uid;
  WishlistCubit({ required this.context, required this.storage, required this.wishListRepository, required this.connectivity}) : super(WishlistLoadingState()){ init(context: context); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init({ required BuildContext context }) async{
    uid = await LocalStorage.read(key: "UID", storage: storage);
    if(uid == null) {
      await LocalStorage.upsert(key: "INIT_LOCATION", value: "LOGIN", storage: storage);
      context.pushReplacementNamed(CustomRouter.LOGIN);
      return;
    }
    await getWishLists();
  }

  // - - - - - - - - - - - - - - - - - - REFRESH - - - - - - - - - - - - - - - - - -  //
  void onRefresh({ required BuildContext context })async{

    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }
    emit(WishlistLoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    await getWishLists();
  }

  // - - - - - - - - - - - - - - - - - - GET / REFRESH ORDERS - - - - - - - - - - - - - - - - - -  //
  Future<void> getWishLists()async {
    try{
      if(uid == null) {
        emit(WishListEmptyState());
        return;
      }
      final List<WishListEntity> wishLists = await wishListRepository.getAllWishLists(id: uid!);

      if(wishLists.isEmpty) {
        emit(WishListEmptyState());
        return;
      }
      emit(WishlistMainState(wishLists: wishLists));
    }catch(e){
      emit(WishListEmptyState());
    }
  }

  // - - - - - - - - - - - - - - - - - - DELETE - - - - - - - - - - - - - - - - - -  //
  void onDelete({ required BuildContext context, required String id })async{
    try{
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SizedBox(
                width: double.infinity,
                height: 150,
                child: Column(
                  children: [

                    CustomElevatedButton(
                        onClick: () async{

                          context.pop();
                          await wishListRepository.deleteWishListById(id: id);
                          onRefresh(context: context);

                        },
                        child: Text(CustomLocale.WSIHLIST_DIALOG_DELETE_TITLE.getString(context.mounted ? context : context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE))
                    ),

                    CustomElevatedButton(
                      backgroundColor: CustomColors.GRAY_LIGHT,
                        onClick: context.pop,
                        child: Text(CustomLocale.WSIHLIST_DIALOG_DISMISS_TITLE.getString(context.mounted ? context : context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE))),
                  ],
                ),
              ),
            );
          });
    } catch (_) {
      context.mounted ? CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.WISHLIST_ERROR_CANNOT_DELETE_SUB_TITLE.getString(context), type: ContentType.failure) : null;
    }
  }
}

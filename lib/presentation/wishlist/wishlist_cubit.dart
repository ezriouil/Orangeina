import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/domain/entities/wishList_entity.dart';
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
  WishlistCubit({ required this.storage, required this.wishListRepository}) : super(WishlistLoadingState()){  init();  }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init() async{
    await getWishLists();
  }

  // - - - - - - - - - - - - - - - - - - REFRESH - - - - - - - - - - - - - - - - - -  //
  void onRefresh()async{
    emit(WishlistLoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    await getWishLists();
  }

  // - - - - - - - - - - - - - - - - - - GET / REFRESH ORDERS - - - - - - - - - - - - - - - - - -  //
  Future<void> getWishLists()async {
    try{
      final String? uid = await LocalStorage.read(key: "UID", storage: storage);
      if(uid == null) {
        emit(WishListEmptyState());
        return;
      }
      final List<WishListEntity> wishLists = await wishListRepository.getAllWishLists(id: uid);

      if(wishLists.isEmpty) {
        emit(WishListEmptyState());
        return;
      }
      emit(WishlistMainState(wishLists: wishLists));
    }catch(e){
      print("=============");
      print(e.toString());
      print("=============");
      emit(WishlistErrorState());
    }
  }

  void onDeleteWishList({required String id, required Null Function() callBack}) async{
    try{

    }catch(e){
      print("=============");
      print(e.toString());
      print("=============");
      emit(WishlistErrorState());
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
                        child: Text(CustomLocale.WSIHLIST_DIALOG_DELETE_TITLE.getString(context.mounted ? context : context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE)),
                        onClick: () async{

                          context.pop();
                          await wishListRepository.deleteWishListById(id: id);
                          onRefresh();

                        }
                    ),

                    CustomElevatedButton(
                        onClick: context.pop,
                        child: Text(CustomLocale.WSIHLIST_DIALOG_DISMISS_TITLE.getString(context.mounted ? context : context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE))),

                  ],
                ),
              ),
            );
          });

    }catch(e){
      context.mounted ? CustomSnackBar.show(context: context, title: "Error 404", subTitle: "Try Next Time", type: ContentType.failure, color: CustomColors.RED_LIGHT) : null;
    }
  }
}

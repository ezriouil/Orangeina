import 'package:berkania/domain/entities/wishList_entity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../domain/repositories/wishList_repository.dart';
import '../../utils/local/storage/local_storage.dart';

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
      final List<WishListEntity> wishLists = await wishListRepository.getAllWishListsById(id: uid);

      if(wishLists.isEmpty) {
        emit(WishListEmptyState());
        return;
      }
      emit(WishlistMainState(wishLists: wishLists));
    }catch(e){
      emit(WishlistErrorState());
    }
  }

}

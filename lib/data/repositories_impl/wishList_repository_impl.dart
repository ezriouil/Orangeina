import 'package:berkania/data/mappers/wishList_mapper.dart';
import 'package:berkania/data/models/wishList_dto.dart';
import 'package:berkania/domain/entities/wishList_entity.dart';
import 'package:berkania/domain/repositories/wishList_repository.dart';

import '../data_source/remote.dart';

class WishListRepositoryImpl extends WishListRepository {

  // - - - - - - - - - - - - - - - - - - OVERRIDE GEL ALL WISHLISTS METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<List<WishListEntity>> getAllWishLists({required String id}) async{
    final List<WishListEntity> wishListsEntity = [];
    final List<WishListDto> wishListsDto = await Remote.getAllWishLists(id: id);

    if(wishListsDto.isNotEmpty){
      for(WishListDto wishListsDto in wishListsDto){
        wishListsEntity.add(wishListsDto.toWishListEntity());
      }
    }

    return wishListsEntity;
  }

  // - - - - - - - - - - - - - - - - - - OVERRIDE DELETE WISHLIST BY ID - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> deleteWishListById({required String id}) async{
    await Remote.deleteWishListById(id: id);
  }


}

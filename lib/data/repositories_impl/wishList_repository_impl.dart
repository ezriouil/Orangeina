import 'package:berkania/data/mappers/wishList_mapper.dart';
import 'package:berkania/data/models/wishList_dto.dart';
import 'package:berkania/domain/entities/wishList_entity.dart';
import 'package:berkania/domain/repositories/wishList_repository.dart';

import '../data_source/remote.dart';

class WishListRepositoryImpl extends WishListRepository {

  // - - - - - - - - - - - - - - - - - - OVERRIDE REGISTER METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<List<WishListEntity>> getAllWishListsById({required String id}) async{
    final List<WishListEntity> wishListsEntity = [];
    final List<WishListDto> wishListsDto = await Remote.getAllWishListsById(id: id);

    if(wishListsDto.isNotEmpty){
      for(WishListDto wishListsDto in wishListsDto){
        wishListsEntity.add(wishListsDto.toWishListEntity());
      }
    }

    return wishListsEntity;
  }


}

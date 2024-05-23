import 'package:berkania/domain/entities/wishList_entity.dart';

abstract class WishListRepository {

  // - - - - - - - - - - - - - - - - - - GET ALL WISHLISTS - - - - - - - - - - - - - - - - - -  //
  Future<List<WishListEntity>> getAllWishListsById({ required String id });

}
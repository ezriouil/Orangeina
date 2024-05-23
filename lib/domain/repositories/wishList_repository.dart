import 'package:berkania/domain/entities/wishList_entity.dart';

abstract class WishListRepository {

  // - - - - - - - - - - - - - - - - - - GET ALL WISHLISTS - - - - - - - - - - - - - - - - - -  //
  Future<List<WishListEntity>> getAllWishLists({ required String id });

  // - - - - - - - - - - - - - - - - - - DELETE WISHLIST BY ID - - - - - - - - - - - - - - - - - -  //
  Future<void> deleteWishListById({ required String id });

}
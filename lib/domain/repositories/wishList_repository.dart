import 'package:berkania/domain/entities/wishList_entity.dart';

abstract class WishListRepository {

  // - - - - - - - - - - - - - - - - - - GET ALL WISHLISTS - - - - - - - - - - - - - - - - - -  //
  Future<List<WishListEntity>> getAllWishLists({ required String id });

  // - - - - - - - - - - - - - - - - - - INSERT NEW WISHLIST - - - - - - - - - - - - - - - - - -  //
  Future<String> insertWishList({ required WishListEntity wishListEntity });

  // - - - - - - - - - - - - - - - - - - CHECK THIS SELLER FROM WISHLIST - - - - - - - - - - - - - - - - - -  //
  Future<WishListEntity?> isFromWishList({ required String userId, required String vendorId, });

  // - - - - - - - - - - - - - - - - - - DELETE WISHLIST BY ID - - - - - - - - - - - - - - - - - -  //
  Future<void> deleteWishListById({ required String id });

}
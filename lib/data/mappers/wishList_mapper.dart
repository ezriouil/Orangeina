import 'package:berkania/data/models/wishList_dto.dart';
import 'package:berkania/domain/entities/wishList_entity.dart';

extension WishListEntityMapper on WishListEntity {
  WishListDto toWishListDto() => WishListDto(
    id: id,
    userId: userId,
    vendorId: vendorId,
    avatar: avatar,
    fullName: fullName,
    phone: phone,
    rating: rating,
    createAt: createAt
  );
}

extension WishListDtoMapper on WishListDto {
  WishListEntity toWishListEntity() => WishListEntity(
      id: id,
      userId: userId,
      vendorId: vendorId,
      avatar: avatar,
      fullName: fullName,
      phone: phone,
      rating: rating,
      createAt: createAt
  );
}
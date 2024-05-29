import 'package:berkania/data/models/vendor_dto.dart';
import 'package:berkania/domain/entities/vendor_entity.dart';

extension VendorEntityMapper on VendorEntity {
  VendorDto toVendorDto() => VendorDto(
    id: id,
    firstName: firstName,
    lastName: lastName,
    cin: cin,
    avatar: avatar,
    email: email,
    phoneNumber: phoneNumber,
    gender: gender,
    shopThumbnail: shopThumbnail,
    carAssurance: carAssurance,
    carRegistration: carRegistration,
    carType: carType,
    isOnline: isOnline,
    visible: visible,
    averageRating: averageRating,
    birthdayYear: birthdayYear,
    totalOrders: totalOrders,
    shopLat: shopLat,
    shopLng: shopLng,
    uploadedPaperImagesAt: uploadedPaperImagesAt,
    paperImages: paperImages,
    createAt: createAt
  );
}

extension VendorDtoMapper on VendorDto {
  VendorEntity toVendorEntity() => VendorEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      cin: cin,
      avatar: avatar,
      email: email,
      phoneNumber: phoneNumber,
      gender: gender,
      shopThumbnail: shopThumbnail,
      carAssurance: carAssurance,
      carRegistration: carRegistration,
      carType: carType,
      isOnline: isOnline,
      visible: visible,
      averageRating: averageRating,
      birthdayYear: birthdayYear,
      totalOrders: totalOrders,
      shopLat: shopLat,
      shopLng: shopLng,
      uploadedPaperImagesAt: uploadedPaperImagesAt,
      paperImages: paperImages,
      createAt: createAt
  );
}
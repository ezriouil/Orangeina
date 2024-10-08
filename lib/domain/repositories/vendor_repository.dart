import 'package:berkania/domain/entities/order_entity.dart';

import '../entities/vendor_entity.dart';

abstract class VendorRepository {

  // - - - - - - - - - - - - - - - - - - INSERT NEW VENDOR  - - - - - - - - - - - - - - - - - -  //
  Future<void> insertNewVendor({ required VendorEntity vendorEntity });

  // - - - - - - - - - - - - - - - - - - IS VENDOR ACCEPTED OR NOT  - - - - - - - - - - - - - - - - - -  //
  Future<bool> isProcessingVendorInfo({ required String uid });

  // - - - - - - - - - - - - - - - - - - GET ALL VENDORS DATA FROM FIRESTORE - - - - - - - - - - - - - - - - - -  //
  Future<List<VendorEntity>> getAllVendors();

  // - - - - - - - - - - - - - - - - - - CHECK THE VENDOR IS EXIST - - - - - - - - - - - - - - - - - -  //
  Future<bool> existVendor({required String vendorId});

  // - - - - - - - - - - - - - - - - - - MAKE VENDOR ONLINE - - - - - - - - - - - - - - - - - -  //
  Future<void> online({ required String vendorId, required num lat, required num lng});

  // - - - - - - - - - - - - - - - - - - MAKE VENDOR OFFLINE - - - - - - - - - - - - - - - - - -  //
  Future<void> offline({ required String vendorId });

  // - - - - - - - - - - - - - - - - - - UPDATE RATING - - - - - - - - - - - - - - - - - -  //
  Future<void> updateRating({ required num newRate, required String vendorId });

  // - - - - - - - - - - - - - - - - - - UPDATE VENDOR AVATAR - - - - - - - - - - - - - - - - - -  //
  Future<void> updateVendorAvatar({required String vendorId, required String newAvatar});

  // - - - - - - - - - - - - - - - - - - UPDATE VENDOR SHOP THUMBNAIL - - - - - - - - - - - - - - - - - -  //
  Future<void> updateVendorShopThumbnail({required String vendorId, required String newShopThumbnail});

  // - - - - - - - - - - - - - - - - - - GET VENDOR INFO - - - - - - - - - - - - - - - - - -  //
  Future<VendorEntity?> getVendorById({required String vendorId});

  // - - - - - - - - - - - - - - - - - - UPDATE VENDOR FULL NAME - - - - - - - - - - - - - - - - - -  //
  Future<void> updateVendorFullName({required String vendorId, required String newFirstName, required String newLastName});

  // - - - - - - - - - - - - - - - - - - UPDATE VENDOR PHONE - - - - - - - - - - - - - - - - - -  //
  Future<void> updateVendorPhone({required String vendorId, required String newPhone, required String dialCode, required String isoCode});

  // - - - - - - - - - - - - - - - - - - SAVE VENDOR IMAGE - - - - - - - - - - - - - - - - - -  //
  Future<String> saveVendorImage({required String imgName, required String imgPath});

  // - - - - - - - - - - - - - - - - - - SAVE VENDOR SHOP THUMBNAIL - - - - - - - - - - - - - - - - - -  //
  Future<String> saveVendorShopThumbnail({required String imgName, required String imgPath});

  // - - - - - - - - - - - - - - - - - - SAVE VENDOR IMAGE - - - - - - - - - - - - - - - - - -  //
  Future<String> saveVendorPaperImages({required String imgName, required String imgPath});

  // - - - - - - - - - - - - - - - - - - DELETE VENDOR IMAGE - - - - - - - - - - - - - - - - - -  //
  Future<void> deleteVendorImage({required String imgName});

  // - - - - - - - - - - - - - - - - - - VENDOR MAKE NEW ORDER - - - - - - - - - - - - - - - - - -  //
  Future<void> newOrder({ required OrderEntity orderEntity });

  // - - - - - - - - - - - - - - - - - - VENDOR GET ALL ORDERS - - - - - - - - - - - - - - - - - -  //
  Future<List<OrderEntity>> getAllOrders({ required String vendorId });

  // - - - - - - - - - - - - - - - - - - PRODUCT CURRENT PRICE - - - - - - - - - - - - - - - - - -  //
  Future<double> getProductCurrentPrice();

}
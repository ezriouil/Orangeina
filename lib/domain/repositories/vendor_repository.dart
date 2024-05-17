import '../entities/vendor_entity.dart';

abstract class VendorRepository {

  // - - - - - - - - - - - - - - - - - - GET ALL VENDORS DATA FROM FIRESTORE - - - - - - - - - - - - - - - - - -  //
  Future<List<VendorEntity>> getAllVendors();

  // - - - - - - - - - - - - - - - - - - CHECK THE VENDOR IS EXIST - - - - - - - - - - - - - - - - - -  //
  Future<bool> isExist({required String vendorId});

  // - - - - - - - - - - - - - - - - - - SAVE IMAGE - - - - - - - - - - - - - - - - - -  //
  Future<String> saveImage({required String imgName, required String imgPath});

  // - - - - - - - - - - - - - - - - - - DELETE IMAGE - - - - - - - - - - - - - - - - - -  //
  Future<void> deleteImage({required String imgName});

  // - - - - - - - - - - - - - - - - - - UPDATE VENDOR INFO  - - - - - - - - - - - - - - - - - -  //
  Future<void> updateVendorInfo({required VendorEntity vendorEntity});

}
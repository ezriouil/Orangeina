import '../entities/vendor_entity.dart';

abstract class VendorRepository {

  // - - - - - - - - - - - - - - - - - - GET ALL VENDORS DATA FROM FIRESTORE - - - - - - - - - - - - - - - - - -  //
  Future<List<VendorEntity>> getAllVendors();

  // - - - - - - - - - - - - - - - - - - CHECK THE VENDOR IS EXIST - - - - - - - - - - - - - - - - - -  //
  Future<bool> existVendor({required String vendorId});

  // - - - - - - - - - - - - - - - - - - UPDATE VENDOR FULL NAME - - - - - - - - - - - - - - - - - -  //
  Future<void> updateVendorFullName({required String vendorId, required String newFirstName, required String newLastName});

  // - - - - - - - - - - - - - - - - - - UPDATE VENDOR EMAIL - - - - - - - - - - - - - - - - - -  //
  //Future<void> updateVendorEmail({required String vendorId, required String newEmail});

  // - - - - - - - - - - - - - - - - - - UPDATE VENDOR PASSWORD - - - - - - - - - - - - - - - - - -  //
  //Future<void> updateVendorPassword({required String vendorId, required String newPassword});

  // - - - - - - - - - - - - - - - - - - UPDATE VENDOR PHONE - - - - - - - - - - - - - - - - - -  //
  Future<void> updateVendorPhone({required String vendorId, required String newPhone});

  // - - - - - - - - - - - - - - - - - - SAVE VENDOR IMAGE - - - - - - - - - - - - - - - - - -  //
  Future<String> saveVendorImage({required String imgName, required String imgPath});

  // - - - - - - - - - - - - - - - - - - DELETE VENDOR IMAGE - - - - - - - - - - - - - - - - - -  //
  Future<void> deleteVendorImage({required String imgName});

}
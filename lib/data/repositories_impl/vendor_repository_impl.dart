import 'dart:io';

import 'package:berkania/domain/entities/vendor_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../domain/repositories/vendor_repository.dart';

class VendorRepositoryImpl extends VendorRepository {

  // - - - - - - - - - - - - - - - - - - CREATE INSTANCES - - - - - - - - - - - - - - - - - -  //
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // - - - - - - - - - - - - - - - - - - OVERRIDE GET ALL VENDORS FROM METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<List<VendorEntity>> getAllVendors() async{
    final List<VendorEntity> vendors = [];
    final QuerySnapshot<Map<String, dynamic>> vendorsCollection = await _firebaseFirestore.collection("VENDORS").get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> vendorJson in vendorsCollection.docs) {
      VendorEntity vendor = VendorEntity.fromJson(vendorJson.data());
      vendors.add(vendor);
    }
    return vendors;
  }

  // - - - - - - - - - - - - - - - - - - UPDATE VENDOR INDO - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> updateVendorInfo({required VendorEntity vendorEntity}) async{
    await _firebaseFirestore.collection("VENDOR").doc(vendorEntity.id).update(vendorEntity.toJson());
  }

  // - - - - - - - - - - - - - - - - - - OVERRIDE IS EXIST METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<bool> isExist({required String vendorId}) async{
    final result = await _firebaseFirestore.collection("VENDORS").doc(vendorId).get();
    return result.exists;
  }

  // - - - - - - - - - - - - - - - - - - DELETE IMAGE FROM VENDOR FOLDER - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> deleteImage({required String imgName}) async{
    await _firebaseStorage.ref("VENDOR").child(imgName).delete();
  }

  // - - - - - - - - - - - - - - - - - - SAVE IMAGE INTO VENDOR FOLDER - - - - - - - - - - - - - - - - - -  //
  @override
  Future<String> saveImage({required String imgName, required String imgPath}) async{
    final saveImg =  await _firebaseStorage.ref("VENDOR").child(imgName).putFile(File(imgPath));
    final imgUrl = await saveImg.ref.getDownloadURL();
    return imgUrl;
  }

}

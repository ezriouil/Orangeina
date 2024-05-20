import 'dart:io';

import 'package:berkania/domain/entities/vendor_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../domain/repositories/vendor_repository.dart';

class VendorRepositoryImpl extends VendorRepository {

  // - - - - - - - - - - - - - - - - - - CREATE INSTANCES - - - - - - - - - - - - - - - - - -  //
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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

  @override
  Future<bool> existVendor({required String vendorId}) async{
    final result = await _firebaseFirestore.collection("VENDOR").doc(vendorId).get();
    return result.exists;
  }

  @override
  Future<void> updateVendorEmail({required String vendorId, required String newEmail}) async{
    final User user =  _firebaseAuth.currentUser!;
    user.verifyBeforeUpdateEmail(newEmail);
    await _firebaseFirestore.collection("VENDOR").doc(vendorId).update({'email' : newEmail});
  }

  @override
  Future<void> updateVendorFullName({required String vendorId, required String newFirstName, required String newLastName}) async{
    await _firebaseFirestore.collection("VENDOR").doc(vendorId).update({'firstName' : newFirstName, 'lastName' : newLastName, });
  }


  @override
  Future<void> updateVendorPassword({required String vendorId, required String newPassword}) async{
    final User user =  _firebaseAuth.currentUser!;
    await user.updatePassword(newPassword);
  }

  @override
  Future<void> updateVendorPhone({required String vendorId, required String newPhone}) async{
    await _firebaseFirestore.collection("VENDOR").doc(vendorId).update({'phone' : newPhone});
  }

  @override
  Future<String> saveVendorImage({required String imgName, required String imgPath}) async{
    final saveImg =  await _firebaseStorage.ref("VENDOR").child(imgName).putFile(File(imgPath));
    final imgUrl = await saveImg.ref.getDownloadURL();
    return imgUrl;
  }


  @override
  Future<void> deleteVendorImage({required String imgName}) async{
    await _firebaseStorage.ref("VENDOR").child(imgName).delete();
  }

}

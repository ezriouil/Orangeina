import 'dart:io';

import 'package:berkania/data/models/order_dto.dart';
import 'package:berkania/data/models/user_dto.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/vendor_dto.dart';

class Remote{
  Remote._();

  // - - - - - - - - - - - - - - - - - - CREATE INSTANCES - - - - - - - - - - - - - - - - - -  //
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /* _______________________ REUSABLE FUNCTIONS _______________________  */

  // - - - - - - - - - - - - - - - - - - REGISTER WITH EMAIL AND PASSWORD - - - - - - - - - - - - - - - - - -  //
  static Future<UserCredential?> register({required String email, required String password}) async{
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  // - - - - - - - - - - - - - - - - - - LOGIN WITH EMAIL AND PASSWORD - - - - - - - - - - - - - - - - - -  //
  static Future<UserCredential?> login({required String email, required String password}) async{
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  // - - - - - - - - - - - - - - - - - - LOGIN WITH GOOGLE - - - - - - - - - - - - - - - - - -  //
  Future<UserCredential> loginWithGoogle() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // - - - - - - - - - - - - - - - - - - FORGET PASSWORD - - - - - - - - - - - - - - - - - -  //
  static Future<void> forgetPassword({ required String email }) async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // - - - - - - - - - - - - - - - - - - LOGOUT - - - - - - - - - - - - - - - - - -  //
  static Future<void> logout() async{
     await _firebaseAuth.signOut();
  }

  // - - - - - - - - - - - - - - - - - - EXIST - - - - - - - - - - - - - - - - - -  //
  static Future<bool> exist({required String collection, required String doc}) async{
    final result = await _firebaseFirestore.collection(collection).doc(doc).get();
    return result.exists;
  }

  // - - - - - - - - - - - - - - - - - - UPDATE EMAIL - - - - - - - - - - - - - - - - - -  //
  // static Future<void> updateEmail({required String collection, required String doc, required String newEmail}) async{
  //  final User user =  _firebaseAuth.currentUser!;
  //  await user.updateEmail(newEmail);
  //  await _firebaseFirestore.collection(collection).doc(doc).update({'email' : newEmail});
  //}

  // - - - - - - - - - - - - - - - - - - UPDATE PASSWORD - - - - - - - - - - - - - - - - - -  //
  // static Future<void> updatePassword({required String newPassword}) async{
  //   final User user =  _firebaseAuth.currentUser!;
  //   await user.updatePassword(newPassword);
  // }

  // - - - - - - - - - - - - - - - - - - UPDATE PHONE - - - - - - - - - - - - - - - - - -  //
  static Future<void> updatePhone({required String collection, required String doc, required String newPhone}) async{
    await _firebaseFirestore.collection(collection).doc(doc).update({'phone' : newPhone});
  }

  // - - - - - - - - - - - - - - - - - - UPDATE FULL NAME - - - - - - - - - - - - - - - - - -  //
  static Future<void> updateFullName({required String collection,required String doc, required String newFirstName, required String newLastName}) async{
    await _firebaseFirestore.collection(collection).doc(doc).update({'firstName' : newFirstName, 'lastName' : newLastName, });
  }

  // - - - - - - - - - - - - - - - - - - SAVE IMAGE - - - - - - - - - - - - - - - - - -  //
  static Future<String> saveImage({required String path, required String imgName, required String imgPath}) async{
    final saveImg =  await _firebaseStorage.ref(path).child(imgName).putFile(File(imgPath));
    final imgUrl = await saveImg.ref.getDownloadURL();
    return imgUrl;
  }

  // - - - - - - - - - - - - - - - - - - UPDATE IMAGE - - - - - - - - - - - - - - - - - -  //
  static Future<String> updateImage({required String path, required String imgName, required String imgPath}) async{
    try{
      await deleteUserImage(path: path, imgName: imgName);
      return saveImage(path: path, imgName: imgName, imgPath: imgPath);
    }catch(_){
      return saveImage(path: path, imgName: imgName, imgPath: imgPath);
  }
  }

  // - - - - - - - - - - - - - - - - - - DELETE IMAGE - - - - - - - - - - - - - - - - - -  //
  static Future<void> deleteUserImage({required String path, required String imgName}) async{
    await _firebaseStorage.ref(path).child(imgName).delete();
  }


  /* _______________________ CUSTOM FUNCTIONS _______________________  */

  // - - - - - - - - - - - - - - - - - - GET ALL VENDORS - - - - - - - - - - - - - - - - - -  //
  static Future<List<VendorDto>> getAllVendors() async{
    final List<VendorDto> vendors = [];
    final QuerySnapshot<Map<String, dynamic>> vendorsCollection = await _firebaseFirestore.collection("VENDORS").get();

    if(vendorsCollection.size > 0){
      for (QueryDocumentSnapshot<Map<String, dynamic>> vendorJson in vendorsCollection.docs) {
        VendorDto vendor = VendorDto.fromJson(vendorJson.data());
        vendors.add(vendor);
      }
    }
    return vendors;
  }

  // - - - - - - - - - - - - - - - - - - SAVE USER DATA - - - - - - - - - - - - - - - - - -  //
  static Future<void> saveUserData({ required UserDto userDto }) async{
    await _firebaseFirestore.collection("USERS").doc(userDto.id).set(userDto.toJson());
  }

  // - - - - - - - - - - - - - - - - - - MAKE VENDOR ONLINE - - - - - - - - - - - - - - - - - -  //
  static Future<void> vendorOnline({ required String vendorId }) async{
    await _firebaseFirestore.collection("VENDORS").doc(vendorId).update({'isOnline' : true});
  }

  // - - - - - - - - - - - - - - - - - - MAKE VENDOR OFFLINE - - - - - - - - - - - - - - - - - -  //
  static Future<void> vendorOffline({ required String vendorId }) async{
    await _firebaseFirestore.collection("VENDORS").doc(vendorId).update({'isOnline' : false});
  }

  // - - - - - - - - - - - - - - - - - - GET ALL ORDERS - - - - - - - - - - - - - - - - - -  //
  static Future<List<OrderDto>> getAllOrdersByVendorId({ required String vendorId }) async{
    final List<OrderDto> orders = [];
    final QuerySnapshot<Map<String, dynamic>> ordersCollection = await _firebaseFirestore.collection("ORDERS").where('vendorId', isEqualTo: vendorId).get();

    if(ordersCollection.size > 0){
      for (QueryDocumentSnapshot<Map<String, dynamic>> orderJson in ordersCollection.docs) {
        OrderDto order = OrderDto.fromJson(orderJson.data());
        orders.add(order);
      }
    }
    return orders.reversed.toList();
  }

  // - - - - - - - - - - - - - - - - - - VENDOR MAKE NEW ORDER - - - - - - - - - - - - - - - - - -  //
  static Future<void> newOrder({required OrderDto orderDto}) async{
    final newDoc = _firebaseFirestore.collection("ORDERS").doc();
    await newDoc.set({
      "id" : newDoc.id,
      "vendorId" : orderDto.vendorId,
      "vendorFullName" : orderDto.vendorFullName,
      "priceEachKg" : orderDto.priceEachKg,
      "total" : orderDto.total,
      "quantity" : orderDto.quantity,
      "selectedDate" : orderDto.selectedDate,
      "status" : orderDto.status,
      "createAt" : orderDto.createAt,
    });
  }

  // - - - - - - - - - - - - - - - - - - GET CURRENT PRICE OF PRODUCT - - - - - - - - - - - - - - - - - -  //
  static Future<double> productCurrentPrice() async{
    final price =  await _firebaseFirestore.collection("SETTINGS").doc("PRICES").get();
    return (price["currentPrice"] as num).toDouble();
  }

}
import 'dart:io';

import 'package:berkania/data/models/notification_dto.dart';
import 'package:berkania/data/models/order_dto.dart';
import 'package:berkania/data/models/report_dto.dart';
import 'package:berkania/data/models/review_dto.dart';
import 'package:berkania/data/models/user_dto.dart';
import 'package:berkania/data/models/wishList_dto.dart';
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

  // - - - - - - - - - - - - - - - - - - EMAIL EXIST - - - - - - - - - - - - - - - - - -  //
  static Future<bool> emailExist({ required String collection, required String email }) async{
     final data = await _firebaseFirestore.collection(collection).where("email", isEqualTo: email).get();
     return data.size > 0 ? true : false;
  }

  // - - - - - - - - - - - - - - - - - - EXIST - - - - - - - - - - - - - - - - - -  //
  static Future<bool> exist({required String collection, required String doc}) async{
    final result = await _firebaseFirestore.collection(collection).doc(doc).get();
    if(!result.exists) return false;
    if(result.data()!['visible'] == false) return false;
    return true;
  }

  // - - - - - - - - - - - - - - - - - - UPDATE PHONE - - - - - - - - - - - - - - - - - -  //
  static Future<void> updatePhone({required String collection, required String doc, required String newPhone}) async{
    await _firebaseFirestore.collection(collection).doc(doc).update({'phoneNumber' : newPhone});
  }

  // - - - - - - - - - - - - - - - - - - UPDATE FULL NAME - - - - - - - - - - - - - - - - - -  //
  static Future<void> updateFullName({required String collection,required String doc, required String newFirstName, required String newLastName}) async{
    await _firebaseFirestore.collection(collection).doc(doc).update({'firstName' : newFirstName, 'lastName' : newLastName, });
  }

  // - - - - - - - - - - - - - - - - - - UPDATE AVATAR - - - - - - - - - - - - - - - - - -  //
  static Future<void> updateAvatar({required String collection,required String doc, required String newAvatar}) async{
    await _firebaseFirestore.collection(collection).doc(doc).update({'avatar' : newAvatar});
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
    final QuerySnapshot<Map<String, dynamic>> vendorsCollection = await _firebaseFirestore.collection("VENDORS").where('visible', isEqualTo: true).where('isOnline', isEqualTo: true).get();

    if(vendorsCollection.size > 0){
      for (QueryDocumentSnapshot<Map<String, dynamic>> vendorJson in vendorsCollection.docs) {
        VendorDto vendor = VendorDto.fromJson(vendorJson.data());
        vendors.add(vendor);
      }
    }
    return vendors;
  }

  // - - - - - - - - - - - - - - - - - - UPDATE VENDOR RATING - - - - - - - - - - - - - - - - - -  //
  static Future<void> updateVendorRating({required String uid, required num averageRating}) async{
    await _firebaseFirestore.collection("VENDORS").doc(uid).update({'averageRating' : averageRating});
  }

  // - - - - - - - - - - - - - - - - - - SAVE USER DATA - - - - - - - - - - - - - - - - - -  //
  static Future<UserDto?> getUserData({ required String id }) async{
    final DocumentSnapshot<Map<String,dynamic>> userJson = await _firebaseFirestore.collection("USERS").doc(id).get();
    if(!userJson.exists) return null;
    return UserDto.fromJson(userJson.data()!);
  }

  // - - - - - - - - - - - - - - - - - - SAVE USER DATA - - - - - - - - - - - - - - - - - -  //
  static Future<void> saveUserData({ required UserDto userDto }) async{
    await _firebaseFirestore.collection("USERS").doc(userDto.id).set(userDto.toJson());
  }

  // - - - - - - - - - - - - - - - - - - MAKE VENDOR ONLINE - - - - - - - - - - - - - - - - - -  //
  static Future<void> vendorOnline({ required String vendorId ,required num shopLat ,required num shopLng }) async{
    await _firebaseFirestore.collection("VENDORS").doc(vendorId).update({'isOnline' : true, 'shopLat' : shopLat, 'shopLng' : shopLng});
  }

  // - - - - - - - - - - - - - - - - - - MAKE VENDOR OFFLINE - - - - - - - - - - - - - - - - - -  //
  static Future<void> vendorOffline({ required String vendorId }) async{
    await _firebaseFirestore.collection("VENDORS").doc(vendorId).update({'isOnline' : false});
  }

  // - - - - - - - - - - - - - - - - - - GET VENDOR INFO BY ID - - - - - - - - - - - - - - - - - -  //
  static Future<VendorDto?> getVendorById({ required String vendorId }) async{
    final vendor = await _firebaseFirestore.collection("VENDORS").doc(vendorId).get();
    if(!vendor.exists) return null;
    //if(vendor.data()!['visible'] == false) return null;
    return VendorDto.fromJson(vendor.data()!);
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

  // - - - - - - - - - - - - - - - - - - NEW VENDOR - - - - - - - - - - - - - - - - - -  //
  static Future<void> newVendor({required VendorDto vendorDto}) async{
    _firebaseFirestore.collection("VENDORS").doc(vendorDto.id).set(vendorDto.toJson());
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

  // - - - - - - - - - - - - - - - - - - GET ALL WISHLISTS - - - - - - - - - - - - - - - - - -  //
  static Future<List<WishListDto>> getAllWishLists({ required String id }) async{
    final List<WishListDto> wishLists = [];
    final QuerySnapshot<Map<String, dynamic>> wishListsCollection =  await _firebaseFirestore.collection("WISHLISTS").where('userId', isEqualTo: id).get();
    if(wishListsCollection.size > 0){
      for (QueryDocumentSnapshot<Map<String, dynamic>> wishListJson in wishListsCollection.docs) {
        WishListDto wishList = WishListDto.fromJson(wishListJson.data());
        wishLists.add(wishList);
      }
    }
    return wishLists.reversed.toList();
  }

  static Future<String> insertWishList({required WishListDto wishListDto}) async{
    final newDoc = _firebaseFirestore.collection("WISHLISTS").doc();
    await newDoc.set({
      'id': newDoc.id,
      'userId': wishListDto.userId,
      'vendorId': wishListDto.vendorId,
      'avatar': wishListDto.avatar,
      'fullName': wishListDto.fullName,
      'phoneNumber': wishListDto.phoneNumber,
      'rating': wishListDto.rating,
      'createAt': wishListDto.createAt
    });
    return newDoc.id;
  }

  // - - - - - - - - - - - - - - - - - - DELETE WISHLIST BY ID - - - - - - - - - - - - - - - - - -  //
  static Future<WishListDto?> isFromWishList({ required String vendorId, required String userId, }) async{
    final wishlist = await _firebaseFirestore.collection("WISHLISTS").where("vendorId", isEqualTo: vendorId).where("userId", isEqualTo: userId).limit(1).get();
    if (wishlist.size == 0) return null;
    return WishListDto.fromJson(wishlist.docs.first.data());
  }

  // - - - - - - - - - - - - - - - - - - DELETE WISHLIST BY ID - - - - - - - - - - - - - - - - - -  //
  static Future<void> deleteWishListById({ required String id }) async{
    await _firebaseFirestore.collection("WISHLISTS").doc(id).delete();
  }

  // - - - - - - - - - - - - - - - - - - GET ALL NOTIFICATION - - - - - - - - - - - - - - - - - -  //
  static Future<List<NotificationDto>> getAllNotification({ required String userId }) async{

    final List<NotificationDto> notifications = [];
    final QuerySnapshot<Map<String, dynamic>> notificationsCollection = await _firebaseFirestore.collection("NOTIFICATIONS").where("userId", isEqualTo: userId).get();
    if(notificationsCollection.size > 0){
      for (QueryDocumentSnapshot<Map<String, dynamic>> notificationJson in notificationsCollection.docs) {
        NotificationDto notificationDto = NotificationDto.fromJson(notificationJson.data());
        notifications.add(notificationDto);
      }
    }
    return notifications.reversed.toList();
  }

  // - - - - - - - - - - - - - - - - - - Send NOTIFICATION BY ID - - - - - - - - - - - - - - - - - -  //
  static Future<void> sendNotification({ required NotificationDto notificationDto }) async{
    final newDoc = _firebaseFirestore.collection("NOTIFICATIONS").doc();
    await newDoc.set({
      'id': newDoc.id,
      'userId' : notificationDto.userId,
      'type' : notificationDto.type,
      'title' : notificationDto.title,
      'isRead' : notificationDto.isRead,
      'body' : notificationDto.body,
      'createAt' : notificationDto.createAt,
    });
  }

  // - - - - - - - - - - - - - - - - - - READ NOTIFICATION BY ID - - - - - - - - - - - - - - - - - -  //
  static Future<void> readNotification({ required String id }) async{
    await _firebaseFirestore.collection("NOTIFICATIONS").doc(id).update({ 'isRead' : true});
  }

  // - - - - - - - - - - - - - - - - - - DELETE NOTIFICATION BY ID - - - - - - - - - - - - - - - - - -  //
  static Future<void> deleteNotificationById({ required String id }) async{
    await _firebaseFirestore.collection("NOTIFICATIONS").doc(id).delete();
  }

  // - - - - - - - - - - - - - - - - - - GET ALL REVIEWS - - - - - - - - - - - - - - - - - -  //
  static Future<List<ReviewDto>> getAllReviews({ required String vendorId }) async{

    final List<ReviewDto> reviews = [];
    final QuerySnapshot<Map<String, dynamic>> reviewsCollection = await _firebaseFirestore.collection("REVIEWS").where("vendorId", isEqualTo: vendorId).get();
    if(reviewsCollection.size > 0){
      for (QueryDocumentSnapshot<Map<String, dynamic>> reviewJson in reviewsCollection.docs) {
        ReviewDto reviewDto = ReviewDto.fromJson(reviewJson.data());
        reviews.add(reviewDto);
      }
    }
    return reviews.reversed.toList();
  }

  // - - - - - - - - - - - - - - - - - - INSERT NEW REVIEW - - - - - - - - - - - - - - - - - -  //
  static Future<void> insertReview({ required ReviewDto reviewDto }) async{
    final newDoc = _firebaseFirestore.collection("REVIEWS").doc();
    await newDoc.set({
      'id': newDoc.id,
      'vendorId': reviewDto.vendorId,
      'viewerId': reviewDto.viewerId,
      'fullName': reviewDto.fullName,
      'reviewBody': reviewDto.reviewBody,
      'avatar': reviewDto.avatar,
      'rating': reviewDto.rating,
      'createAt': reviewDto.createAt
    });
  }

  // - - - - - - - - - - - - - - - - - - DELETE REVIEW BY ID - - - - - - - - - - - - - - - - - -  //
  static Future<void> deleteReviewById({ required String id }) async{
    await _firebaseFirestore.collection("REVIEWS").doc(id).delete();
  }

  // - - - - - - - - - - - - - - - - - - INSERT NEW REPORT - - - - - - - - - - - - - - - - - -  //
  static insertReport({required ReportDto reportDto}) async{
    final newDoc = _firebaseFirestore.collection("REPORTS").doc();
    await newDoc.set({
      'id': newDoc.id,
      'vendorId': reportDto.vendorId,
      'fullName': reportDto.fullName,
      'reportType': reportDto.reportType,
      'reportBody': reportDto.reportBody,
      'avatar': reportDto.avatar,
      'rating': reportDto.rating,
      'createAt': reportDto.createAt
    });
  }

}
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Remote{
  Remote._();

  // - - - - - - - - - - - - - - - - - - CREATE INSTANCES - - - - - - - - - - - - - - - - - -  //
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // - - - - - - - - - - - - - - - - - - EXIST - - - - - - - - - - - - - - - - - -  //
  static Future<bool> existUser({required String collection, required String doc}) async{
    final result = await _firebaseFirestore.collection(collection).doc(doc).get();
    return result.exists;
  }

  // - - - - - - - - - - - - - - - - - - UPDATE EMAIL - - - - - - - - - - - - - - - - - -  //
  static Future<void> updateEmail({required String collection, required String doc, required String newEmail}) async{
    final User user =  _firebaseAuth.currentUser!;
    await user.verifyBeforeUpdateEmail(newEmail);
    await _firebaseFirestore.collection(collection).doc(doc).update({'email' : newEmail});
  }

  // - - - - - - - - - - - - - - - - - - UPDATE PASSWORD - - - - - - - - - - - - - - - - - -  //
  static Future<void> updatePassword({required String newPassword}) async{
    final User user =  _firebaseAuth.currentUser!;
    await user.updatePassword(newPassword);
  }

  // - - - - - - - - - - - - - - - - - - UPDATE PHONE - - - - - - - - - - - - - - - - - -  //
  static Future<void> updatePhone({required String collection, required String doc, required String newImage}) async{
    await _firebaseFirestore.collection(collection).doc(doc).update({'avatar' : newImage});
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

  // - - - - - - - - - - - - - - - - - - DELETE IMAGE - - - - - - - - - - - - - - - - - -  //
  static Future<void> deleteUserImage({required String path, required String imgName}) async{
    await _firebaseStorage.ref(path).child(imgName).delete();
  }

}
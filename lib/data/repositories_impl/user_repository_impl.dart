import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {

  // - - - - - - - - - - - - - - - - - - CREATE INSTANCES - - - - - - - - - - - - - - - - - -  //
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  static final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // - - - - - - - - - - - - - - - - - - OVERRIDE IS EXIST METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<bool> existUser({required String userId}) async{
    final result = await _firebaseFirestore.collection("USERS").doc(userId).get();
    return result.exists;
  }

  @override
  Future<void> updateUserEmail({required String userId, required String newEmail}) async{
    final User user =  _firebaseAuth.currentUser!;
    await user.verifyBeforeUpdateEmail(newEmail);
    await _firebaseFirestore.collection("USERS").doc(userId).update({'email' : newEmail});
  }

  @override
  Future<void> updateUserFullName({required String userId, required String newFirstName, required String newLastName}) async{
    await _firebaseFirestore.collection("USERS").doc(userId).update({'firstName' : newFirstName, 'lastName' : newLastName, });
  }

  @override
  Future<void> updateUserImage({required String userId, required String newImage}) async{
    await _firebaseFirestore.collection("USERS").doc(userId).update({'avatar' : newImage});
  }

  @override
  Future<void> updateUserPassword({required String userId, required String newPassword}) async{
    final User user =  _firebaseAuth.currentUser!;
    await user.updatePassword(newPassword);
  }

  @override
  Future<void> updateUserPhone({required String userId, required String newPhone}) async{
    await _firebaseFirestore.collection("USERS").doc(userId).update({'phone' : newPhone});
  }

  @override
  Future<String> saveUserImage({required String imgName, required String imgPath}) async{
    final saveImg =  await _firebaseStorage.ref("USERS").child(imgName).putFile(File(imgPath));
    final imgUrl = await saveImg.ref.getDownloadURL();
    return imgUrl;
  }


  @override
  Future<void> deleteUserImage({required String imgName}) async{
    await _firebaseStorage.ref("USERS").child(imgName).delete();
  }

}

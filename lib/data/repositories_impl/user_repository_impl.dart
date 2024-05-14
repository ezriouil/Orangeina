import 'package:berkania/domain/entities/userEntity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  // - - - - - - - - - - - - - - - - - - CREATE INSTANCES - - - - - - - - - - - - - - - - - -  //
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // - - - - - - - - - - - - - - - - - - OVERRIDE SAVE USER INFO METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> saveUserInfo({required UserEntity userEntity}) async{
    await _firestore.collection("USERS").doc(userEntity.id).set(userEntity.toJson());
  }

  // - - - - - - - - - - - - - - - - - - OVERRIDE IS EXIST METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<bool> isExist({required String userId}) async{
    final result = await _firestore.collection("USERS").doc(userId).get();
    return result.exists;
  }

}

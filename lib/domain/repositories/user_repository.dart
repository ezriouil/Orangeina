import 'package:berkania/domain/entities/userEntity.dart';

abstract class UserRepository {

  // - - - - - - - - - - - - - - - - - - SAVE USER DATA INTO FIRESTORE - - - - - - - - - - - - - - - - - -  //
  Future<void> saveUserInfo({required UserEntity userEntity});

  // - - - - - - - - - - - - - - - - - - CHECK THE USER IS EXIST - - - - - - - - - - - - - - - - - -  //
  Future<bool> isExist({required String userId});

}
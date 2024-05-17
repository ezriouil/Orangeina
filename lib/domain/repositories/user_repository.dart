import 'package:berkania/domain/entities/user_entity.dart';

abstract class UserRepository {

  // - - - - - - - - - - - - - - - - - - SAVE USER DATA INTO FIRESTORE - - - - - - - - - - - - - - - - - -  //
  Future<void> saveUserInfo({required UserEntity userEntity});

  // - - - - - - - - - - - - - - - - - - CHECK THE USER IS EXIST - - - - - - - - - - - - - - - - - -  //
  Future<bool> isExist({required String userId});

}
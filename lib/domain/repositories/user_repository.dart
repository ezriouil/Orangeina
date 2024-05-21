import 'package:berkania/domain/entities/user_entity.dart';

abstract class UserRepository {

  // - - - - - - - - - - - - - - - - - - SAVE USER INFO - - - - - - - - - - - - - - - - - -  //
  Future<void> saveUserInfo({required UserEntity userEntity});

  // - - - - - - - - - - - - - - - - - - CHECK THE USER IS EXIST - - - - - - - - - - - - - - - - - -  //
  Future<bool> existUser({required String userId});

  // - - - - - - - - - - - - - - - - - - UPDATE USER IMAGE PROFILE - - - - - - - - - - - - - - - - - -  //
  Future<void> updateUserImage({required String userId, required String newImage});

  // - - - - - - - - - - - - - - - - - - UPDATE USER FULL NAME - - - - - - - - - - - - - - - - - -  //
  Future<void> updateUserFullName({required String userId, required String newFirstName, required String newLastName});

  // - - - - - - - - - - - - - - - - - - UPDATE USER EMAIL - - - - - - - - - - - - - - - - - -  //
  // Future<void> updateUserEmail({required String userId, required String newEmail});

  // - - - - - - - - - - - - - - - - - - UPDATE USER PASSWORD - - - - - - - - - - - - - - - - - -  //
  //Future<void> updateUserPassword({required String userId, required String newPassword});

  // - - - - - - - - - - - - - - - - - - UPDATE USER PHONE - - - - - - - - - - - - - - - - - -  //
  Future<void> updateUserPhone({required String userId, required String newPhone});

  // - - - - - - - - - - - - - - - - - - SAVE USER IMAGE - - - - - - - - - - - - - - - - - -  //
  Future<String> saveUserImage({required String imgName, required String imgPath});

  // - - - - - - - - - - - - - - - - - - DELETE USER IMAGE - - - - - - - - - - - - - - - - - -  //
  Future<void> deleteUserImage({required String imgName});

}
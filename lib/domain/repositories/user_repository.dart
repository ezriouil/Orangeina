import 'package:berkania/domain/entities/user_entity.dart';

abstract class UserRepository {

  // - - - - - - - - - - - - - - - - - - GET USER INFO BY ID - - - - - - - - - - - - - - - - - -  //
  Future<UserEntity?> getUserInfo({required String id});

  // - - - - - - - - - - - - - - - - - - SAVE USER INFO - - - - - - - - - - - - - - - - - -  //
  Future<void> saveUserInfo({required UserEntity userEntity});

  // - - - - - - - - - - - - - - - - - - CHECK THE USER IS EXIST - - - - - - - - - - - - - - - - - -  //
  Future<bool> existUser({required String userId});

  // - - - - - - - - - - - - - - - - - - UPDATE USER IMAGE PROFILE - - - - - - - - - - - - - - - - - -  //
  Future<String> updateUserImage({required String userId, required String newImage});

  // - - - - - - - - - - - - - - - - - - UPDATE USER FULL NAME - - - - - - - - - - - - - - - - - -  //
  Future<void> updateUserFullName({required String userId, required String newFirstName, required String newLastName});

  // - - - - - - - - - - - - - - - - - - UPDATE USER EMAIL - - - - - - - - - - - - - - - - - -  //
  Future<void> updateUserAvatar({required String userId, required String newAvatar});

  // - - - - - - - - - - - - - - - - - - UPDATE USER PASSWORD - - - - - - - - - - - - - - - - - -  //
  //Future<void> updateUserPassword({required String userId, required String newPassword});

  // - - - - - - - - - - - - - - - - - - UPDATE USER PHONE - - - - - - - - - - - - - - - - - -  //
  Future<void> updateUserPhone({required String userId, required String newPhone, required String dialCode, required String isoCode});

  // - - - - - - - - - - - - - - - - - - SAVE USER IMAGE - - - - - - - - - - - - - - - - - -  //
  Future<String> saveUserImage({required String imgName, required String imgPath});

  // - - - - - - - - - - - - - - - - - - DELETE USER IMAGE - - - - - - - - - - - - - - - - - -  //
  Future<void> deleteUserImage({required String imgName});

}
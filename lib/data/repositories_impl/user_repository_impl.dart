import 'package:berkania/data/data_source/remote.dart';
import 'package:berkania/data/mappers/user_mapper.dart';
import 'package:berkania/domain/entities/user_entity.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {

  // - - - - - - - - - - - - - - - - - - OVERRIDE IS EXIST METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<bool> existUser({required String userId}) async => await Remote.exist(collection: "USERS", doc: userId);

  // - - - - - - - - - - - - - - - - - - UPDATE USER FULL NAME - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> updateUserFullName({required String userId, required String newFirstName, required String newLastName}) async{
    await Remote.updateFullName(collection: "USERS", doc: userId, newFirstName: newFirstName, newLastName: newLastName);
  }

  // - - - - - - - - - - - - - - - - - - UPDATE USER IMAGE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<String> updateUserImage({required String userId, required String newImage}) async =>
      await Remote.updateImage(path: "USERS", imgName: userId, imgPath: newImage);

  // - - - - - - - - - - - - - - - - - - UPDATE USER PASSWORD - - - - - - - - - - - - - - - - - -  //
  //@override
  //Future<void> updateUserPassword({required String userId, required String newPassword}) async{
  // await Remote.updatePassword(newPassword: newPassword);
  //}

  // - - - - - - - - - - - - - - - - - - UPDATE USER PHONE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> updateUserPhone({required String userId, required String newPhone}) async{
    await Remote.updatePhone(collection: "USERS", doc: userId, newPhone: newPhone);
  }

  // - - - - - - - - - - - - - - - - - - SAVE USER IMAGE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<String> saveUserImage({required String imgName, required String imgPath}) async =>
      await Remote.saveImage(path: "USERS", imgName: imgName, imgPath: imgPath);

  // - - - - - - - - - - - - - - - - - - DELETE USER IMAGE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> deleteUserImage({required String imgName}) async{
    await Remote.deleteUserImage(path: "USERS", imgName: imgName);

  }

  @override
  Future<void> saveUserInfo({required UserEntity userEntity}) async{
    Remote.saveUserData(userDto: userEntity.toUserDto());
  }

}

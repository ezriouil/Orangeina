import 'package:berkania/data/data_source/remote.dart';
import 'package:berkania/data/mappers/user_mapper.dart';
import 'package:berkania/data/models/user_dto.dart';
import 'package:berkania/domain/entities/user_entity.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {

  // - - - - - - - - - - - - - - - - - - OVERRIDE IS EXIST METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<bool> existUser({required String userId}) async => await Remote.exist(collection: "USERS", doc: userId);

  // - - - - - - - - - - - - - - - - - - OVERRIDE UPDATE USER FULL NAME - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> updateUserFullName({required String userId, required String newFirstName, required String newLastName}) async{
    await Remote.updateFullName(collection: "USERS", doc: userId, newFirstName: newFirstName, newLastName: newLastName);
  }

  // - - - - - - - - - - - - - - - - - - OVERRIDE UPDATE AVATAR - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> updateUserAvatar({required String userId, required String newAvatar}) async{
    await Remote.updateAvatar(collection: "USERS", doc: userId, newAvatar: newAvatar);
  }

  // - - - - - - - - - - - - - - - - - - OVERRIDE UPDATE USER IMAGE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<String> updateUserImage({required String userId, required String newImage}) async =>
      await Remote.updateImage(path: "USERS", imgName: userId, imgPath: newImage);

  // - - - - - - - - - - - - - - - - - - OVERRIDE UPDATE USER PASSWORD - - - - - - - - - - - - - - - - - -  //
  //@override
  //Future<void> updateUserPassword({required String userId, required String newPassword}) async{
  // await Remote.updatePassword(newPassword: newPassword);
  //}

  // - - - - - - - - - - - - - - - - - - OVERRIDE UPDATE USER PHONE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> updateUserPhone({required String userId, required String newPhone}) async{
    await Remote.updatePhone(collection: "USERS", doc: userId, newPhone: newPhone);
  }

  // - - - - - - - - - - - - - - - - - - OVERRID ESAVE USER IMAGE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<String> saveUserImage({required String imgName, required String imgPath}) async =>
      await Remote.saveImage(path: "USERS", imgName: imgName, imgPath: imgPath);

  // - - - - - - - - - - - - - - - - - - OVERRIDE DELETE USER IMAGE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> deleteUserImage({required String imgName}) async{
    await Remote.deleteUserImage(path: "USERS", imgName: imgName);

  }

  // - - - - - - - - - - - - - - - - - - OVERRIDE SAVE USER INFO - - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> saveUserInfo({required UserEntity userEntity}) async{
    Remote.saveUserData(userDto: userEntity.toUserDto());
  }

  // - - - - - - - - - - - - - - - - - - OVERRIDE GET USER INFO - - - - - - - - - - - - - - - - - -  //
  @override
  Future<UserEntity?> getUserInfo({required String id}) async{
    final UserDto? userDto = await Remote.getUserData(id: id);
    if(userDto == null) return null;
    return userDto.toUserEntity();
  }


}

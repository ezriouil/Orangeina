import 'package:berkania/data/models/user_dto.dart';

import '../../domain/entities/user_entity.dart';

extension UserEntityMapper on UserEntity {
  UserDto toUserDto() => UserDto(
    id: id,
    firstName: firstName,
    lastName: lastName,
    avatar: avatar,
    email: email,
    phoneNumber: phoneNumber,
      dialCode: dialCode,
      isoCode: isoCode,
    createAt: createAt
  );
}

extension UserDtoMapper on UserDto {
  UserEntity toUserEntity() => UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      avatar: avatar,
      email: email,
      phoneNumber: phoneNumber,
      dialCode: dialCode,
      isoCode: isoCode,
      createAt: createAt
  );
}
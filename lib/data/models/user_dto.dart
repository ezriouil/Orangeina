class UserDto {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  late final String? id,
      firstName,
      lastName,
      avatar,
      email,
      phoneNumber,
      createAt;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR- - - - - - - - - - - - - - - - - -  //
  UserDto(
      {this.id = "",
      this.firstName = "",
      this.lastName = "",
      this.avatar = "",
      this.email = "",
      this.phoneNumber = "",
      this.createAt = ""});

  // - - - - - - - - - - - - - - - - - - TO JSON - - - - - - - - - - - - - - - - - -  //
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'avatar': avatar,
        'email': email,
        'phoneNumber': phoneNumber,
        'createAt': createAt
      };

  // - - - - - - - - - - - - - - - - - - FROM JSON- - - - - - - - - - - - - - - - - -  //
  static UserDto fromJson(Map json) {
    return UserDto(
        id: json['id'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        avatar: json['avatar'] as String,
        email: json['email'] as String,
        phoneNumber: json['phoneNumber'] as String,
        createAt: json['createAt'] as String);
  }
}
class UserEntity {
  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  late final String? id,
      firstName,
      lastName,
      avatar,
      email,
      phoneNumber,
      type,
      createAt;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR- - - - - - - - - - - - - - - - - -  //
  UserEntity(
      {this.id = "",
      this.firstName = "",
      this.lastName = "",
      this.avatar = "",
      this.email = "",
      this.phoneNumber = "",
      this.type = "",
      this.createAt = ""});

  // - - - - - - - - - - - - - - - - - - TO JSON - - - - - - - - - - - - - - - - - -  //
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'avatar': avatar,
        'email': email,
        'phoneNumber': phoneNumber,
        'type': type,
        'createAt': createAt
      };

  // - - - - - - - - - - - - - - - - - - FROM JSON- - - - - - - - - - - - - - - - - -  //
  static UserEntity fromJson(Map json) {
    return UserEntity(
        id: json['id'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        avatar: json['avatar'] as String,
        email: json['email'] as String,
        phoneNumber: json['phoneNumber'] as String,
        type: json['type'] as String,
        createAt: json['createAt'] as String);
  }
}

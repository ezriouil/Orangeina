class WishListDto {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  late final String? id,
      userId,
      vendorId,
      avatar,
      fullName,
      phoneNumber,
      dialCode,
      createAt;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR- - - - - - - - - - - - - - - - - -  //
  WishListDto(
      {this.id = "",
      this.userId = "",
      this.vendorId = "",
      this.avatar = "",
      this.fullName = "",
      this.phoneNumber = "",
      this.dialCode = "",
      this.createAt = ""});

  // - - - - - - - - - - - - - - - - - - TO JSON - - - - - - - - - - - - - - - - - -  //
  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'vendorId': vendorId,
        'avatar': avatar,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'dialCode': dialCode,
        'createAt': createAt
      };

  // - - - - - - - - - - - - - - - - - - FROM JSON- - - - - - - - - - - - - - - - - -  //
  static WishListDto fromJson(Map json) {
    return WishListDto(
        id: json['id'] as String,
        userId: json['userId'] as String,
        vendorId: json['vendorId'] as String,
        avatar: json['avatar'] as String,
        fullName: json['fullName'] as String,
        phoneNumber: json['phoneNumber'] as String,
        dialCode: json['dialCode'] as String,
        createAt: json['createAt'] as String);
  }

}

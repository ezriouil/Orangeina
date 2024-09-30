class WishListEntity {

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
  WishListEntity(
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
        'phone': phoneNumber,
        'dialCode': dialCode,
        'createAt': createAt
      };

  // - - - - - - - - - - - - - - - - - - FROM JSON- - - - - - - - - - - - - - - - - -  //
  static WishListEntity fromJson(Map json) {
    return WishListEntity(
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

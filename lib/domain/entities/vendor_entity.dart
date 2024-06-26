class VendorEntity{

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  late final int? totalOrders, birthdayYear;

  late final num? shopLat, shopLng, averageRating;

  late final bool? isOnline, visible;

  late final List<dynamic>? paperImages;

  late final String? id,
      firstName,
      lastName,
      cin,
      avatar,
      email,
      phoneNumber,
      gender,
      shopThumbnail,
      carAssurance,
      carRegistration,
      carType,
      uploadedPaperImagesAt,
      createAt;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR- - - - - - - - - - - - - - - - - -  //
  VendorEntity(
      {this.id = "",
      this.firstName = "",
      this.lastName = "",
      this.cin = "",
      this.avatar = "",
      this.email = "",
      this.phoneNumber = "",
      this.gender = "",
      this.shopThumbnail = "",
      this.carAssurance = "",
      this.carRegistration = "",
      this.carType = "",
      this.isOnline = false,
      this.visible = false,
      this.averageRating = 0.0,
      this.birthdayYear = 0,
      this.totalOrders = 0,
      this.shopLat = 0.0,
      this.shopLng = 0.0,
      this.uploadedPaperImagesAt = "",
      this.paperImages =  const <String>[],
      this.createAt = ""});

  // - - - - - - - - - - - - - - - - - - TO JSON - - - - - - - - - - - - - - - - - -  //
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'cin': cin,
        'avatar': avatar,
        'email': email,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'shopThumbnail': shopThumbnail,
        'carAssurance': carAssurance,
        'carRegistration': carRegistration,
        'carType': carType,
        'isOnline': isOnline,
        'visible': visible,
        'averageRating': averageRating,
        'birthdayYear': birthdayYear,
        'totalOrders': totalOrders,
        'shopLat': shopLat,
        'shopLng': shopLng,
        'uploadedPaperImagesAt': uploadedPaperImagesAt,
        'paperImages': paperImages,
        'createAt': createAt
      };

  // - - - - - - - - - - - - - - - - - - FROM JSON- - - - - - - - - - - - - - - - - -  //
  static VendorEntity fromJson(Map json) {
    return VendorEntity(
        id: json['id'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        cin: json['cin'] as String,
        avatar: json['avatar'] as String,
        email: json['email'] as String,
        phoneNumber: json['phoneNumber'] as String,
        gender: json['gender'] as String,
        shopThumbnail: json['shopThumbnail'] as String,
        carAssurance: json['carAssurance'] as String,
        carRegistration: json['carRegistration'] as String,
        carType: json['carType'] as String,
        isOnline: json['isOnline'] as bool,
        visible: json['visible'] as bool,
        averageRating: json['averageRating'] as num,
        birthdayYear: json['birthdayYear'] as int,
        totalOrders: json['totalOrders'] as int,
        shopLat: json['shopLat'] as num,
        shopLng: json['shopLng'] as num,
        uploadedPaperImagesAt: json['uploadedPaperImagesAt'] as String,
        paperImages: json['paperImages'] as List<dynamic>,
        createAt: json['createAt'] as String);
  }
}


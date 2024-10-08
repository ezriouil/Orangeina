class ReviewDto {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  late num rating;
  late final String? id,
      vendorId,
      viewerId,
      fullName,
      reviewBody,
      avatar,
      createAt;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR- - - - - - - - - - - - - - - - - -  //
  ReviewDto(
      {this.id = "",
      this.vendorId = "",
      this.viewerId = "",
      this.fullName = "",
      this.reviewBody = "",
      this.avatar = "",
      this.rating = 0,
      this.createAt = ""});

  // - - - - - - - - - - - - - - - - - - TO JSON - - - - - - - - - - - - - - - - - -  //
  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'vendorId': vendorId,
        'viewerId': viewerId,
        'reviewBody': reviewBody,
        'avatar': avatar,
        'rating': rating,
        'createAt': createAt
      };

  // - - - - - - - - - - - - - - - - - - FROM JSON- - - - - - - - - - - - - - - - - -  //
  static ReviewDto fromJson(Map json) {
    return ReviewDto(
        id: json['id'] as String,
        fullName: json['fullName'] as String,
        vendorId: json['vendorId'] as String,
        viewerId: json['viewerId'] as String,
        reviewBody: json['reviewBody'] as String,
        avatar: json['avatar'] as String,
        rating: json['rating'] as num,
        createAt: json['createAt'] as String);
  }
}

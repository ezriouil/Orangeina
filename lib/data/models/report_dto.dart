class ReportDto {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  late num rating;
  late final String? id,
      vendorId,
      fullName,
      reportType,
      reportBody,
      avatar,
      createAt;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR- - - - - - - - - - - - - - - - - -  //
  ReportDto(
      {this.id = "",
      this.vendorId = "",
      this.fullName = "",
      this.reportType = "",
      this.reportBody = "",
      this.avatar = "",
      this.rating = 0,
      this.createAt = ""});

  // - - - - - - - - - - - - - - - - - - TO JSON - - - - - - - - - - - - - - - - - -  //
  Map<String, dynamic> toJson() => {
        'id': id,
        'vendorId': vendorId,
        'fullName': fullName,
        'reportType': reportType,
        'reportBody': reportBody,
        'avatar': avatar,
        'rating': rating,
        'createAt': createAt
      };

  // - - - - - - - - - - - - - - - - - - FROM JSON- - - - - - - - - - - - - - - - - -  //
  static ReportDto fromJson(Map json) {
    return ReportDto(
        id: json['id'] as String,
        fullName: json['fullName'] as String,
        vendorId: json['vendorId'] as String,
        reportType: json['reportType'] as String,
        reportBody: json['reportBody'] as String,
        avatar: json['avatar'] as String,
        rating: json['rating'] as num,
        createAt: json['createAt'] as String);
  }
}

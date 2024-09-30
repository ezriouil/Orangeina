class ReportDto {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
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
      this.createAt = ""});

  // - - - - - - - - - - - - - - - - - - TO JSON - - - - - - - - - - - - - - - - - -  //
  Map<String, dynamic> toJson() => {
        'id': id,
        'vendorId': vendorId,
        'fullName': fullName,
        'reportType': reportType,
        'reportBody': reportBody,
        'avatar': avatar,
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
        createAt: json['createAt'] as String);
  }
}

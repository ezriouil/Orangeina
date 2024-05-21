class OrderDto {

  // - - - - - - - - - - - - - - - - - - STATES - - - - - - - - - - - - - - - - - -  //
  late final  int? quantity;
  late final  double? priceEachKg, total;
  late final String? id,
      vendorFullName,
      vendorId,
      selectedDate,
      status,
      createAt;

  // - - - - - - - - - - - - - - - - - - CONSTRUCTOR- - - - - - - - - - - - - - - - - -  //
  OrderDto(
      {this.id = "",
      this.vendorFullName = "",
      this.vendorId = "",
      this.priceEachKg = 0.0,
        this.total = 0.0,
      this.quantity = 0,
      this.selectedDate = "",
      this.status = "",
      this.createAt = ""});

  // - - - - - - - - - - - - - - - - - - TO JSON - - - - - - - - - - - - - - - - - -  //
  Map<String, dynamic> toJson() => {
        'id': id,
        'vendorFullName': vendorFullName,
        'vendorId': vendorId,
        'priceEachKg': priceEachKg,
        'total': total,
        'quantity': quantity,
        'selectedDate': selectedDate,
        'status': status,
        'createAt': createAt,
      };

  // - - - - - - - - - - - - - - - - - - FROM JSON- - - - - - - - - - - - - - - - - -  //
  static OrderDto fromJson(Map json) {
    return OrderDto(
        id: json['id'] as String,
        vendorFullName: json['vendorFullName'] as String,
        vendorId: json['vendorId'] as String,
        priceEachKg: json['priceEachKg'] as double,
        total: json['total'] as double,
        quantity: json['quantity'] as int,
        selectedDate: json['selectedDate'] as String,
        status: json['status'] as String,
        createAt: json['createAt'] as String);
  }
}

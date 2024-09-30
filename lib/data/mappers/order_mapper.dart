import 'package:berkania/data/models/order_dto.dart';
import '../../domain/entities/order_entity.dart';

extension OrderEntityMapper on OrderEntity {
  OrderDto toOrderDto() => OrderDto(
    id: id,
    vendorId: vendorId,
    priceEachKg: priceEachKg,
    total: total,
    quantity: quantity,
    selectedDate: selectedDate,
    status: status,
    createAt: createAt
  );
}

extension OrderDtoMapper on OrderDto {
  OrderEntity toOrderEntity() => OrderEntity(
      id: id,
      vendorId: vendorId,
      priceEachKg: priceEachKg,
      total: total,
      quantity: quantity,
      selectedDate: selectedDate,
      status: status,
      createAt: createAt
  );
}
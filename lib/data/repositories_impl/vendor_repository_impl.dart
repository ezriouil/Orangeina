import 'package:berkania/data/mappers/order_mapper.dart';
import 'package:berkania/data/mappers/vendor_mapper.dart';
import 'package:berkania/data/models/order_dto.dart';
import 'package:berkania/data/models/vendor_dto.dart';
import 'package:berkania/domain/entities/order_entity.dart';
import 'package:berkania/domain/entities/vendor_entity.dart';

import '../../domain/repositories/vendor_repository.dart';
import '../data_source/remote.dart';

class VendorRepositoryImpl extends VendorRepository {

  // - - - - - - - - - - - - - - - - - - OVERRIDE GET ALL VENDORS FROM METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<List<VendorEntity>> getAllVendors() async{

    final List<VendorEntity> vendorsEntity = [];
    final List<VendorDto> vendorsDto = await Remote.getAllVendors();

    if(vendorsDto.isNotEmpty){
      for(VendorDto vendorDto in vendorsDto){
        vendorsEntity.add(vendorDto.toVendorEntity());
      }
    }

    return vendorsEntity;
  }

  @override
  Future<bool> existVendor({required String vendorId}) async => Remote.exist(collection: "VENDORS", doc: vendorId);

  // @override
  // Future<void> updateVendorEmail({required String vendorId, required String newEmail}) async{
  //   await Remote.updateEmail(collection: "VENDORS", doc: vendorId, newEmail: newEmail);
  // }

  @override
  Future<void> updateVendorFullName({required String vendorId, required String newFirstName, required String newLastName}) async{
    await Remote.updateFullName(collection: "VENDORS", doc: vendorId, newFirstName: newFirstName, newLastName: newLastName);
  }


  //@override
  //Future<void> updateVendorPassword({required String vendorId, required String newPassword}) async =>
  //await Remote.updateImage(path: "VENDORS", imgName: "VENDORS", imgPath: newPassword);

  @override
  Future<void> updateVendorPhone({required String vendorId, required String newPhone}) async{
    await Remote.updatePhone(collection: "VENDORS", doc: vendorId, newPhone: newPhone);
  }

  @override
  Future<String> saveVendorImage({required String imgName, required String imgPath})  async =>
      await Remote.saveImage(path: "VENDORS", imgName: imgName, imgPath: imgPath);


  @override
  Future<void> deleteVendorImage({required String imgName}) async{
    await Remote.deleteUserImage(path: "VENDORS", imgName: imgName);
  }

  @override
  Future<void> offline({ required String vendorId }) async{
    await Remote.vendorOffline(vendorId: vendorId);
  }

  @override
  Future<void> online({ required String vendorId }) async{
    await Remote.vendorOnline(vendorId: vendorId);
  }

  @override
  Future<List<OrderEntity>> getAllOrders({required String vendorId}) async {
    final List<OrderEntity> ordersEntity = [];
    final List<OrderDto> ordersDto = await Remote.getAllOrdersByVendorId(vendorId: vendorId);

    if(ordersDto.isNotEmpty){
      for(OrderDto ordersDto in ordersDto){
        ordersEntity.add(ordersDto.toOrderEntity());
      }
    }

    return ordersEntity;
  }

  @override
  Future<void> newOrder({required OrderEntity orderEntity}) async{
    await Remote.newOrder(orderDto: orderEntity.toOrderDto());
  }

  @override
  Future<double> getProductCurrentPrice() async => await Remote.productCurrentPrice();

  @override
  Future<VendorEntity?> getVendorById({required String vendorId}) async{
    final vendorDto = await Remote.getVendorById(vendorId: vendorId);
    if(vendorDto == null) return null;
    return vendorDto.toVendorEntity();
  }

}

import 'package:berkania/data/mappers/notification_mapper.dart';
import 'package:berkania/data/models/notification_dto.dart';
import 'package:berkania/domain/entities/notification_entity.dart';
import 'package:berkania/domain/repositories/notification_repository.dart';

import '../data_source/remote.dart';

class NotificationRepositoryImpl extends NotificationRepository {

  // - - - - - - - - - - - - - - - - - - OVERRIDE GET ALL NOTIFICATION METHODE - - - - - - - - - - - - - - - - - -  //
  @override
  Future<List<NotificationEntity>> getAllNotifications({required String id}) async{
    final List<NotificationEntity> notificationsEntity = [];
    final List<NotificationDto> notificationsDto = await Remote.getAllNotification(userId: id);

    if(notificationsDto.isNotEmpty){
      for(NotificationDto notificationsDto in notificationsDto){
        notificationsEntity.add(notificationsDto.toNotificationEntity());
      }
    }

    return notificationsEntity;
  }

  // - - - - - - - - - - - - - - - - - - OVERRIDE DELETE NOTIFICATION BY ID- - - - - - - - - - - - - - - - - -  //
  @override
  Future<void> deleteNotificationById({required String id}) async{
    await Remote.deleteNotificationById(id: id);
  }


}

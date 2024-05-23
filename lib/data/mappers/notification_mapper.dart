import 'package:berkania/data/models/notification_dto.dart';
import 'package:berkania/domain/entities/notification_entity.dart';

extension NotificationEntityMapper on NotificationEntity {
  NotificationDto toNotificationDto() => NotificationDto(
        id: id,
        userId: userId,
        title: title,
        body: body,
        type: type,
        isRead: isRead,
        createAt: createAt,
      );
}

extension NotificationDtoMapper on NotificationDto {
  NotificationEntity toNotificationEntity() => NotificationEntity(
        id: id,
        userId: userId,
        title: title,
        body: body,
        type: type,
        isRead: isRead,
        createAt: createAt,
      );
}

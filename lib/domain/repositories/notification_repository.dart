import 'package:berkania/domain/entities/notification_entity.dart';

abstract class NotificationRepository {

  // - - - - - - - - - - - - - - - - - - GET ALL NOTIFICATIONS - - - - - - - - - - - - - - - - - -  //
  Future<List<NotificationEntity>> getAllNotifications({ required String id });

  // - - - - - - - - - - - - - - - - - - DELETE NOTIFICATION BY ID - - - - - - - - - - - - - - - - - -  //
  Future<void> deleteNotificationById({ required String id });

  // - - - - - - - - - - - - - - - - - - READ NOTIFICATION BY ID - - - - - - - - - - - - - - - - - -  //
  Future<void> readNotification({ required String id });

  // - - - - - - - - - - - - - - - - - - SEND NOTIFICATION - - - - - - - - - - - - - - - - - -  //
  Future<void> sendNotification({ required NotificationEntity notificationEntity });

}
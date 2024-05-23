import 'package:berkania/domain/entities/notification_entity.dart';
import 'package:berkania/domain/repositories/notification_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/local/storage/local_storage.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {

  final NotificationRepository notificationRepository;
  final GetStorage storage;
  NotificationCubit({ required this.notificationRepository, required this.storage}) : super(NotificationLoadingState()){  init();  }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init() async{
    emit(NotificationMainState(notifications: [NotificationEntity()]));
    //await getNotifications();
  }

  // - - - - - - - - - - - - - - - - - - REFRESH - - - - - - - - - - - - - - - - - -  //
  void onRefresh()async{
    emit(NotificationLoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    await getNotifications();
  }

  // - - - - - - - - - - - - - - - - - - GET / REFRESH NOTIFICATIONS - - - - - - - - - - - - - - - - - -  //
  Future<void> getNotifications()async {
    try{
      final String? uid = await LocalStorage.read(key: "UID", storage: storage);
      if(uid == null) {
        emit(NotificationEmptyState());
        return;
      }
      final List<NotificationEntity> notifications = await notificationRepository.getAllNotifications(id: uid);

      if(notifications.isEmpty) {
        emit(NotificationEmptyState());
        return;
      }
      emit(NotificationMainState(notifications: notifications));
    }catch(e){
      emit(NotificationErrorState(message: e.toString()));
    }
  }


}

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/domain/entities/notification_entity.dart';
import 'package:berkania/domain/repositories/notification_repository.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/helpers/network.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_colors.dart';
import '../../utils/local/storage/local_storage.dart';
import '../../utils/localisation/custom_locale.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_snackbars.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {

  final NotificationRepository notificationRepository;
  final GetStorage storage;
  final Connectivity connectivity;
  String? uid;
  final BuildContext context;

  NotificationCubit({ required this.context, required this.notificationRepository, required this.storage, required this.connectivity}) : super(NotificationLoadingState()){ init(context: context); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init({ required BuildContext context }) async{
     uid = await LocalStorage.read(key: "UID", storage: storage);
     if(uid == null) {
       await LocalStorage.upsert(key: "INIT_LOCATION", value: "LOGIN", storage: storage);
       context.pushReplacementNamed(CustomRouter.LOGIN);
       return;
     }
    await getNotifications();
  }

  // - - - - - - - - - - - - - - - - - - REFRESH - - - - - - - - - - - - - - - - - -  //
  void onRefresh({ required BuildContext context })async{

    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }
    emit(NotificationLoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    await getNotifications();
  }

  // - - - - - - - - - - - - - - - - - - ON CLICK - - - - - - - - - - - - - - - - - -  //
  void onClick({ required BuildContext context, required NotificationEntity notification })async{
    try{

      if(notification.type! == "ORDER_STATUS"){

        // MAKE THE NOTIFICATION READ
        if(!notification.isRead!) await notificationRepository.readNotification(id: notification.id!);

        // NAVIGATE TO ORDERS SCREEN
        if(context.mounted) context.pushNamed(CustomRouter.VENDOR_ORDERS);

        return;
      }

      // MAKE THE NOTIFICATION READ
      if(!notification.isRead!) await notificationRepository.readNotification(id: notification.id!);


      // SHOW ALERT DIALOG OD NOTIFICATION BODY
      await showDialog(
          context: context.mounted ? context : context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SizedBox(
                width: double.infinity,
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Row(
                      children: [
                        const Icon(Iconsax.notification, size: 22.0, color: CustomColors.GRAY_LIGHT),
                        Text(" ${CustomLocale.NOTIFICATION_TITLE.getString(context)}", style: Theme.of(context).textTheme.bodySmall),
                        const Spacer(),
                        InkWell(onTap: context.pop , borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT), child: Transform.rotate(angle: 0.8, child: const Icon(Iconsax.add_circle, size: 22.0, color: CustomColors.GRAY_LIGHT))),
                      ],
                    ),

                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                    Text(notification.title!, style: Theme.of(context).textTheme.bodyLarge, maxLines: 1, overflow: TextOverflow.ellipsis),

                    const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                    Text(notification.body!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12.0), overflow: TextOverflow.ellipsis,maxLines: 10),
                  ],
                ),
              ),
            );
          });

      if(!notification.isRead!) await getNotifications();

    }catch(_){
      emit(NotificationEmptyState());
    }
  }

  // - - - - - - - - - - - - - - - - - - DELETE - - - - - - - - - - - - - - - - - -  //
  void onDelete({ required BuildContext context, required String id })async{
    try{
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SizedBox(
                width: double.infinity,
                height: 150,
                child: Column(
                  children: [

                    CustomElevatedButton(
                        child: Text(CustomLocale.NOTIFICATION_DIALOG_DELETE_TITLE.getString(context.mounted ? context : context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE)),
                        onClick: () async{

                          context.pop();
                          await Future.delayed(const Duration(milliseconds: 300));
                          emit(NotificationLoadingState());
                          await notificationRepository.deleteNotificationById(id: id);
                          await Future.delayed(const Duration(milliseconds:  300));
                          await getNotifications();

                        }
                    ),

                    CustomElevatedButton(
                        onClick: context.pop,
                        child: Text(CustomLocale.NOTIFICATION_DIALOG_DISMISS_TITLE.getString(context.mounted ? context : context), style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: CustomColors.WHITE))),

                  ],
                ),
              ),
            );
          });

    }catch(_){
      context.mounted ? CustomSnackBar.show(context: context, title: CustomLocale.ERROR_TITLE.getString(context), subTitle: CustomLocale.NOTIFICATION_ERROR_DELETE_NOTIFICATION_SUB_TITLE.getString(context), type: ContentType.failure) : null;
    }
  }


  // - - - - - - - - - - - - - - - - - - GET / REFRESH NOTIFICATIONS - - - - - - - - - - - - - - - - - -  //
  Future<void> getNotifications()async {
    try{
      if(uid == null) {
        emit(NotificationEmptyState());
        return;
      }

      final List<NotificationEntity> notifications = await notificationRepository.getAllNotifications(id: uid!);
      if(notifications.isEmpty) {
        emit(NotificationEmptyState());
        return;
      }
      emit(NotificationMainState(notifications: notifications));
    }catch(e){
      emit(NotificationEmptyState());
    }
  }
}
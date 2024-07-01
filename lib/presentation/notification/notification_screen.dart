import 'package:berkania/domain/entities/notification_entity.dart';
import 'package:berkania/presentation/notification/notification_cubit.dart';
import 'package:berkania/presentation/notification/widgets/custom_notification.dart';
import 'package:berkania/presentation/widgets/custom_empty_screen.dart';
import 'package:berkania/presentation/widgets/custom_error_screen.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_sizes.dart';
import '../../utils/localisation/custom_locale.dart';
import '../index/index_cubit.dart';

class NotificationScreen extends CustomState {
  const NotificationScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(onTap: (){ context.read<IndexCubit>().onUpdateCurrentIndex(0, context); }, borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2), child: Icon(isArabic(context) ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2, color: darkLightColor(context))),
        title: Text(CustomLocale.NOTIFICATIONS_TITLE.getString(context), style: Theme.of(context).textTheme.bodyLarge),
        actions: [InkWell(
          onTap: (){ context.read<NotificationCubit>().onRefresh(context: context); },
          borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
          child: Padding(
            padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS),
            child: Icon( Iconsax.refresh, size: 20, color: darkLightColor(context)),
          ),
        )],
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          switch(state){


             case NotificationMainState(): return ListView.builder(
                 itemCount: state.notifications!.length,
                  itemBuilder: (context, index) => CustomNotification(
                      notificationEntity: state.notifications![index],
                      onClick: (NotificationEntity notification){ context.read<NotificationCubit>().onClick(context: context, notification: notification); },
                      onDelete: (String id) { context.read<NotificationCubit>().onDelete(context: context, id: id); }
                  )
             );

            case NotificationLoadingState(): return const CustomLoadingScreen();
            case NotificationErrorState(): return CustomErrorScreen(onClick: context.read<NotificationCubit>().init);
            case NotificationEmptyState(): return CustomEmptyScreen(text: CustomLocale.NOTIFICATION_EMPTY_LIST_TITLE.getString(context));
          }
        },
      ),
    );
  }
}

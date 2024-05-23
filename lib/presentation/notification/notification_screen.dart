import 'package:berkania/presentation/notification/notification_cubit.dart';
import 'package:berkania/presentation/widgets/custom_empty_screen.dart';
import 'package:berkania/presentation/widgets/custom_error_screen.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_sizes.dart';

class NotificationScreen extends CustomState {
  const NotificationScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          switch(state){
            case NotificationMainState(): return Center(child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                  margin: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                  decoration: BoxDecoration(border: Border.all(color: grayColor(context)), borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2), color: primaryColor(context).withOpacity(0.2)),
                  width: getWidth(context),
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        Icon(Iconsax.notification, size: 24.0, color: darkLightColor(context)),
                        Text("  Notification", style: Theme.of(context).textTheme.bodyMedium),
                        const Spacer(),
                        Text("20/05/2024", style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12.0)),
                        //InkWell(onTap: (){}, borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT), child: Transform.rotate(angle: 0.8, child: Icon(Iconsax.add_circle, size: 22.0, color: darkLightColor(context)))),
                      ]),
                      Text("New gift for you", style: Theme.of(context).textTheme.bodySmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                        Text(
                            "Hello Berkania client we want to inform you Hello Berkania client we want to inform you client we want to inform you client we want to inform you",
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ],
                  ),
                )
              ],
            ));

            // case NotificationMainState(): return ListView.builder(
            //     itemCount: state.notifications!.length,
            //     itemBuilder: (context, index) => CustomWishList(wishListEntity: state.notifications![index], onDelete: (String id){ context.read<WishlistCubit>().onDeleteWishList( id : id, callBack : (){ /*SHOW SNACK BAR*/} ); }));

            case NotificationLoadingState(): return const CustomLoadingScreen();
            case NotificationErrorState(): return CustomErrorScreen(onClick: (){});
            case NotificationEmptyState(): return const CustomEmptyScreen(text: "No Notifications Founded");
          }
        },
      ),
    );
  }
}

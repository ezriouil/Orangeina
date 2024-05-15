import 'package:berkania/presentation/notification/notification_cubit.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends CustomState {
  const NotificationScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          switch(state){
            case NotificationCurrentState(): return Center(child: Column(
              children: [
                Text("Notification screen", style: Theme.of(context).textTheme.bodyLarge)
              ],
            ));
            case NotificationLoadingState(): return Center(child: Text("Loading ...", style: Theme.of(context).textTheme.bodyLarge));
            case NotificationErrorState(): return Center(child: Text(state.message, style: Theme.of(context).textTheme.bodyLarge));
          }
        },
      ),
    );
  }
}

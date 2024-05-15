import 'package:berkania/presentation/index/index_cubit.dart';
import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:iconsax/iconsax.dart';

class IndexScreen extends CustomState {
  const IndexScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return BlocBuilder<IndexCubit, IndexState>(
      builder: (context, state) {
        switch(state){
          case IndexCurrentState():
          {
            return Scaffold(
              body: context.read<IndexCubit>().screens()[state.currentPageIndex!],
              bottomNavigationBar: NavigationBar(
                height: 70.0,
                elevation: 0.0,
                animationDuration: const Duration(seconds: 3),
                selectedIndex: state.currentPageIndex!,
                onDestinationSelected: context.read<IndexCubit>().onUpdateCurrentIndex,
                destinations: [
                  NavigationDestination(icon: const Icon(Iconsax.map), label: CustomLocale.INDEX_EXPLORE_TITLE.getString(context)),
                  NavigationDestination(icon: const Icon(Iconsax.heart), label: CustomLocale.INDEX_WISHLIST_TITLE.getString(context)),
                  NavigationDestination(icon: const Icon(Iconsax.notification), label: CustomLocale.INDEX_NOTIFICATION_TITLE.getString(context)),
                  NavigationDestination(icon: const Icon(Iconsax.user), label: CustomLocale.INDEX_PROFILE_TITLE.getString(context))
                ],
              ),
            );
          }
        }
      },
    );
  }
}

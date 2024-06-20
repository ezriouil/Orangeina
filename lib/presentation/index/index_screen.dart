import 'package:berkania/presentation/index/index_cubit.dart';
import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/custom_animations_strings.dart';
import '../../utils/constants/custom_sizes.dart';
import '../widgets/custom_elevated_button.dart';

class IndexScreen extends CustomState {
  const IndexScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return BlocBuilder<IndexCubit, IndexState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: switch (state) {
            IndexMainState() => NavigationBar(
                height: 70.0,
                elevation: 0.0,
                animationDuration: const Duration(seconds: 3),
                selectedIndex: state.currentPageIndex!,
                onDestinationSelected: context.read<IndexCubit>().onUpdateCurrentIndex,
                destinations: [
                  NavigationDestination(icon: const Icon(Iconsax.map), label: CustomLocale.INDEX_EXPLORE_TITLE.getString(context)),
                  NavigationDestination(icon: const Icon(Iconsax.heart), label: CustomLocale.INDEX_WISHLIST_TITLE.getString(context)),
                  NavigationDestination(icon: const Icon(Iconsax.notification), label: CustomLocale.INDEX_NOTIFICATION_TITLE.getString(context)),
                  NavigationDestination(icon: const Icon(Iconsax.setting), label: CustomLocale.INDEX_SETTINGS_TITLE.getString(context))
                ],
              ),
            IndexPermissionState() => null
          },
          body: switch (state) {
            IndexMainState() => context.read<IndexCubit>().screens()[state.currentPageIndex!],
            IndexPermissionState() => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                  child: SizedBox(
                    height: getHeight(context),
                    width: getWidth(context),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.asset(
                          isDark(context) ? CustomAnimationStrings.PIN_LOCATION_ANIMATION_LIGHT : CustomAnimationStrings.PIN_LOCATION_ANIMATION_DARK,
                          width: 100.0,
                          height: 100.0,
                          repeat: true,
                        ),
                        const SizedBox(height: CustomSizes.SPACE_DEFAULT),
                        Text(CustomLocale.HOME_PERMISSION_TITLE.getString(context), style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                        Text(CustomLocale.HOME_PERMISSION_SUB_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
                        const SizedBox(height: CustomSizes.SPACE_DEFAULT),
                        CustomElevatedButton(onClick: context.read<IndexCubit>().onRequestPermission,
                            width: getWidth(context) / 2,
                            height: 70.0,
                            backgroundColor: darkLightColor(context),
                            child: Text(CustomLocale.HOME_PERMISSION_BUTTON_ENABLE.getString(context), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: darkDarkLightLightColor(context), letterSpacing: 1)))
                      ],
                    ),
                  ),
                ),
              ),
          },
        );
      },
    );
  }

}
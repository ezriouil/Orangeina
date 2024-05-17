import 'package:berkania/presentation/settings/settings_cubit.dart';
import 'package:berkania/presentation/settings/widgets/custom_settings_tile.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_sizes.dart';

class SettingsScreen extends CustomState {
  const SettingsScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          switch (state) {
            case SettingsCurrentState():
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: CustomSizes.SPACE_BETWEEN_ITEMS),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                        // - - - - - - - - - - - - - - - - - -  Display - - - - - - - - - - - - - - - - - -  //
                        Text("Display", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: grayColor(context), letterSpacing: 0.6)),

                        // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                        // - - - - - - - - - - - - - - - - - - DARK MODE - - - - - - - - - - - - - - - - - -  //
                        CustomSettingTile(
                          title: "Dark Mode",
                          subTitle: "Enjoy the new theme design for you ...",
                          icon: Iconsax.colorfilter,
                          trailing: Switch(
                              value: state.enableDarkMode!,
                              onChanged: (value) { context.read<SettingsCubit>().onUpdateEnableDarkMode(value); }),
                        ),

                        // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                        // - - - - - - - - - - - - - - - - - - SHOW MY LOCATION ON MAP - - - - - - - - - - - - - - - - - -  //
                        CustomSettingTile(
                          title: "Show My Location",
                          subTitle: "Enjoy the new theme design for you ...",
                          icon: Iconsax.location,
                          trailing: Switch(value: state.showMyLocationOnMap!, onChanged: context.read<SettingsCubit>().onUpdateEnableFullScreen),
                        ),

                        // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                        // - - - - - - - - - - - - - - - - - - MAP SATELLITE- - - - - - - - - - - - - - - - - -  //
                        CustomSettingTile(
                          title: "Map Satellite",
                          subTitle: "Enjoy the new theme design for you ...",
                          icon: Iconsax.map,
                          trailing: Switch(value: state.enableMapSatellite!, onChanged: context.read<SettingsCubit>().onUpdateEnableMapSatellite),
                        ),

                        // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                        // - - - - - - - - - - - - - - - - - - HIDE AUTHENTICATION - - - - - - - - - - - - - - - - - -  //
                        CustomSettingTile(
                          title: "Hide Authentication",
                          subTitle: "Enjoy the new theme design for you ...",
                          icon: Iconsax.security_safe,
                          trailing: Switch(value: true, onChanged: (value) {}),
                        ),

                        // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                        // - - - - - - - - - - - - - - - - - -  OTHERS - - - - - - - - - - - - - - - - - -  //
                        Text("Others", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: grayColor(context), letterSpacing: 0.6)),

                        // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                        // - - - - - - - - - - - - - - - - - - PRIVACY AND SECURITY - - - - - - - - - - - - - - - - - -  //
                        CustomSettingTile(
                            title: "Privacy And Security",
                            subTitle: "Enjoy the new theme design for you ...",
                            icon: Iconsax.lock,
                            trailing: Icon(Iconsax.arrow_right_3, size: 32, color: darkLightColor(context))),

                        // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                        // - - - - - - - - - - - - - - - - - - HELP AND SUPPORT - - - - - - - - - - - - - - - - - -  //
                        CustomSettingTile(
                            title: "Help And Support",
                            subTitle: "Enjoy the new theme design for you ...",
                            icon: Iconsax.headphone5,
                            trailing: Icon(Iconsax.arrow_right_3, size: 32, color: darkLightColor(context))),

                        // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                        // - - - - - - - - - - - - - - - - - - ABOUT - - - - - - - - - - - - - - - - - -  //
                        CustomSettingTile(
                            title: "About",
                            subTitle: "Enjoy the new theme design for you ...",
                            icon: Iconsax.info_circle,
                            trailing: Icon(Iconsax.arrow_right_3, size: 32, color: darkLightColor(context))),

                        // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                        const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS * 2),

                        // - - - - - - - - - - - - - - - - - -  VERSION  - - - - - - - - - - - - - - - - - -  //
                        Center(child: Text("version 1.0.0", style: Theme.of(context).textTheme.bodySmall)),
                      ]
                  )
              );
            case SettingsLoadingState():
              return Center(
                  child: Text("Loading ...",
                      style: Theme.of(context).textTheme.bodyLarge));
            case SettingsErrorState():
              return Center(
                  child: Text(state.message,
                      style: Theme.of(context).textTheme.bodyLarge));
          }
        },
      ),
    );
  }
}

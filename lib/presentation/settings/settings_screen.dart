import 'package:berkania/presentation/settings/settings_cubit.dart';
import 'package:berkania/presentation/settings/widgets/custom_settings_tile.dart';
import 'package:berkania/presentation/widgets/custom_error_screen.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/utils/constants/custom_image_strings.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_sizes.dart';
import '../../utils/localisation/custom_locale.dart';

class SettingsScreen extends CustomState {
  const SettingsScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          switch (state) {
            case SettingsMainState():
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: CustomSizes.SPACE_BETWEEN_ITEMS),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                    
                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                          // - - - - - - - - - - - - - - - - - -  Display - - - - - - - - - - - - - - - - - -  //
                          Text(CustomLocale.SETTINGS_PROFILE_TITLE.getString(context), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: grayColor(context), letterSpacing: 0.6)),

                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                          // - - - - - - - - - - - - - - - - - - IMAGE FROM NETWORK - - - - - - - - - - - - - - - - - -  //
                          Center(
                            child: InkWell(
                              onTap: (){ context.read<SettingsCubit>().onUpdateImageProfile(context: context); },
                              borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                              child: Stack(
                               children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS),
                                    child: SizedBox(
                                      width: 140,
                                      height: 140.0,
                                      child: Image.network(state.updateImageProfilePath ?? CustomImageStrings.DEFAULT_IMAGE_PROFILE,
                                          height: getHeight(context),
                                          width: getWidth(context),
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) => loadingProgress == null ? child : Container(alignment: Alignment.center, decoration: BoxDecoration(borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT), border: Border.all(color: darkLightColor(context))), child: CircularProgressIndicator(color: primaryColor(context))),
                                        errorBuilder: (context, url, error) => Container(alignment: Alignment.center, decoration: BoxDecoration(borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT), border: Border.all(color: darkLightColor(context))), child: Icon(Iconsax.gallery_remove, size: 30.0, color: grayColor(context)))),
                                  ),
                                  ),
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 4),
                                        decoration: BoxDecoration(
                                            color: darkDarkLightLightColor(context),
                                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2))),
                                        child: Icon(
                                          Iconsax.gallery_edit,
                                          color: darkLightColor(context),
                                          size: 20.0,
                                        ))),
                              ]
                              ),
                            ),
                          ),

                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                          // - - - - - - - - - - - - - - - - - - CHANGE FIRST + NAME - - - - - - - - - - - - - - - - - -  //
                          CustomSettingTile(
                              title: CustomLocale.SETTINGS_UPDATE_FULL_NAME_TITLE.getString(context),
                              subTitle: CustomLocale.SETTINGS_UPDATE_FULL_NAME_SUB_TITLE.getString(context),
                              icon: Iconsax.user,
                              trailing: Icon(isArabic(context) ? Iconsax.arrow_left_24: Iconsax.arrow_right_3, size: 32, color: darkLightColor(context)), onClick: () { context.read<SettingsCubit>().onUpdateFullName(context: context) ; },),

                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                          // - - - - - - - - - - - - - - - - - - CHANGE PHONE - - - - - - - - - - - - - - - - - -  //
                          CustomSettingTile(
                              title: CustomLocale.SETTINGS_UPDATE_PHONE_TITLE.getString(context),
                              subTitle: CustomLocale.SETTINGS_UPDATE_PHONE_SUB_TITLE.getString(context),
                            icon: Iconsax.call,
                            trailing: Icon(isArabic(context) ? Iconsax.arrow_left_24: Iconsax.arrow_right_3, size: 32, color: darkLightColor(context)), onClick: () { context.read<SettingsCubit>().onUpdatePhone(context: context); }),

                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                          // - - - - - - - - - - - - - - - - - -  SECTION TITLE ( JOB || VENDOR SECTION ) - - - - - - - - - - - - - - - - - -  //
                          Text(
                              state.isVendor!
                                  ? CustomLocale.SETTINGS_VENDOR_SECTION_TITLE.getString(context)
                                  : CustomLocale.SETTINGS_JOB_TITLE.getString(context),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: grayColor(context), letterSpacing: 0.6)),

                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                          // - - - - - - - - - - - - - - - - - - IS USER SHOW JOB WIDGET - - - - - - - - - - - - - - - - - -  //
                          if(!(state.isVendor!)) CustomSettingTile(
                             title: CustomLocale.SETTINGS_BE_VENDOR_TITLE.getString(context),
                             subTitle: CustomLocale.SETTINGS_BE_VENDOR_SUB_TITLE.getString(context),
                            icon: Iconsax.shop, onClick: (){ context.read<SettingsCubit>().onNavigateToBeVendorScreen(context: context); },
                            trailing: Icon(isArabic(context) ? Iconsax.arrow_left_24 : Iconsax.arrow_right_3, color: darkLightColor(context)),
                          ) ,

                          // - - - - - - - - - - - - - - - - - -  IS VENDOR SHOW NEW ORDER WIDGET - - - - - - - - - - - - - - - - - -  //
                          if(state.isVendor!) CustomSettingTile(
                            title: CustomLocale.SETTINGS_VENDOR_NEW_ORDER_TITLE.getString(context),
                            subTitle: CustomLocale.SETTINGS_VENDOR_NEW_ORDER_SUB_TITLE.getString(context),
                            icon: Iconsax.add_circle, onClick: (){ context.read<SettingsCubit>().onNavigateToNewOrderScreen(context: context); },
                            trailing: Icon(isArabic(context) ? Iconsax.arrow_left_24 : Iconsax.arrow_right_3, color: darkLightColor(context)),
                          ),

                          // - - - - - - - - - - - - - - - - - -  IS VENDOR SHOW SPACER - - - - - - - - - - - - - - - - - -  //
                          if(state.isVendor!)const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                          // - - - - - - - - - - - - - - - - - -  IS VENDOR SHOW ORDERS WIDGET - - - - - - - - - - - - - - - - - -  //
                          if(state.isVendor!) CustomSettingTile(
                            title: CustomLocale.SETTINGS_VENDOR_ORDERS_TITLE.getString(context),
                            subTitle: CustomLocale.SETTINGS_VENDOR_ORDES_SUB_TITLE.getString(context),
                            icon: Iconsax.box, onClick: () { context.read<SettingsCubit>().onNavigateToOrdersScreen(context: context); },
                            trailing: Icon(isArabic(context) ? Iconsax.arrow_left_24 : Iconsax.arrow_right_3, color: darkLightColor(context)),
                          ),

                          // - - - - - - - - - - - - - - - - - -  IS VENDOR SHOW SPACER - - - - - - - - - - - - - - - - - -  //
                          if(state.isVendor!)const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                          // - - - - - - - - - - - - - - - - - -  IS VENDOR SHOW (ONLINE / OFFLINE) WIDGET - - - - - - - - - - - - - - - - - -  //
                          if(state.isVendor!) CustomSettingTile(
                              title: CustomLocale.SETTINGS_VENDOR_ONLINE_OFFLINE_TITLE.getString(context),
                              subTitle: CustomLocale.SETTINGS_VENDOR_ONLINE_OFFLINE_SUB_TITLE.getString(context),
                              icon: Iconsax.activity, onClick: () {  },
                              trailing: Switch(
                                  value: state.vendorOnlineOffline!,
                                  onChanged: context.read<SettingsCubit>().updateVendorStatus)
                          ),

                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                          // - - - - - - - - - - - - - - - - - -  OTHERS - - - - - - - - - - - - - - - - - -  //
                          Text(CustomLocale.SETTINGS_OTHERS_TITLE.getString(context), style: Theme.of(context).textTheme.titleLarge?.copyWith(color: grayColor(context), letterSpacing: 0.6)),

                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                          // - - - - - - - - - - - - - - - - - - UPDATE LANGUAGE - - - - - - - - - - - - - - - - - -  //
                           CustomSettingTile(
                             title: CustomLocale.SETTINGS_UPDATE_LANGUAGE_TITLE.getString(context),
                             subTitle: CustomLocale.SETTINGS_UPDATE_LANGUAGE_SUB_TITLE.getString(context),
                            icon: Iconsax.language_square, onClick: () { context.read<SettingsCubit>().onUpdateLanguage(context: context, callBack: context.pop); },
                            trailing: Icon(isArabic(context) ? Iconsax.arrow_left_24 : Iconsax.arrow_right_3, color: darkLightColor(context)),
                          ),

                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                          // - - - - - - - - - - - - - - - - - - PRIVACY AND SECURITY - - - - - - - - - - - - - - - - - -  //
                          CustomSettingTile(
                            title: CustomLocale.SETTINGS_PRIVACY_AND_SECURITY_TITLE.getString(context),
                            subTitle: CustomLocale.SETTINGS_PRIVACY_AND_SECURITY_SUB_TITLE.getString(context),
                              icon: Iconsax.lock,
                              trailing: Icon(isArabic(context) ? Iconsax.arrow_left_24: Iconsax.arrow_right_3, size: 32, color: darkLightColor(context)), onClick: () {  },),
                    
                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),
                    
                          // - - - - - - - - - - - - - - - - - - HELP AND SUPPORT - - - - - - - - - - - - - - - - - -  //
                          CustomSettingTile(
                            title: CustomLocale.SETTINGS_HELP_AND_SUPPOR_TITLE.getString(context),
                            subTitle: CustomLocale.SETTINGS_HELP_AND_SUPPOR_SUB_TITLE.getString(context),
                              icon: Iconsax.headphone5,
                              trailing: Icon(isArabic(context) ? Iconsax.arrow_left_24: Iconsax.arrow_right_3, size: 32, color: darkLightColor(context)), onClick: () {  },),
                    
                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),
                    
                          // - - - - - - - - - - - - - - - - - - ABOUT - - - - - - - - - - - - - - - - - -  //
                          CustomSettingTile(
                            title: CustomLocale.SETTINGS_ABOUT_TITLE.getString(context),
                            subTitle: CustomLocale.SETTINGS_ABOUT_SUB_TITLE.getString(context),
                              icon: Iconsax.info_circle,
                              trailing: Icon(isArabic(context) ? Iconsax.arrow_left_24: Iconsax.arrow_right_3, size: 32, color: darkLightColor(context)), onClick: () {  },),
                    
                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),
                    
                          // - - - - - - - - - - - - - - - - - -  VERSION  - - - - - - - - - - - - - - - - - -  //
                          Center(child: Text(CustomLocale.SETTINGS_APP_VERSION_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall)),

                          // - - - - - - - - - - - - - - - - - -  SPACER - - - - - - - - - - - - - - - - - -  //
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),
                        ]
                    ),
                  )
              );
            case SettingsLoadingState(): return const CustomLoadingScreen();
            case SettingsErrorState(): return CustomErrorScreen(onClick: (){});
          }
        },
      ),
    );
  }
}

import 'package:berkania/presentation/home/home_cubit.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/custom_animations_strings.dart';
import '../../utils/constants/custom_sizes.dart';
import '../../utils/localisation/custom_locale.dart';
import '../widgets/custom_loading_screen.dart';

class HomeScreen extends CustomState {
  const HomeScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch(state){
            case HomeCurrentState() : {
              return Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: state.cameraPosition!,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    mapToolbarEnabled:false,
                    markers:
                    {
                      context.read<HomeCubit>().marker(lat: state.myCurrentLocation!.latitude, lng: state.myCurrentLocation!.longitude)
                    },
                    onMapCreated: context.read<HomeCubit>().onMapCompleted
                    ),
                  SizedBox(
                    width: getWidth(context),
                    height: getHeight(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          FloatingActionButton(
                                child: Icon(Iconsax.shop, size: 20.0, color: darkLightColor(context)),
                                onPressed: () {/*context.read<HomeCubit>().showVendors();*/},
                          ),
                            const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                          FloatingActionButton(
                                onPressed: context.read<HomeCubit>().onRefreshVendors,
                                child: Icon(Iconsax.refresh, size: 20.0, color: darkLightColor(context)),
                          ),
                            const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                          FloatingActionButton(
                              child: Icon(Iconsax.filter, size: 20.0, color: darkLightColor(context)),
                              onPressed: () {context.read<HomeCubit>().filterVendors();}
                          ),
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                          FloatingActionButton(
                              child: Icon(Iconsax.gps, color: darkLightColor(context)),
                              onPressed: (){
                                context.read<HomeCubit>().myLocation(lat: state.myCurrentLocation!.latitude, lng: state.myCurrentLocation!.longitude);
                              }
                          ),
                          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            case HomeLoadingState(): return const CustomLoadingScreen();
            case HomeErrorState(): return Center(child: Text(state.message, style: Theme.of(context).textTheme.bodyLarge));
            case HomePermissionState():
              return SingleChildScrollView(
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
                        CustomElevatedButton(
                            onClick: context.read<HomeCubit>().onRequestPermission,
                            width: getWidth(context) / 2,
                            height: 70.0,
                            backgroundColor: darkLightColor(context),
                            child: Text(CustomLocale.HOME_PERMISSION_BUTTON_ENABLE.getString(context), style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: darkDarkLightLightColor(context), letterSpacing: 1)))
                      ],
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}

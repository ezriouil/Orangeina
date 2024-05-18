import 'package:berkania/presentation/home/home_cubit.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_sizes.dart';
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
                    initialCameraPosition: state.cameraCurrentLocation == null ? state.myCurrentLocation! : state.cameraCurrentLocation!,
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    onCameraMove: context.read<HomeCubit>().onCameraMoved,
                    myLocationEnabled: true,
                    mapToolbarEnabled:false,
                      markers : state.markers!,
                      onMapCreated: context
                          .read<HomeCubit>()
                          .onMapCompleted
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
                              onPressed: context.read<HomeCubit>().myLocation,
                              child: Icon(Iconsax.gps, color: darkLightColor(context))

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
          }
        },
      ),
    );
  }
}

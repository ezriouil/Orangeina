import 'package:berkania/presentation/home/home_cubit.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends CustomState {
  const HomeScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          switch(state){
            case HomeCurrentState(): return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 15,
              ),
              zoomControlsEnabled: false,
              compassEnabled: false,
              onMapCreated: (GoogleMapController mapController) {

              },
            );
            case HomeLoadingState(): return Center(child: Text("Loading ...", style: Theme.of(context).textTheme.bodyLarge));
            case HomeErrorState(): return Center(child: Text(state.message, style: Theme.of(context).textTheme.bodyLarge));
          }
        },
      ),
    );
  }
}

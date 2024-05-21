import 'package:berkania/presentation/vendor_details/vendor_details_cubit.dart';
import 'package:berkania/presentation/widgets/custom_error_screen.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/presentation/wishlist/wishlist_cubit.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VendorDetailsScreen extends CustomState {
  const VendorDetailsScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<VendorDetailsCubit, VendorDetailsState>(
        builder: (context, state) {
          switch(state){
            case VendorDetailsMainState():
              {
                return const Center(child: Text(""));
              }
            case VendorDetailsLoadingState(): return const CustomLoadingScreen();
            case VendorDetailsErrorState(): return CustomErrorScreen(onClick: (){});
          }
        },
      ),
    );
  }
}

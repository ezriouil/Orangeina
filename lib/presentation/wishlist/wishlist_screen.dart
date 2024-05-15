import 'package:berkania/presentation/wishlist/wishlist_cubit.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends CustomState {
  const WishlistScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          switch(state){
            case WishlistCurrentState(): return Center(child: Column(
              children: [
                Text("Wishlist screen", style: Theme.of(context).textTheme.bodyLarge)
              ],
            ));
            case WishlistLoadingState(): return Center(child: Text("Loading ...", style: Theme.of(context).textTheme.bodyLarge));
            case WishlistErrorState(): return Center(child: Text(state.message, style: Theme.of(context).textTheme.bodyLarge));
          }
        },
      ),
    );
  }
}

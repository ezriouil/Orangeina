import 'package:berkania/presentation/widgets/custom_empty_screen.dart';
import 'package:berkania/presentation/widgets/custom_error_screen.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/presentation/wishlist/widgets/custom_wishlist.dart';
import 'package:berkania/presentation/wishlist/wishlist_cubit.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_sizes.dart';
import '../../utils/localisation/custom_locale.dart';

class WishlistScreen extends CustomState {
  const WishlistScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(CustomLocale.WISHLISTS_TITLE.getString(context), style: Theme.of(context).textTheme.bodyLarge),
        actions: [Padding(
          padding: const EdgeInsets.symmetric(horizontal: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
          child: InkWell(
            onTap: context.read<WishlistCubit>().onRefresh,
            borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
            child: Icon( Iconsax.refresh, size: 20, color: darkLightColor(context)),
          ),
        )],
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          switch(state){
             case WishlistMainState(): return ListView.builder(
                 itemCount: state.wishLists!.length,
                  itemBuilder: (context, index) => CustomWishList(wishListEntity: state.wishLists![index], onDelete: (String id){ context.read<WishlistCubit>().onDelete( context : context, id : id); }));
            case WishlistLoadingState(): return const CustomLoadingScreen();
            case WishlistErrorState(): return CustomErrorScreen(onClick: (){});
            case WishListEmptyState(): return CustomEmptyScreen(text: CustomLocale.WISHLIST_EMPTY_LIST_TITLE.getString(context));
          }
        },
      ),
    );
  }
}

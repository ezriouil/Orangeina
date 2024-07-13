import 'package:berkania/presentation/widgets/custom_empty_screen.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/presentation/wishlist/widgets/custom_wishlist.dart';
import 'package:berkania/presentation/wishlist/wishlist_cubit.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_sizes.dart';
import '../../utils/localisation/custom_locale.dart';
import '../../utils/router/custom_router.dart';
import '../index/index_cubit.dart';

class WishlistScreen extends CustomState {
  const WishlistScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () { context.read<IndexCubit>().onUpdateCurrentIndex(0, context); },
            borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
            child: Icon(isArabic(context) ? Iconsax.arrow_right_3 : Iconsax.arrow_left_2, color: darkLightColor(context))),
        title: Text(CustomLocale.WISHLISTS_TITLE.getString(context), style: Theme.of(context).textTheme.bodyLarge),
        actions: [InkWell(
          onTap: (){ context.read<WishlistCubit>().onRefresh(context: context); },
          borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
          child: Padding(
            padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS),
            child: Icon( Iconsax.refresh, size: 20, color: darkLightColor(context)),
          ),
        )],
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          switch(state){
             case WishlistMainState(): return ListView.builder(
                 itemCount: state.wishLists!.length,
                  itemBuilder: (context, index) => CustomWishList(
                        wishListEntity: state.wishLists![index],
                        onDelete: (String id) {context.read<WishlistCubit>().onDelete(context: context, id: id);},
                        onClick: () {
                          context.pushNamed(CustomRouter.VENDOR_DETAILS, pathParameters: { 'id' : state.wishLists![index].vendorId!});
                        },
                      ));
            case WishlistLoadingState(): return const CustomLoadingScreen();
            case WishListEmptyState(): return CustomEmptyScreen(text: CustomLocale.WISHLIST_EMPTY_LIST_TITLE.getString(context));
          }
        },
      ),
    );
  }
}

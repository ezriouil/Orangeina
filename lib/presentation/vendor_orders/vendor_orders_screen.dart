import 'package:berkania/presentation/vendor_orders/vendor_orders_cubit.dart';
import 'package:berkania/presentation/vendor_orders/widgets/custom_order.dart';
import 'package:berkania/presentation/widgets/custom_empty_screen.dart';
import 'package:berkania/presentation/widgets/custom_error_screen.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_sizes.dart';
import '../../utils/localisation/custom_locale.dart';

class VendorOrdersScreen extends CustomState {
   const VendorOrdersScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: context.pop,
          borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
          child: Icon( Iconsax.arrow_left_24, color: darkLightColor(context)),
        ),
        title: Text(CustomLocale.ORDERS_TITLE.getString(context), style: Theme.of(context).textTheme.titleMedium),
        actions: [Padding(
          padding: const EdgeInsets.symmetric(horizontal: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
          child: InkWell(
            onTap: context.read<VendorOrdersCubit>().onRefresh,
            borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
            child: Icon( Iconsax.refresh, size: 20, color: darkLightColor(context)),
          ),
        )],
      ),
      body: BlocBuilder<VendorOrdersCubit, VendorOrdersState>(
        builder: (context, state) {
          switch(state){
            case VendorOrdersMainState():
              return ListView.builder(
                itemCount: state.orders!.length,
                itemBuilder: (context, index) => CustomOrder(orderEntity: state.orders![index])
              );
            case VendorOrdersLoadingState(): return const CustomLoadingScreen();
            case VendorOrdersErrorState(): return CustomErrorScreen(onClick: (){});
            case VendorOrdersEmptyState(): return CustomEmptyScreen(text: CustomLocale.ORDERS_EMPTY_LIST_TITLE.getString(context));
          }
        },
      ),
    );
  }
}

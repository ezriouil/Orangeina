import 'package:berkania/presentation/vendor_orders/vendor_orders_cubit.dart';
import 'package:berkania/presentation/widgets/custom_error_screen.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_sizes.dart';

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
      ),
      body: BlocBuilder<VendorOrdersCubit, VendorOrdersState>(
        builder: (context, state) {
          switch(state){
            //
            case VendorOrdersMainState():
              return Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                    margin: const EdgeInsets.symmetric(horizontal: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
                    decoration: BoxDecoration(border: Border.all(color: darkLightColor(context)), borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS), color: CustomColors.GREEN_DARK.withOpacity(0.4)),
                    width: getWidth(context),
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(children: [
                          Icon(Iconsax.wallet_money, size: 20.0, color: darkLightColor(context)),
                          Text("   Bag Price  :  ", style: Theme.of(context).textTheme.bodySmall),
                          const Spacer(),
                          Text("10.0 MAD", style: Theme.of(context).textTheme.bodyLarge),
                        ]),
                        Row(children: [
                          Icon(Iconsax.size, size: 20.0, color: darkLightColor(context)),
                          Text("   Quantity  :  ", style: Theme.of(context).textTheme.bodySmall),
                          const Spacer(),
                          Text("80 KG", style: Theme.of(context).textTheme.bodyLarge),
                        ]),
                        Row(children: [
                          Icon(Iconsax.timer_14, size: 20.0, color: darkLightColor(context)),
                          Text("   Created At  :  ", style: Theme.of(context).textTheme.bodySmall),
                          const Spacer(),
                          Text("22/05/2024", style: Theme.of(context).textTheme.bodyLarge),
                        ]),
                        Row(children: [
                          Icon(Iconsax.timer_start, size: 20.0, color: darkLightColor(context)),
                          Text("   Selected At  :  ", style: Theme.of(context).textTheme.bodySmall),
                          const Spacer(),
                          Text("23/05/2024", style: Theme.of(context).textTheme.bodyLarge),
                        ]),
                        Row(children: [
                          Icon(Iconsax.moneys, size: 20.0, color: darkLightColor(context)),
                          Text("   Total  :  ", style: Theme.of(context).textTheme.bodySmall),
                          const Spacer(),
                          Text("800.0 MAD", style: Theme.of(context).textTheme.bodyLarge),
                        ]),
                        Row(children: [
                          Icon(Iconsax.status, size: 20.0, color: darkLightColor(context)),
                          Text("   Status  :  ", style: Theme.of(context).textTheme.bodySmall),
                          const Spacer(),
                          Text("PENDING", style: Theme.of(context).textTheme.bodyLarge),
                        ]),
                      ],
                    ),
                  )
                ],
              ));
            case VendorOrdersLoadingState(): return const CustomLoadingScreen();
            case VendorOrdersErrorState(): return CustomErrorScreen(onClick: (){});
          }
        },
      ),
    );
  }
}

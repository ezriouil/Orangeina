import 'package:berkania/domain/entities/order_entity.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/state/custom_state.dart';

class CustomOrder extends CustomState {
  final OrderEntity orderEntity;
  const CustomOrder({super.key, required this.orderEntity});

  @override
  Widget run(BuildContext context) {
    final Color backgroundColor = orderEntity.status! == "PENDING" ? CustomColors.YELLOW_LIGHT : orderEntity.status! == "CONFIRMED" ?  CustomColors.GREEN_DARK : CustomColors.RED_DARK;
    return Container(
      padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
      margin: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS / 2),
      decoration: BoxDecoration(border: Border.all(color: darkLightColor(context)), borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS), color: backgroundColor.withOpacity(0.4)),
      width: getWidth(context),
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(children: [
            Icon(Iconsax.wallet_money, size: 20.0, color: darkLightColor(context)),
            Text("   Bag Price  :  ", style: Theme.of(context).textTheme.bodySmall),
            const Spacer(),
            Text("${orderEntity.priceEachKg} MAD", style: Theme.of(context).textTheme.bodyLarge),
          ]),
          Row(children: [
            Icon(Iconsax.size, size: 20.0, color: darkLightColor(context)),
            Text("   Quantity  :", style: Theme.of(context).textTheme.bodySmall),
            const Spacer(),
            Text("${orderEntity.quantity} KG", style: Theme.of(context).textTheme.bodyLarge),
          ]),
          Row(children: [
            Icon(Iconsax.timer_14, size: 20.0, color: darkLightColor(context)),
            Text("   Created At  :", style: Theme.of(context).textTheme.bodySmall),
            const Spacer(),
            Text(orderEntity.createAt ?? "", style: Theme.of(context).textTheme.bodyLarge),
          ]),
          Row(children: [
            Icon(Iconsax.timer_start, size: 20.0, color: darkLightColor(context)),
            Text("   Selected At  :", style: Theme.of(context).textTheme.bodySmall),
            const Spacer(),
            Text(orderEntity.selectedDate ?? "", style: Theme.of(context).textTheme.bodyLarge),
          ]),
          Row(children: [
            Icon(Iconsax.moneys, size: 20.0, color: darkLightColor(context)),
            Text("   Total  :", style: Theme.of(context).textTheme.bodySmall),
            const Spacer(),
            Text("${orderEntity.total} MAD", style: Theme.of(context).textTheme.bodyLarge),
          ]),
          Row(children: [
            Icon(Iconsax.status, size: 20.0, color: darkLightColor(context)),
            Text("   Status  :", style: Theme.of(context).textTheme.bodySmall),
            const Spacer(),
            Text(orderEntity.status ?? "", style: Theme.of(context).textTheme.bodyLarge),
          ]),
        ],
      ),
    );
  }
}

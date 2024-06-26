import 'package:berkania/presentation/vendor_new_order/vendor_new_order_cubit.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/presentation/widgets/custom_error_screen.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class VendorNewOrderScreen extends CustomState {
  const VendorNewOrderScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: context.pop,
          borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
          child: Icon( isArabic(context) ? Iconsax.arrow_right_3 : Iconsax.arrow_left_24, color: darkLightColor(context)),
        ),
      ),
      body: BlocBuilder<VendorNewOrderCubit, VendorNewOrderState>(
        builder: (context, state) {
          switch(state){

            case VendorNewOrderMainState():
              {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: CustomSizes.SPACE_BETWEEN_ITEMS),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                      // - - - - - - - - - - - - - - - - - - TITLE - - - - - - - - - - - - - - - - - -  //
                      Text(CustomLocale.NEW_ORDER_TITLE.getString(context), style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1)),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                      // - - - - - - - - - - - - - - - - - - SUBTITLE - - - - - - - - - - - - - - - - - -  //
                      Text(CustomLocale.NEW_ORDER_SUB_TITLE.getString(context), style: Theme.of(context).textTheme.bodyMedium),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                      // - - - - - - - - - - - - - - - - - - COUNTER - - - - - - - - - - - - - - - - - -  //
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: grayColor(context)), borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2)),
                        padding: const EdgeInsets.symmetric(vertical: CustomSizes.SPACE_BETWEEN_ITEMS),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(heroTag: "1", onPressed: context.read<VendorNewOrderCubit>().decrement, backgroundColor: primaryColor(context), child: const Icon(Iconsax.minus, color: CustomColors.WHITE)),
                            Text(state.counter! < 10 ? "0${state.counter}" : state.counter.toString(), style: Theme.of(context).textTheme.headlineMedium),
                            FloatingActionButton(heroTag: "2", onPressed: context.read<VendorNewOrderCubit>().increment, backgroundColor: primaryColor(context), child: const Icon(Iconsax.add, color: CustomColors.WHITE)),
                          ],
                        ),
                      ),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_DEFAULT),

                      // - - - - - - - - - - - - - - - - - - DATE - - - - - - - - - - - - - - - - - -  //
                      DatePicker(
                        DateTime.now(),
                        height: 100,
                        initialSelectedDate: DateTime.now(),
                        selectionColor: primaryColor(context),
                        selectedTextColor: Colors.white,
                        dateTextStyle: Theme.of(context).textTheme.bodyMedium!,
                        monthTextStyle: Theme.of(context).textTheme.bodyMedium!,
                        dayTextStyle: Theme.of(context).textTheme.bodyMedium!,
                        daysCount: 60,
                        locale: state.dateTimeLocalization ?? "EN",
                        onDateChange: context.read<VendorNewOrderCubit>().onPickDate,
                      ),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                      // - - - - - - - - - - - - - - - - - - HINT - - - - - - - - - - - - - - - - - -  //
                      Text(CustomLocale.NEW_ORDER_SUB_TITLE.getString(context), style: Theme.of(context).textTheme.bodySmall),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS * 2),

                      // - - - - - - - - - - - - - - - - - - DELIVERED DATE - - - - - - - - - - - - - - - - - -  //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${CustomLocale.NEW_ORDER_DELIVERY_TIME.getString(context)} :", style: Theme.of(context).textTheme.bodyLarge),
                          Text(
                              "${state.date!.day < 10 ? "0${state.date!.day}" : state.date!.day}/${state.date!.month < 10 ? "0${state.date!.month}" : state.date!.month}/${state.date!.year}",
                              style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                      // - - - - - - - - - - - - - - - - - - PRICE OF EACH BAG - - - - - - - - - - - - - - - - - -  //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("x1 ${CustomLocale.NEW_ORDER_BAG_PRICE.getString(context)} :", style: Theme.of(context).textTheme.bodyLarge),
                          Text("${state.priceKg} ${CustomLocale.NEW_ORDER_MAD.getString(context)}", style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                      // - - - - - - - - - - - - - - - - - - TOTAL PRICE - - - - - - - - - - - - - - - - - -  //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${CustomLocale.NEW_ORDER_BAG_PRICE.getString(context)}( ${state.counter! < 10 ? "0${state.counter}" : state.counter.toString()} x ${state.priceKg} ${CustomLocale.NEW_ORDER_MAD.getString(context)}) :", style: Theme.of(context).textTheme.bodyLarge),
                          Text("${state.total} ${CustomLocale.NEW_ORDER_MAD.getString(context)}", style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_DEFAULT),
                      
                      // - - - - - - - - - - - - - - - - - - CONFIRM BUTTON - - - - - - - - - - - - - - - - - -  //
                      CustomElevatedButton(
                          onClick: () {
                            context.read<VendorNewOrderCubit>().onConfirm(context: context);
                          },
                          withDefaultPadding: false,
                          child: Text(CustomLocale.NEW_ORDER_CONFIRM_BUTTON.getString(context)))
                    ],
                  ),
                );
              }
            case VendorNewOrderLoadingState(): return const CustomLoadingScreen();
            case VendorNewOrderErrorState(): return CustomErrorScreen(onClick: (){});
              // TODO: Handle this case.
          }
        },
      ),
    );
  }
}

import 'package:berkania/presentation/vendor_new_order/vendor_new_order_cubit.dart';
import 'package:berkania/presentation/widgets/custom_elevated_button.dart';
import 'package:berkania/presentation/widgets/custom_error_screen.dart';
import 'package:berkania/presentation/widgets/custom_loading_screen.dart';
import 'package:berkania/utils/constants/custom_colors.dart';
import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          child: Icon( Iconsax.arrow_left_24, color: darkLightColor(context)),
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
                      Text("New Order", style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1)),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                      // - - - - - - - - - - - - - - - - - - SUBTITLE - - - - - - - - - - - - - - - - - -  //
                      Text("Fill how much kg you want and don't forget set date to your order.", style: Theme.of(context).textTheme.bodyMedium),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS),

                      // - - - - - - - - - - - - - - - - - - COUNTER - - - - - - - - - - - - - - - - - -  //
                      Container(
                        decoration: BoxDecoration(border: Border.all(color: grayColor(context)), borderRadius: BorderRadius.circular(CustomSizes.SPACE_BETWEEN_ITEMS / 2)),
                        padding: const EdgeInsets.symmetric(vertical: CustomSizes.SPACE_BETWEEN_ITEMS),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FloatingActionButton(onPressed: context.read<VendorNewOrderCubit>().decrement, backgroundColor: primaryColor(context), child: const Icon(Iconsax.minus, color: CustomColors.WHITE)),
                            Text(state.counter! < 10 ? "0${state.counter}" : state.counter.toString(), style: Theme.of(context).textTheme.headlineMedium),
                            FloatingActionButton(onPressed: context.read<VendorNewOrderCubit>().increment, backgroundColor: primaryColor(context), child: const Icon(Iconsax.add, color: CustomColors.WHITE)),
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
                        locale: "EN",
                        onDateChange: context.read<VendorNewOrderCubit>().onPickDate,
                      ),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS),

                      // - - - - - - - - - - - - - - - - - - HINT - - - - - - - - - - - - - - - - - -  //
                      Text("We will notify you with more details on the pick up time.", style: Theme.of(context).textTheme.bodySmall),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_SECTIONS * 2),

                      // - - - - - - - - - - - - - - - - - - TOTAL PRICE - - - - - - - - - - - - - - - - - -  //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delivery Time", style: Theme.of(context).textTheme.bodyLarge),
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
                          Text("x 1 Bag Price :", style: Theme.of(context).textTheme.bodyLarge),
                          Text("${state.priceKg} MAD", style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),

                      // - - - - - - - - - - - - - - - - - - TOTAL PRICE - - - - - - - - - - - - - - - - - -  //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Price ( ${state.counter! < 10 ? "0${state.counter}" : state.counter.toString()} x ${state.priceKg} MAD):", style: Theme.of(context).textTheme.bodyLarge),
                          Text("${state.total} MAD", style: Theme.of(context).textTheme.bodyLarge),
                        ],
                      ),

                      // - - - - - - - - - - - - - - - - - - SPACER - - - - - - - - - - - - - - - - - -  //
                      const SizedBox(height: CustomSizes.SPACE_DEFAULT),
                      
                      // - - - - - - - - - - - - - - - - - - CONFIRM BUTTON - - - - - - - - - - - - - - - - - -  //
                      CustomElevatedButton(onClick: (){ context.read<VendorNewOrderCubit>().onConfirm(callback: (){  }, context: context); }, withDefaultPadding: false, child: const Text("Confirm"))
                      
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

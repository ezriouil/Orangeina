import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/constants/custom_sizes.dart';

class FAQScreen extends CustomState {
  const FAQScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CustomLocale.FAQ_TITLE.getString(context)),
        leading: InkWell(
            onTap: () {
              context.pop();
            },
            borderRadius: BorderRadius.circular(CustomSizes.SPACE_DEFAULT),
            child: Builder(builder: (context) {
              return Icon(
                  isArabic(context)
                      ? Iconsax.arrow_right_3
                      : Iconsax.arrow_left_24,
                  color: darkLightColor(context));
            })),
      ),
      body: Column(
        children: [
          /// Q3
          _customQuestionResponseAnimation(
              question: CustomLocale.Q1.getString(context),
              response: CustomLocale.R1.getString(context),
              context: context,
              color: darkLightColor(context)),

          /// Q5
          _customQuestionResponseAnimation(
              question: CustomLocale.Q2.getString(context),
              response: CustomLocale.R2.getString(context),
              context: context,
              color: darkLightColor(context)),

          /// Q5
          _customQuestionResponseAnimation(
              question: CustomLocale.Q3.getString(context),
              response: CustomLocale.R3.getString(context),
              context: context,
              color: darkLightColor(context)),

          /// Q5
          _customQuestionResponseAnimation(
              question: CustomLocale.Q4.getString(context),
              response: CustomLocale.R4.getString(context),
              context: context,
              color: darkLightColor(context)),

          /// Q6
          _customQuestionResponseAnimation(
              question: CustomLocale.Q5.getString(context),
              response: CustomLocale.R5.getString(context),
              context: context,
              color: darkLightColor(context)),

        ],
      ),
    );
  }
  Widget _customQuestionResponseAnimation({ required BuildContext context,  required Color color, required String question, required String response }) => ExpansionTile(
    title: Text(question, style: Theme.of(context).textTheme.titleMedium),
    iconColor: color,
    textColor: color,
    expandedAlignment: Alignment.centerLeft,
    children: [Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(response, style: Theme.of(context).textTheme.bodySmall),
    )],
  );
}

import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class FAQScreen extends CustomState {
  const FAQScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQ"),
        leading: InkWell(
            onTap: context.pop,
            child: const Icon(Iconsax.arrow_left_24)),
      ),
      body: Column(
        children: [
          /// Q1
          _customQuestionResponseAnimation(
              question: "What are the store_history.dart options?",
              response: "Go to down page you will find delivery option check it then you will see all store_history.dart options\n",
              context: context,
              color: darkLightColor(context)),

          /// Q2
          _customQuestionResponseAnimation(
              question: "Where are you located?",
              response: "What have lots of store any where\n\nAGADIR HAY SALAM G10 N23\nAGADIR HAY SALAM G10 N98\nAGADIR HAY AL HOUDA G2 N80\n",
              context: context,
              color: darkLightColor(context)),

          /// Q3
          _customQuestionResponseAnimation(
              question: "Where can i find the application",
              response: "Google play\nApp store\nHuawei store\n",
              context: context,
              color: darkLightColor(context)),

          /// Q4
          _customQuestionResponseAnimation(
              question: "What are payment methods supported",
              response: "What support lots of methods online also offline for example :\n\nOnline methods :\nPaypal, Visa, Master card, Apple pay...\n\nOffline methods :\n...\n",
              context: context,
              color: darkLightColor(context)),

          /// Q5
          _customQuestionResponseAnimation(
              question: "What are the new offers have?",
              response: "Go home page and check the popular option then you will find all offers we have for you\n",
              context: context,
              color: darkLightColor(context)),

          /// Q6
          _customQuestionResponseAnimation(
              question: "More questions",
              response: "Contact us\n",
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

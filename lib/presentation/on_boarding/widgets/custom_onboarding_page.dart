import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/custom_sizes.dart';

class CustomOnboardingPage extends CustomState {
  final String title, subTitle, animation;

  const CustomOnboardingPage(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.animation});

  @override
  Widget run(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(CustomSizes.SPACE_BETWEEN_ITEMS),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            animation,
            width: getWidth(context) * 0.8,
            height: getHeight(context) * 0.5,
            repeat: true,
          ),
          Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: CustomSizes.SPACE_BETWEEN_ITEMS / 2),
          Text(subTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

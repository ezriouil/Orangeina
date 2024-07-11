import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/custom_animations_strings.dart';

class CustomEmptyScreen extends CustomState {
  final String text;

  const CustomEmptyScreen({super.key, required this.text});

  @override
  Widget run(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            CustomAnimationStrings.EMPTY_ANIMATION,
            width: 200.0,
            height: 200.0,
            repeat: true,
          ),
          Text(text, style: Theme.of(context).textTheme.bodySmall)
        ],
      ),
    );
  }
}

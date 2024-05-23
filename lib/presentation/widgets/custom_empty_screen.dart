import 'package:berkania/utils/constants/custom_sizes.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants/custom_animations_strings.dart';
import '../../utils/localisation/custom_locale.dart';

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

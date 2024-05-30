import 'package:berkania/presentation/on_boarding/on_boarding_cubit.dart';
import 'package:berkania/presentation/on_boarding/widgets/custom_onboarding_page.dart';
import 'package:berkania/utils/state/custom_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/constants/custom_animations_strings.dart';
import '../../utils/constants/custom_txt_strings.dart';

class OnBoardingScreen extends CustomState {
  const OnBoardingScreen({super.key});

  @override
  Widget run(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnBoardingCubit, OnBoardingState>(
        builder: (context, state) {
          switch(state){
            case OnBoardingMainState():
              {
                return Stack(
                  children: [
                    PageView(
                      controller: state.pageController,
                      onPageChanged: (int index){ context.read<OnBoardingCubit>().onUpdatePageIndicator(index); },
                      children: const [
                        CustomOnboardingPage(
                          title: CustomTextStrings.ONBOARDING_TITLE_1,
                          subTitle: CustomTextStrings.ONBOARDING_SUB_TITLE_1,
                          animation: CustomAnimationStrings.ONBOARDING_SHOPPING,
                        ),
                        CustomOnboardingPage(
                          title: CustomTextStrings.ONBOARDING_TITLE_2,
                          subTitle: CustomTextStrings.ONBOARDING_SUB_TITLE_2,
                          animation: CustomAnimationStrings.ONBOARDING_FASE_DELIVERY_SHIPPING,
                        ),
                        CustomOnboardingPage(
                          title: CustomTextStrings.ONBOARDING_TITLE_3,
                          subTitle:CustomTextStrings.ONBOARDING_SUB_TITLE_3,
                          animation: CustomAnimationStrings.ONBOARDING_ONLINE_DELIVERY_SERVICE,
                        ),
                      ],
                    ),
                    Positioned(
                        right: getWidth(context) * 0.1,
                        top: getHeight(context) * 0.05,
                        child: OutlinedButton(
                            onPressed: context.read<OnBoardingCubit>().onSkip,
                            style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                side: const BorderSide(style: BorderStyle.none)),
                            child: Text(CustomTextStrings.ONBOARDING_SKIP,
                                style: Theme.of(context).textTheme.titleMedium))),
                    Positioned(
                      bottom: getHeight(context) * 0.1,
                      left: getWidth(context) * 0.1,
                      child: SmoothPageIndicator(
                        count: state.lastPageNbr! + 1,
                        controller: state.pageController!,
                        effect: ExpandingDotsEffect(
                            dotHeight: 4.0,
                            dotColor: grayColor(context),
                            activeDotColor: darkLightColor(context)),
                      ),
                    ),
                    Positioned(
                      bottom: getHeight(context) * 0.075,
                      right: getWidth(context) * 0.1,
                      child: OutlinedButton(
                          onPressed: () {
                            context.read<OnBoardingCubit>().onNextPage(context: context);
                          },
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero, side: const BorderSide(width: 2.0)),
                          child: const Icon(Icons.keyboard_arrow_right, size: 50.0)),
                    ),
                  ],
                );
              }
          }
        },
      ),
    );
  }
}

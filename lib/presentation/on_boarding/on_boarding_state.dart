part of 'on_boarding_cubit.dart';

@immutable
sealed class OnBoardingState {}

final class OnBoardingMainState extends OnBoardingState {
   final PageController? pageController;
   final int? lastPageNbr, currentPageIndex;

  OnBoardingMainState({this.pageController, this.lastPageNbr, this.currentPageIndex});

  OnBoardingMainState copyWith({ PageController? pageController, int? lastPageNbr, int? currentPageIndex }) => OnBoardingMainState(
    pageController: pageController ?? this.pageController,
    lastPageNbr: lastPageNbr ?? this.lastPageNbr,
    currentPageIndex: currentPageIndex ?? this.currentPageIndex,
  );

}

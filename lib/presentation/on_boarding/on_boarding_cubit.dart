import 'package:berkania/utils/local/storage/local_storage.dart';
import 'package:berkania/utils/router/custom_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {

  final GetStorage storage;
  OnBoardingCubit({ required this.storage }) : super(OnBoardingMainState()){ init(); }

  // - - - - - - - - - - - - - - - - - - INIT - - - - - - - - - - - - - - - - - -  //
  init(){
    emit(OnBoardingMainState(pageController: PageController(), currentPageIndex: 0, lastPageNbr: 2));
  }

  // - - - - - - - - - - - - - - - - - - UPDATE PAGE INDEX - - - - - - - - - - - - - - - - - -  //
  void onUpdatePageIndicator(int index){
    final currentState = state as OnBoardingMainState;
    emit(currentState.copyWith(currentPageIndex: index));
  }

  // - - - - - - - - - - - - - - - - - - SKIP BUTTON - - - - - - - - - - - - - - - - - -  //
  void onSkip() async{
    final currentState = state as OnBoardingMainState;
    currentState.pageController!.animateToPage(currentState.lastPageNbr!, duration: const Duration(milliseconds: 1000), curve: Curves.linear);
    emit(currentState.copyWith(currentPageIndex: currentState.lastPageNbr));
  }


  // - - - - - - - - - - - - - - - - - - NEXT PAGE BUTTON - - - - - - - - - - - - - - - - - -  //
  void onNextPage({ required BuildContext context }) async{
    final currentState = state as OnBoardingMainState;
    if (currentState.currentPageIndex == currentState.lastPageNbr) {
      await LocalStorage.upsert(key: "INIT_LOCATION", value: "LOGIN", storage: storage);
      context.pushReplacementNamed(CustomRouter.LOGIN);
    } else {
      currentState.pageController!.animateToPage(currentState.currentPageIndex!+ 1, duration: const Duration(milliseconds: 1000), curve: Curves.linear);
    }
  }

}

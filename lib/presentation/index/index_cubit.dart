import 'package:berkania/presentation/home/home_screen.dart';
import 'package:berkania/presentation/notification/notification_screen.dart';
import 'package:berkania/presentation/settings/settings_screen.dart';
import 'package:berkania/presentation/wishlist/wishlist_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'index_state.dart';

class IndexCubit extends Cubit<IndexState> {
  IndexCubit() : super(IndexCurrentState()){ init(); }

  init(){
    emit(IndexCurrentState(currentPageIndex: 0));
  }

  void onUpdateCurrentIndex(int value){
    emit((state as IndexCurrentState).copyWith(currentPageIndex: value));
  }

  List<Widget> screens() => [
    const HomeScreen(),
    const WishlistScreen(),
    const NotificationScreen(),
    const SettingsScreen(),
  ];
}

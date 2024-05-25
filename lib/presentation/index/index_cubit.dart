import 'package:berkania/presentation/home/home_screen.dart';
import 'package:berkania/presentation/notification/notification_screen.dart';
import 'package:berkania/presentation/settings/settings_screen.dart';
import 'package:berkania/presentation/wishlist/wishlist_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'index_state.dart';

class IndexCubit extends Cubit<IndexState> {
  IndexCubit() : super(IndexMainState()){ init(); }

  init() async{

    final hasPermission = await onRequestPermission();
    if(!hasPermission) emit(IndexPermissionState());
    
  }

  // - - - - - - - - - - - - - - - - - -  UPDATE CURRENT INDEX - - - - - - - - - - - - - - - - - -  //
  void onUpdateCurrentIndex(int value) async{

    final isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    final permission = await Geolocator.checkPermission();
    if(!isLocationServiceEnabled || permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
      emit(IndexPermissionState());
      return;
    }
    emit(IndexMainState(currentPageIndex: value));
  }

  // - - - - - - - - - - - - - - - - - -  PERMISSION - - - - - - - - - - - - - - - - - -  //
  Future<bool> onRequestPermission() async{
    LocationPermission permission;

    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Geolocator.openLocationSettings();
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Geolocator.openAppSettings();
      return false;
    }

    emit(IndexMainState(currentPageIndex: 0));
    return true;
  }

  // - - - - - - - - - - - - - - - - - -  SCREENS - - - - - - - - - - - - - - - - - -  //
  List<Widget> screens() => [
    const HomeScreen(),
    const WishlistScreen(),
    const NotificationScreen(),
    const SettingsScreen(),
  ];
}

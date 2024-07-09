import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/presentation/home/home_screen.dart';
import 'package:berkania/presentation/notification/notification_screen.dart';
import 'package:berkania/presentation/settings/settings_screen.dart';
import 'package:berkania/presentation/widgets/custom_snackbars.dart';
import 'package:berkania/presentation/wishlist/wishlist_screen.dart';
import 'package:berkania/utils/helpers/network.dart';
import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:geolocator/geolocator.dart';

part 'index_state.dart';

class IndexCubit extends Cubit<IndexState> {

  final Connectivity connectivity;
  IndexCubit({  required this.connectivity}) : super(IndexMainState()){ init(); }

  init() async{
    final hasPermission = await onRequestPermission();
    if(!hasPermission) emit(IndexPermissionState());
  }

  // - - - - - - - - - - - - - - - - - -  UPDATE CURRENT INDEX - - - - - - - - - - - - - - - - - -  //
  void onUpdateCurrentIndex(int value, BuildContext context) async{

    // CHECK CONNECTION INTERNET
    final hasConnection = await Network.hasConnection(connectivity);
    if(!hasConnection && context.mounted){
      CustomSnackBar.show(context: context, title: CustomLocale.NETWORK_TITLE.getString(context), subTitle: CustomLocale.NETWORK_SUB_TITLE.getString(context), type: ContentType.warning);
      return;
    }

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

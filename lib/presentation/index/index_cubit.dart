import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:berkania/presentation/home/home_screen.dart';
import 'package:berkania/presentation/notification/notification_screen.dart';
import 'package:berkania/presentation/settings/settings_screen.dart';
import 'package:berkania/presentation/widgets/custom_snackbars.dart';
import 'package:berkania/presentation/wishlist/wishlist_screen.dart';
import 'package:berkania/utils/device/device_utility.dart';
import 'package:berkania/utils/helpers/network.dart';
import 'package:berkania/utils/localisation/custom_locale.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'index_state.dart';

class IndexCubit extends Cubit<IndexState> {

  final Connectivity connectivity;
  final BuildContext context;
  IndexCubit({ required this.context, required this.connectivity }) : super(IndexMainState()){ init(); }

  init() async{

    final hasLocationPermission = await onRequestLocationPermission();
    final hasPhotosPermission = await onRequestPhotosPermission();

    if(!hasLocationPermission) emit(IndexLocationPermissionState());
    if(!hasPhotosPermission) emit(IndexPhotosPermissionState());

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
      emit(IndexLocationPermissionState());
      return;
    }
    emit(IndexMainState(currentPageIndex: value));
  }

  // - - - - - - - - - - - - - - - - - - LOCATION PERMISSION - - - - - - - - - - - - - - - - - -  //
  Future<bool> onRequestLocationPermission() async{
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

  // - - - - - - - - - - - - - - - - - - PHOTOS PERMISSION - - - - - - - - - - - - - - - - - -  //
  Future<bool> onRequestPhotosPermission() async{

    if(DeviceUtility.isAndroid()){
      final storagePermission = await Permission.storage.status;
      final photosPermission =  await Permission.photos.status;

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      if (androidInfo.version.sdkInt >= 33) {

        bool? grantedPhotos;

        if(photosPermission.isGranted){ grantedPhotos = true; }
        if(photosPermission.isDenied){
          final isOk = await Permission.photos.request();
          if(isOk.isGranted) { grantedPhotos = true; }
          else { grantedPhotos = false; }
        }
        if(photosPermission.isPermanentlyDenied){
          Geolocator.openAppSettings();
          return false;
        }

        if(!grantedPhotos!) return false;

        emit(IndexMainState(currentPageIndex: 0));
        return true;

      }
      else {

        bool? grantedStorage;

        if(storagePermission.isGranted){
          grantedStorage = true;
        }
        if(storagePermission.isDenied){
          final isOk =  await Permission.storage.request();
          if(isOk.isGranted) { grantedStorage = true; }
          else { grantedStorage = false; }
          return false;
        }
        if(storagePermission.isPermanentlyDenied){
          Geolocator.openAppSettings();
          return false;
        }

        if(!grantedStorage!) return false;

        emit(IndexMainState(currentPageIndex: 0));
        return true;

      }
    }
    if(DeviceUtility.isIos()){
      final storagePermission = await Permission.storage.status;

      bool? grantedStorage;

      if(storagePermission.isGranted){
        grantedStorage = true;
      }
      if(storagePermission.isDenied){
        final isOk =  await Permission.storage.request();
        if(isOk.isGranted) { grantedStorage = true; }
        else { grantedStorage = false; }
        return false;
      }
      if(storagePermission.isPermanentlyDenied){
        Geolocator.openAppSettings();
        return false;
      }
      if(!grantedStorage!) return false;

      emit(IndexMainState(currentPageIndex: 0));
      return true;
    }
    else{ return false; }
  }

  // - - - - - - - - - - - - - - - - - -  SCREENS - - - - - - - - - - - - - - - - - -  //
  List<Widget> screens() => [
    const HomeScreen(),
    const WishlistScreen(),
    const NotificationScreen(),
    const SettingsScreen(),
  ];
}

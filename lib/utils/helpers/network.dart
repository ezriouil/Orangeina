import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:iconsax/iconsax.dart';

import '../../presentation/widgets/custom_snackbars.dart';

class Network {
  Network._();

  // - - - - - - - - - - - - - - - - - - CHECK THE INTERNET CONNECTION - - - - - - - - - - - - - - - - - -  //
  static Future<bool> hasConnection(Connectivity connectivity) async {
    final checkTheNetwork = await connectivity.checkConnectivity();
    if (checkTheNetwork == ConnectivityResult.none) {
      // CustomSnackBars.error(
      //     icon: Iconsax.wifi,
      //     title: "No internet connection",
      //     message: "please check your network device.");
      return false;
    }
    return true;
  }
}

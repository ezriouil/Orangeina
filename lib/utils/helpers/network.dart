import 'package:connectivity_plus/connectivity_plus.dart';

class Network {
  Network._();

  // - - - - - - - - - - - - - - - - - - CHECK THE INTERNET CONNECTION - - - - - - - - - - - - - - - - - -  //
  static Future<bool> hasConnection(Connectivity connectivity) async {
    final checkTheNetwork = await connectivity.checkConnectivity();
    if (checkTheNetwork == ConnectivityResult.none) {
      return false;
    }
    return true;
  }
}

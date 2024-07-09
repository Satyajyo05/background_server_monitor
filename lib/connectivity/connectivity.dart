import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityCode {
  Future<List<ConnectivityResult>> getConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult;
  }
}

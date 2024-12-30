import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../view/select_roles/dispatcher/component/snackbar.dart';

class CheckNetworkProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  CheckNetworkProvider() {
    _subscription =
        _connectivity.onConnectivityChanged.listen((connectivityResult) {
      _updateConnectionStatus(connectivityResult);
    });
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResult) {
    for (var connectivityResult in connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        print("Please connect to the Network");
        _showSnackbar("Please connect to the Network", Icons.wifi_off);
      }
    }
  }

  void _showSnackbar(String message, IconData icon) {
    snackbarKey.currentState?.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Text(message, style: const TextStyle(color: Colors.white)),
          ],
        ),
        backgroundColor: Colors.black,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    print("CheckNetworkProvider disposed");
    super.dispose();
  }
}

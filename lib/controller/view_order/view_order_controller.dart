import 'package:delivery_man/controller/session_controller/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../repository/dispatcher_repo/dispatcher_repository_impl.dart';

class ViewOrderController with ChangeNotifier {
  Map _orderData = {};
  String? userId;
  final dispatcherRepo = DispatcherRepositoryImpl();

  Map get orderData => _orderData;

  Future<void> fetchOrderData(String orderId) async {
    var res = await dispatcherRepo.getSingleSale(orderId);
    if (res['code_status'] == true) {
      _orderData['data'] = res['order'];
      print("Order: ${_orderData['data']}");
      notifyListeners();
    } else {
      throw Exception(res['message']);
    }
  }

  Future<void> readUserId() async {
    final session = SessionController.instance;
    userId = session.userSession.loginData?.id ?? '';
  }

  void openWhatsApp(BuildContext context, String phoneNumber) async {
    final Uri _url = Uri.parse("https://wa.me/$phoneNumber");
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open WhatsApp')),
      );
    }
  }

  void openGoogleMap(String url) async {
    final Uri _url = Uri.parse(url);
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw Exception('Could not open Google Maps');
    }
  }
}

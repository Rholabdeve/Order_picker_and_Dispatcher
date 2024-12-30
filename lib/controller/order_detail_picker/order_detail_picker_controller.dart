import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../repository/order_picker_repo/order_picker_repository.dart';
import '../../repository/order_picker_repo/order_picker_repository_impl.dart';

class OrderDetailsProvider extends ChangeNotifier {
  final OrderPickerRepository _orderRepository = OrderPickerRepositoryImpl();
  List<Map<String, dynamic>> data = [];
  Set<String> scannedProductCodes = {};
  String? dateId = "";
  Future<void> fetchSalesDetails(String dataId) async {
    var res = await _orderRepository.getSalesDetails(dataId);
    if (res['code_status'] == true) {
      data = List<Map<String, dynamic>>.from(res['data']);
      for (var product in data) {
        product['second_name'] = '';
      }
      await loadScanResults();
      notifyListeners();
    } else {
      throw Exception(res['message']);
    }
  }

  Future<void> loadScanResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var product in data) {
      String productCode = product['product_code'];
      String? storedResult = prefs.getString(productCode);
      if (storedResult != null) {
        product['second_name'] = storedResult;
      }
    }
    notifyListeners();
  }

  Future<void> saveScanResult(String productCode, String result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(productCode, result);
    notifyListeners();
  }

  bool allOrdersPicked() {
    if (data.every((product) => product['second_name'] == 'Matched')) {
      getOrderStatus('Picked');
      return true;
    }
    return false;
  }

  Future<void> getOrderStatus(String status) async {
    try {
      await _orderRepository.orderStatus(dateId!, status);
    } catch (e) {
      throw Exception('Failed to update order status');
    }
  }

  Future<void> scanBarcode(int index) async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ffB7003D', 'Cancel', true, ScanMode.BARCODE);
    } catch (e) {
      scanResult = 'Failed to get platform version';
    }

    String productCode = data[index]['product_code'];
    String result = scanResult == '-1'
        ? 'Scan cancelled'
        : productCode == scanResult
            ? 'Matched'
            : 'Product does not match';

    data[index]['second_name'] = result;
    await saveScanResult(productCode, result);

    if (result == 'Product does not match') {
      getOrderStatus('Unpicked');
    }
    notifyListeners();
  }
}

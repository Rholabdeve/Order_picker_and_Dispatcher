import 'package:delivery_man/const/my_color.dart';
import 'package:delivery_man/repository/order_picker_repo/order_picker_repository.dart';
import 'package:delivery_man/repository/order_picker_repo/order_picker_repository_impl.dart';
import 'package:delivery_man/view/update_product/update_products.dart';
import 'package:delivery_man/widgets/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanProductController extends ChangeNotifier {
  final OrderPickerRepository scanproduct = OrderPickerRepositoryImpl();
  List<Map<String, dynamic>> data = [];
  var wearhouse_id;

  Future<void> fetchscanproduct(String barcodenum, String wearhouse_id) async {
    try {
      var response = await scanproduct.scanproduct(barcodenum, wearhouse_id);
      print("API Response: $response");
      if (response["code_status"] == true) {
        print("respone arha hai ${response}");
        data = List<Map<String, dynamic>>.from(response['data']);
        print("object123 $data");
        notifyListeners();
      } else {
        print("Exception ubaid $response");
        throw Exception(response['message']);
      }
    } catch (e) {
      print("misbha bhai $e");
    }
  }

  Future<void> loadScanResults() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var product in data) {
      String productCode = product['code'];
      String? storedResult = prefs.getString(productCode);
      if (storedResult != null) {
        product['product_name'] = storedResult;
      }
    }
    notifyListeners();
  }

  Future<void> saveScanResult(String productCode, String result) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(productCode, result);
    notifyListeners();
  }

  Future<void> scanBarcode(context) async {
    String scanResult;
    try {
      scanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ffB7003D', 'Cancel', true, ScanMode.BARCODE);
    } catch (e) {
      scanResult = 'Failed to get platform version';
    }
    print("result agaya $scanResult");
    await fetchscanproduct(scanResult, wearhouse_id);

    String productCode = data[0]['product_code'];

    String result;
    if (scanResult == '-1') {
      FlushBar.flushBarMessageGreen(message: 'Scan Cancel', context: context);
      result = 'Scan Cancel';
    } else if (productCode == scanResult) {
      showProductDialog(context, data[0]['product_name'],
          data[0]['available_qty'].toString(), data[0]['warehouse']);
      result = 'Product Match';
    } else {
      FlushBar.flushBarMessageGreen(
          message: 'Product does not match', context: context);
      result = 'Product does not Avaiable';
    }

    print("Result: $result");

    await saveScanResult(productCode, result);
    notifyListeners();
  }

  void getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    wearhouse_id = prefs.getString('wearhpuse_id');
    notifyListeners();
  }

  void showProductDialog(BuildContext context, String productName,
      String availableQty, String warehouse) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Product Details"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Name: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Expanded(
                      // Use Expanded to make the Text widget take remaining space
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal, // Horizontal scroll
                        child: Text(productName),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    Text(
                      'Warehouse: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SingleChildScrollView(
                      scrollDirection:
                          Axis.horizontal, // Set scroll direction to horizontal
                      child: Text(warehouse),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                // Column for Warehouse Name

                Row(
                  children: [
                    Text(
                      'Quantity: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(availableQty),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProductsDetails(
                              name: data[0]['product_name'],
                              qty: data[0]['available_qty'],
                            )));
              },
              child: Text(
                "Update",
                style: TextStyle(color: myColor.themeColor),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Close",
                style: TextStyle(color: myColor.themeColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

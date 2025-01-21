import 'package:delivery_man/const/my_color.dart';
import 'package:delivery_man/repository/order_picker_repo/order_picker_repository.dart';
import 'package:delivery_man/repository/order_picker_repo/order_picker_repository_impl.dart';
import 'package:delivery_man/view/select_roles/order_picker/home_screen_order_picker/home_screen_order_picker.dart';
import 'package:delivery_man/widgets/custom_button.dart';
import 'package:delivery_man/widgets/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanProductController extends ChangeNotifier {
  final OrderPickerRepository scanproduct = OrderPickerRepositoryImpl();
  final updatebarcodecontroller = TextEditingController();
  List<Map<String, dynamic>> data = [];
  var wearhouse_id;
  var user_id;

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

  Future<void> fetchupdatebarcode(
    String barcodenum,
    String productid,
    String user_id,
  ) async {
    try {
      var response =
          await scanproduct.barcodeupdate(barcodenum, productid, user_id);
      print("API Response: $response");
      if (response["code_status"] == true) {
        print("respone is comming ${response}");
        notifyListeners();
      } else {
        print("Exception $response");
        throw Exception(response['message']);
      }
    } catch (e) {
      print("Catch Block $e");
    }
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
    user_id = prefs.getString('id');
    notifyListeners();
  }

  void updateModalBottomSheet(context) {
    String productid = data[0]['product_id'];
    updatebarcodecontroller.text = data[0]['product_code'];
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (BuildContext bc) {
          var mq = MediaQuery.of(context).size;
          return Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: mq.height * 0.56,
                  width: mq.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.width * 0.04,
                        vertical: mq.height * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Update Screen!",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: mq.height * 0.01),
                        SizedBox(
                          width: mq.width * 0.8,
                          child: Text(
                            "Select on of the options given below to Update your Barcode",
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: mq.height * 0.01,
                        ),
                        Container(
                          height: mq.height * 0.07,
                          child: TextFormField(
                            controller: updatebarcodecontroller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: myColor.themeColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: myColor.themeColor, width: 2.0),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 12.0),
                            ),
                          ),
                        ),
                        SizedBox(height: mq.height * 0.02),
                        CustomButton(
                          onTap: () async {
                            if (data[0]['updated_by'] == null) {
                              print(
                                  "User_id ${user_id} ,updatebarcodecontroller ${updatebarcodecontroller.text} productid ${productid}");
                              await fetchupdatebarcode(
                                  updatebarcodecontroller.text,
                                  productid,
                                  user_id);
                              FlushBar.flushBarMessageGreen(
                                  message: 'Barcode updated successfully',
                                  context: context);
                              updatebarcodecontroller.clear();
                              await Future.delayed(
                                  Duration(seconds: 2)); // Add a delay
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeScreenOrderPicker()));
                            } else {
                              FlushBar.flushBarMessageGreen(
                                  message: 'Barcode Already updated',
                                  context: context);
                              updatebarcodecontroller.clear();
                              await Future.delayed(
                                  Duration(seconds: 2)); // Add a delay
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeScreenOrderPicker()));
                            }
                          },
                          buttonText: "Update",
                          sizeWidth: double.infinity,
                          buttonTextSize: mq.height * 0.02,
                        ),
                        SizedBox(height: mq.height * 0.02),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
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
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
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
                      scrollDirection: Axis.horizontal,
                      child: Text(warehouse),
                    ),
                  ],
                ),
                SizedBox(height: 10),
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
                updateModalBottomSheet(context);
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

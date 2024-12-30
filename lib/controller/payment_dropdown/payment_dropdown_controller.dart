import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../model/complaint_model.dart';
import '../../repository/dispatcher_repo/dispatcher_repository_impl.dart';

class PaymentDropdownController extends ChangeNotifier {
  bool showTextField = false;
  String? user_id;
  Map orders = {};
  Map get order => orders;
  final dispatcherRepo = DispatcherRepositoryImpl();

  final List<Map> holdReason = [
    {"id": 0, "name": "Customer Not Responding"},
    {"id": 1, "name": "Customer Not Receiving Item(s)"},
    {"id": 2, "name": "Not on Route"},
    {"id": 3, "name": "Delivery time issue"},
  ];

  int selectedValue = -1;

  void check(int indexValue) {
    selectedValue = indexValue;
    print("Selected value: $selectedValue");
    notifyListeners();
  }

  Future<void> fetchData(String id, BuildContext context) async {
    print('ID: $id');
    var res = await dispatcherRepo.getSingleSale(id);
    print('Order Details: $res');
    if (res['code_status'] == true) {
      orders['data'] = res['order'];
      notifyListeners();
    } else {
      show_msg('error', res['message'], context);
    }
  }

  void show_msg(String status, String message, BuildContext context,
      {VoidCallback? onTap}) {
    AwesomeDialog(
      context: context,
      dialogType: (status == 'error') ? DialogType.error : DialogType.success,
      animType: AnimType.rightSlide,
      title: (status == 'error') ? 'Error' : 'Success',
      desc: message,
      btnOkOnPress: onTap,
    ).show();
  }

  List<ComplaintType> complaintTypes = [];
  ComplaintType? selectedComplaintType;
  String? selectedItem;
  String? get selectedItems => selectedItem;

  void setSelectedItem(String? newValue) {
    selectedItem = newValue;
    notifyListeners();
  }

  Future<void> fetchComplaintTypes() async {
    try {
      var response = await dispatcherRepo.complaintType();
      print('API Response: $response');

      if (response is List) {
        complaintTypes = response.map<ComplaintType>((item) {
          if (item is Map<String, dynamic> &&
              item['id'] is int &&
              item['complain_type'] is String) {
            return ComplaintType(
              id: item['id'] as int,
              complainType: item['complain_type'] as String,
            );
          }
          return ComplaintType(id: 0, complainType: '');
        }).toList();
        notifyListeners();
      } else {
        complaintTypes = [];
      }
    } catch (e) {
      print('Error fetching complaint types: $e');
      complaintTypes = [];
      notifyListeners();
    }
  }

  Future<void> RemarksData(
      String sale_id, String remarks, BuildContext context) async {
    var res = await dispatcherRepo.updateRemarks(sale_id, remarks);
    print('Update Status: $res');
    if (res['code_status'] == true) {
      show_msg('success', res['message'], context);
    } else {
      show_msg('error', res['message'], context);
    }
  }

  String title = "";

  Future<void> updateStatus(String id, String user_id, String status) async {
    print('Update Status');
    var res = await dispatcherRepo.dmUpdateStatus(user_id, id, status);
    notifyListeners();
    print('Update Status Response: $res');
  }
}

import 'package:delivery_man/controller/session_controller/session_controller.dart';
import 'package:delivery_man/repository/order_picker_repo/order_picker_repository.dart';
import 'package:delivery_man/repository/order_picker_repo/order_picker_repository_impl.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../view/select_roles/order_picker/order_details/order_details_order_picker.dart';

class HomeOrderPickerController extends ChangeNotifier {
  final OrderPickerRepository _orderRepository = OrderPickerRepositoryImpl();
  final TextEditingController searchController = TextEditingController();
  String firstName = '';
  String lastName = '';

  String get first_Name => firstName;
  String get last_Name => firstName;

  List mainData = [];
  List data = [];
  List filter = [];

  bool? dataFound;
  bool? get data_Found => dataFound;

  List filteredData = [];

  List tempSearch = [];
  List customerNames = [];

  String? selectedCustomerName;
  String? get selectedCustomerName_ => selectedCustomerName;

  String? formattedDate;

  Future<void> getSalesPicker(BuildContext context) async {
    try {
      final session = SessionController.instance;
      var loginId = session.userSession.loginData?.id;
      print('Login ID: $loginId');

      var res = await _orderRepository.getSales('$loginId');

      if (res['code_status'] == true) {
        mainData = res['data'];
        data = res['data'];
        filter = res['data'];
        customerNames =
            mainData.map((item) => item['customer_name']).toSet().toList();
        print('Home Screen ID: ${mainData[0]['id']}');
        print('Customer Name: $selectedCustomerName');
        print("name $customerNames");
        notifyListeners();
      } else {
        // FlushBar.flushBarMessage(
        //     message: '${res['message']}', context: context);
        print('Error code status: ${res['code_status']}');
      }
    } catch (e) {
      // FlushBar.flushBarMessage(
      //     message: 'Failed to fetch sales data. Please try again later.',
      //     context: context);
      print('Error: $e');
    }
  }

  void store_first_last_name() async {
    final session = SessionController.instance;
    await session.loadSession();
    firstName = session.userSession.loginData!.firstName.toString();
    lastName = session.userSession.loginData!.lastName.toString();
    notifyListeners();
  }

  List<DataRow> createRows(List<dynamic> items, BuildContext context) {
    return List<DataRow>.generate(
      items.length,
      (index) {
        print("item $items");
        var item = items[index];
        DateTime originalDate = DateTime.parse(item['po_date']);
        DateFormat formatter = DateFormat('dd-MM-yy');
        formattedDate = formatter.format(originalDate);
        // ignore: unused_local_variable
        var pickedStatus;
        if (item['picked_status'] == null) {
          item['picked_status'] = 'unpicked';
        }
        return DataRow(
          onSelectChanged: (value) {
            // storeID(item['id'].toString());

            print('Id ${item['id'.toString()]}');
            //
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderDetailsOrderPicker(
                          data_id: item['id'].toString(),
                        )));
          },
          cells: [
            DataCell(Text(
              item['id'].toString(),
            )),
            DataCell(Text(item['po_number'].toString())),
            DataCell(Text(item['customer_name'].toString())),
            DataCell(Text(formattedDate.toString())),
            DataCell(Text(item['picked_status'].toString())),
          ],
        );
      },
    );
  }

  String? selected_Picked_Unpicked;
  String? get selectedPickedUnpicked => selected_Picked_Unpicked;

  final List<String> statusList_Picked_Unpicked = ['Picked', 'unpicked'];
  TextEditingController dateController = TextEditingController();
}

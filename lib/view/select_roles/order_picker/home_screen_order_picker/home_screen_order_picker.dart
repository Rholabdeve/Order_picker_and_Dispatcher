import 'package:delivery_man/const/my_color.dart';
import 'package:delivery_man/controller/scanproduct/scanproduct_controller.dart';
import 'package:delivery_man/controller/session_controller/session_controller.dart';
import 'package:delivery_man/widgets/custom_button.dart';
import 'package:delivery_man/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../controller/home_order_picker/home_order_picker_controller.dart';
import '../login_screen/login_screen.dart';

class HomeScreenOrderPicker extends StatefulWidget {
  const HomeScreenOrderPicker({Key? key}) : super(key: key);

  @override
  State<HomeScreenOrderPicker> createState() => _HomeScreenOrderPickerState();
}

class _HomeScreenOrderPickerState extends State<HomeScreenOrderPicker> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final orderPickerModel =
        Provider.of<HomeOrderPickerController>(context, listen: false);
    Provider.of<ScanProductController>(context, listen: false).getdata();

    orderPickerModel.getSalesPicker(context);
    orderPickerModel.store_first_last_name();
  }

  @override
  Widget build(BuildContext context) {
    final orderPickerModel = Provider.of<HomeOrderPickerController>(context);
    final scanproduct =
        Provider.of<ScanProductController>(context, listen: false);
    print('Selected customer ${orderPickerModel.selectedCustomerName}');
    print('object');

    var mq = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: myColor.redcolor,
          title: Center(
            child: Text(
              '${orderPickerModel.firstName} ${orderPickerModel.lastName}',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: myColor.whiteColor,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: myColor.redcolor,
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: myColor.whiteColor,
                      child: Icon(
                        CupertinoIcons.person_alt,
                        color: Colors.red,
                        size: 70,
                      ),
                    ),
                    Text(
                      '${orderPickerModel.firstName} ${orderPickerModel.lastName}',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium!
                          .copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        scanproduct.scanBarcode(context);
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.qr_code_scanner_rounded,
                            color: myColor.redcolor,
                            size: 25,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Scan Product",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirm Logout"),
                              content: Text("Are you sure you want to logout?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(color: myColor.redcolor),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final session = SessionController.instance;
                                    session.clearSession();

                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                  child: Text(
                                    "Logout",
                                    style: TextStyle(color: myColor.redcolor),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            color: myColor.redcolor,
                            size: 25,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ],
          ),
        ),

        //appBar(context),
        body: orderPickerModel.data.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "No Sales Assigned. Please Assign Sale first",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 211, 0, 70),
                    ),
                  )
                ],
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: orderPickerModel.dateController,
                        readOnly: true,
                        onTap: () async {
                          await _selectDate();
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          hintText: 'Date',
                          filled: true,
                          prefixIcon: Icon(
                            Icons.calendar_month,
                            color: Color.fromARGB(255, 211, 0, 70),
                          ),
                          focusedBorder:
                              OutlineInputBorder(borderSide: BorderSide()),
                          enabledBorder:
                              OutlineInputBorder(borderSide: BorderSide.none),
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      isNoDataForDate == true
                          ? Text(
                              'No Date is found for this data',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600),
                            )
                          : Container(),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          hint: Text('Picked/Unpicked'),
                          value: orderPickerModel.selected_Picked_Unpicked,
                          icon: Icon(Icons.arrow_drop_down_sharp),
                          iconSize: 30,
                          elevation: 16,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              orderPickerModel.selected_Picked_Unpicked =
                                  newValue!;

                              orderPickerModel.mainData = orderPickerModel
                                  .filter
                                  .where((element) =>
                                      element['picked_status'] ==
                                      orderPickerModel.selected_Picked_Unpicked)
                                  .toList();
                            });
                          },
                          items: orderPickerModel.statusList_Picked_Unpicked
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value.toLowerCase(),
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down_sharp,
                            size: 30,
                          ),
                          hint: Text(
                            "Select Customer",
                          ),
                          value: orderPickerModel.selectedCustomerName,
                          onChanged: (var newValue) {
                            setState(() {
                              orderPickerModel..dateController.text = '';
                              orderPickerModel.selectedCustomerName = newValue;
                              isNoDataForDate = false;
                              if (orderPickerModel.selectedCustomerName ==
                                  'None') {
                                orderPickerModel.mainData =
                                    orderPickerModel.filter;
                              } else {
                                orderPickerModel.mainData = orderPickerModel
                                    .filter
                                    .where((element) =>
                                        element['customer_name'] ==
                                        orderPickerModel.selectedCustomerName)
                                    .toList();
                              }
                              print(
                                  'Dropdown ${orderPickerModel.selectedCustomerName}');
                            });
                          },
                          items: [
                            DropdownMenuItem<String>(
                              value: 'None',
                              child: Text(
                                'None',
                              ),
                            ),
                            ...orderPickerModel.customerNames
                                .map<DropdownMenuItem<String>>(
                              (var value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                  ),
                                );
                              },
                            ).toList(),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.01,
                      ),
                      CustomTextField(
                        controller: searchController,
                        hintText: 'Search',
                        onChanged: (value) => {
                          setState(
                            () {
                              orderPickerModel.selectedCustomerName = null;
                              orderPickerModel.dateController.text = '';
                              isNoDataForDate = false;
                              if (searchController.text.isNotEmpty) {
                                print(
                                    'Data Length ${orderPickerModel.mainData.length}');
                                orderPickerModel.tempSearch =
                                    orderPickerModel.filter.where((element) {
                                  final searchText =
                                      searchController.text.toLowerCase();
                                  final customerName =
                                      element['customer_name'].toLowerCase();
                                  final id =
                                      element['id'].toString().toLowerCase();
                                  final poNumber = element['po_number']
                                      .toString()
                                      .toLowerCase();
                                  final poDate = DateFormat('dd-MM-yy').format(
                                      DateTime.parse(element['po_date']));
                                  return customerName.contains(searchText) ||
                                      id.contains(searchText) ||
                                      poDate.contains(searchText) ||
                                      poNumber.contains(searchText);
                                }).toList();
                                orderPickerModel.mainData =
                                    orderPickerModel.tempSearch;
                              } else {
                                print('wrong');
                                orderPickerModel.mainData =
                                    orderPickerModel.filter;
                              }
                            },
                          ),
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Your Orders',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                      orderPickerModel.mainData.length == 0 &&
                              searchController.text.isNotEmpty
                          ? Text('Data not Found')
                          : orderPickerModel.mainData.isEmpty
                              ? Text(
                                  'No Data Found',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    showCheckboxColumn: false,
                                    headingTextStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                    border: TableBorder(
                                        bottom: BorderSide(width: 2),
                                        horizontalInside: BorderSide()),
                                    headingRowColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => myColor.themeColor),
                                    // dataRowHeight: 20.0,
                                    // columnSpacing: 23.0,
                                    columns: const [
                                      DataColumn(
                                        label: Center(
                                            child: Text(
                                          'Order ID',
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                      DataColumn(
                                        label: Center(
                                            child: Text(
                                          'PO Number',
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                      DataColumn(
                                        label: Center(
                                            child: Text(
                                          'Customer Name',
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                      DataColumn(
                                        label: Center(
                                            child: Text(
                                          'Po Date',
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                      DataColumn(
                                        label: Center(
                                            child: Text(
                                          'Picked/Unpicked',
                                          textAlign: TextAlign.center,
                                        )),
                                      ),
                                      // DataColumn(label: Text('Amount')),
                                    ],
                                    rows: orderPickerModel.createRows(
                                        orderPickerModel.mainData, context),
                                  ),
                                ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  AppBar appBar(context) {
    final orderPickerModel =
        Provider.of<HomeOrderPickerController>(context, listen: false);
    print("orderpickermodel $orderPickerModel");
    var mq = MediaQuery.of(context).size;
    return AppBar(
      backgroundColor: Color.fromARGB(255, 211, 0, 70),
      leading: Icon(
        CupertinoIcons.person_alt,
        color: Colors.white,
      ),
      centerTitle: true,
      title: Text(
        '${orderPickerModel.firstName} ${orderPickerModel.lastName}',
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
      ),
      actions: [
        InkWell(
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Container(
                      height: mq.height * 0.25,
                      // width: width * 0.5,
                      padding: EdgeInsets.symmetric(
                        horizontal: mq.width * 0.05,
                      ), // width: 16
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Are you sure you want to Log out?',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: mq.height * 0.03),
                          Row(
                            children: [
                              Expanded(
                                child: CustomButton(
                                    onTap: () async {
                                      final session =
                                          SessionController.instance;
                                      session.clearSession();

                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
                                          (Route<dynamic> route) => false);

                                      // setState(() {});
                                    },
                                    buttonText: 'Yes',
                                    buttonBorderWidth: 1,
                                    buttonTextWeight: FontWeight.w700,
                                    buttonColor: Colors.transparent,
                                    textColor: myColor.greenColorTheme,
                                    borderColor: myColor.greenColorTheme,
                                    sizeWidth: double.infinity),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomButton(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    buttonText: 'No',
                                    buttonTextWeight: FontWeight.w700,
                                    buttonColor: Colors.transparent,
                                    textColor: myColor.themeColor,
                                    borderColor: myColor.themeColor,
                                    sizeWidth: double.infinity),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.output_sharp,
                  color: Colors.white,
                )))
      ],
    );
  }

  void logoutbutton() {
    var mq = MediaQuery.of(context).size;
    InkWell(
      onTap: () async {
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
              child: Container(
                height: mq.height * 0.25,
                // width: width * 0.5,
                padding: EdgeInsets.symmetric(
                  horizontal: mq.width * 0.05,
                ), // width: 16
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Are you sure you want to Log out?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: mq.height * 0.03),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                              onTap: () async {
                                final session = SessionController.instance;
                                session.clearSession();

                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (Route<dynamic> route) => false);

                                // setState(() {});
                              },
                              buttonText: 'Yes',
                              buttonBorderWidth: 1,
                              buttonTextWeight: FontWeight.w700,
                              buttonColor: Colors.transparent,
                              textColor: myColor.greenColorTheme,
                              borderColor: myColor.greenColorTheme,
                              sizeWidth: double.infinity),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: CustomButton(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              buttonText: 'No',
                              buttonTextWeight: FontWeight.w700,
                              buttonColor: Colors.transparent,
                              textColor: myColor.themeColor,
                              borderColor: myColor.themeColor,
                              sizeWidth: double.infinity),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _selectDate() async {
    final orderPickerModel =
        Provider.of<HomeOrderPickerController>(context, listen: false);
    DateTime? pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly, // Hide edit button

      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        String formattedDate = DateFormat('dd-MM-yy').format(pickedDate);
        orderPickerModel.dateController.text = formattedDate;
        print(orderPickerModel.dateController.text);
        print('Formatted Date $formattedDate');
        _filterDataByDate(formattedDate);
      });
    }
  }

  bool isNoDataForDate = false;

  void _filterDataByDate(String selectedDate) {
    final orderPickerModel =
        Provider.of<HomeOrderPickerController>(context, listen: false);
    setState(() {
      orderPickerModel.filteredData = orderPickerModel.filter.where((item) {
        String itemDate =
            DateFormat('dd-MM-yy').format(DateTime.parse(item['po_date']));

        return itemDate == selectedDate;
      }).toList();
      if (orderPickerModel.filteredData.isEmpty && selectedDate.isNotEmpty) {
        isNoDataForDate = true;
      } else {
        isNoDataForDate = false;
      }
      orderPickerModel.mainData = orderPickerModel.filteredData.isEmpty
          ? orderPickerModel.filter
          : orderPickerModel.filteredData;
      orderPickerModel.selectedCustomerName = null;

      // print('Filter data $filteredData');
    });
  }
}

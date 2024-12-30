import 'package:delivery_man/controller/payment_dropdown/payment_dropdown_controller.dart';
import 'package:delivery_man/view/select_roles/dispatcher/payment_collection.dart';
import 'package:delivery_man/view/select_roles/dispatcher/view_order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class paymentDropdown extends StatefulWidget {
  final String updateID;
  final String userID;
  final customer;
  final inv_id;
  final inv_no;
  final balance_amount;
  final String update_id;
  final String id;
  final status;
  final rider_amount;
  const paymentDropdown({
    super.key,
    this.inv_id,
    this.inv_no,
    this.status,
    this.customer,
    this.balance_amount,
    required this.updateID,
    required this.userID,
    required this.update_id,
    required this.id,
    this.rider_amount,
  });

  @override
  State<paymentDropdown> createState() => _paymentDropdownState();
}

class _paymentDropdownState extends State<paymentDropdown> {
  late PaymentDropdownController _paymentDropdownController;

  @override
  void initState() {
    super.initState();
    _paymentDropdownController =
        Provider.of<PaymentDropdownController>(context, listen: false);
    _paymentDropdownController.fetchComplaintTypes();
    _paymentDropdownController.fetchData(widget.id, context);
  }

  List<String> _dropdownItems =
      ['Delivered', 'Partial', 'Hold'].toSet().toList();

  void _showRemarksDialog(title) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController remarksController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Enter Remarks',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Remarks'),
                    controller: remarksController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Remarks cannot be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _paymentDropdownController.RemarksData(widget.id,
                              "$title : ${remarksController.text}", context);
                          print('Remarks: $title : ${remarksController.text}');
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewOrder(
                                      id: widget.inv_id,
                                      update_id: widget.id,
                                      payment_status: widget.status,
                                    )),
                            (route) => route.isFirst,
                          );
                          await _paymentDropdownController.updateStatus(
                            widget.update_id,
                            widget.userID.toString(),
                            'Hold',
                          );
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentDropdownController>(context);
    // String? deliveryStatus = provider.order['data']?['delivery_status'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Delivery Status",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Please Select Delivery type",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 70,
              width: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              margin: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(3),
              ),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                dropdownColor: Colors.white,
                iconEnabledColor: Colors.black,
                iconDisabledColor: Colors.white,
                iconSize: 30,
                value: (provider.order['data'] != null &&
                        provider.order['data']['delivery_status'] != null &&
                        provider.order['data']['delivery_status'].isNotEmpty &&
                        _dropdownItems.contains(
                            provider.order['data']['delivery_status']))
                    ? provider.order['data']['delivery_status']
                    : null,
                hint: const Text(
                  "Select Delivery Status",
                  style: TextStyle(color: Colors.grey),
                ),
                onChanged: (String? newValue) async {
                  if (newValue == null) return;

                  setState(() {
                    provider.setSelectedItem(newValue);
                  });

                  if (provider.selectedItems == "Delivered") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentCollection(
                          rider_amount: widget.rider_amount,
                          item: provider.selectedItems,
                          customer: provider.order['data']['customer_id'],
                          inv_id: provider.order['data']['order_id'],
                          inv_no: provider.order['data']['order_no'],
                          balance_amount:
                              double.parse(provider.order['data']['balance'])
                                  .ceil()
                                  .toString(),
                          updateID: provider.order['data']['order_id'],
                          update_id: provider.order['data']['order_id'],
                          id: widget.id,
                          userID: provider.user_id.toString(),
                          status:
                              '${provider.order['data']['payment_status'][0].toUpperCase() + provider.order['data']['payment_status'].substring(1)}',
                        ),
                      ),
                    );
                  } else if (provider.selectedItems == "Partial") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentCollection(
                          rider_amount: widget.rider_amount,
                          item: provider.selectedItems,
                          customer: provider.order['data']['customer_id'],
                          inv_id: provider.order['data']['order_id'],
                          inv_no: provider.order['data']['order_no'],
                          balance_amount:
                              double.parse(provider.order['data']['balance'])
                                  .ceil()
                                  .toString(),
                          updateID: provider.order['data']['order_id'],
                          update_id: provider.order['data']['order_id'],
                          id: widget.id,
                          userID: provider.user_id.toString(),
                          status:
                              '${provider.order['data']['payment_status'][0].toUpperCase() + provider.order['data']['payment_status'].substring(1)}',
                        ),
                      ),
                    );
                  } else if (provider.selectedItems == "Hold") {
                    _settingModalBottomSheet(context);
                  } else {
                    setState(() {
                      provider.showTextField = false;
                    });
                  }
                },
                items: _dropdownItems
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _settingModalBottomSheet(BuildContext context) {
    final provider =
        Provider.of<PaymentDropdownController>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 80,
                          height: 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey),
                        ),
                      ),
                      SizedBox(height: 10),
                      ...List.generate(provider.holdReason.length, (index) {
                        return InkWell(
                          onTap: () {
                            provider.check(provider.holdReason[index]["id"]);
                            provider.title = provider.holdReason[index]["name"];
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 5.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: provider.selectedValue == index
                                  ? Colors.green.shade100
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  provider.selectedValue == index
                                      ? Icons.check_circle
                                      : Icons.check_circle_outline,
                                  color: provider.selectedValue == index
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    provider.holdReason[index]["name"],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: provider.selectedValue == index
                                          ? Colors.black
                                          : Colors.black54,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: double.maxFinite,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              provider.selectedValue = 0;
                              _showRemarksDialog(provider.title);
                            },
                            child: Text("Confirm Selection"),
                          ),
                        ),
                      ),
                    ]),
              );
            },
          ),
        );
      },
    );
  }

  // ignore: unused_element
  Widget _buildShimmerEffect() {
    return ListView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.inventory_2, color: Colors.grey),
                    SizedBox(width: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 10,
                          color: Colors.white,
                        ),
                        SizedBox(height: 5),
                        Container(
                          width: 150,
                          height: 10,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward, color: Colors.grey),
              ],
            ),
          ),
        );
      },
    );
  }
}

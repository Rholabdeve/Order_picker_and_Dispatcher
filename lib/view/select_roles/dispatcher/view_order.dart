import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery_man/const/my_color.dart';
import 'package:delivery_man/view/select_roles/dispatcher/dropdown_payment_status.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controller/view_order/view_order_controller.dart';

class ViewOrder extends StatefulWidget {
  final String payment_status;
  final String id;
  final String update_id;
  final String? payment_type;
  final String? payment_amount_paid;

  const ViewOrder(
      {Key? key,
      required this.id,
      this.payment_amount_paid,
      this.payment_type,
      required this.update_id,
      required this.payment_status})
      : super(key: key);

  @override
  _ViewOrderState createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  late ViewOrderController _orderProvider;

  @override
  void initState() {
    super.initState();
    _orderProvider = Provider.of<ViewOrderController>(context, listen: false);

    _refreshScreen();
  }

  Future<void> _refreshScreen() async {
    try {
      await _orderProvider.fetchOrderData(widget.id);
      await _orderProvider.readUserId();
      print("Refresh Screen Successfully");
    } catch (e) {
      show_msg('error', e.toString(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ViewOrderController>(context);
    final orderData = provider.orderData;
    print('Rebuild after pop');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context, true)),
        title: Text('Orders Details'),
        centerTitle: true,
      ),
      body: orderData.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : orderData['data'] == null
              ? Center(child: Text('No order data available.'))
              : Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => _refreshScreen(),
                        child:
                            ListView(scrollDirection: Axis.vertical, children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Container(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'Payment Status : ${provider.orderData['data']['payment_status'][0].toUpperCase() + provider.orderData['data']['payment_status'].substring(1)}',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: provider.orderData['data']
                                                          ['payment_status'] ==
                                                      "paid" ||
                                                  provider.orderData['data']
                                                          ['payment_status'] ==
                                                      "Paid"
                                              ? Colors.green
                                              : provider.orderData['data']['payment_status'] ==
                                                          "Completed" ||
                                                      provider.orderData['data']['payment_status'] ==
                                                          "completed"
                                                  ? Colors.green
                                                  : provider.orderData['data']['payment_status'] ==
                                                              "pending" ||
                                                          provider.orderData['data']['payment_status'] ==
                                                              "Pending"
                                                      ? Colors.amber
                                                      : provider.orderData['data']['payment_status'] ==
                                                                  "partial" ||
                                                              provider.orderData['data']['payment_status'] == "Partial"
                                                          ? Colors.orange
                                                          : Colors.black,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Customer Info",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Name : ' +
                                          provider.orderData['data']
                                                  ['customer_name']
                                              .toString() +
                                          ' \nEmail : ' +
                                          provider.orderData['data']
                                                  ['customer_email']
                                              .toString() +
                                          ' \nPhone : ' +
                                          provider.orderData['data']
                                                  ['customer_phone']
                                              .toString() +
                                          '\nAddress : ' +
                                          provider.orderData['data']
                                                  ['customer_address']
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(height: 5),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            provider.orderData['data']
                                                        ['customer_map_link'] ==
                                                    null
                                                ? SizedBox()
                                                : GestureDetector(
                                                    onTap: () =>
                                                        provider.openGoogleMap(
                                                      provider.orderData['data']
                                                              [
                                                              'customer_map_link']
                                                          .toString(),
                                                    ),
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        color:
                                                            Color(0xff87C440),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 5,
                                                            blurRadius: 7,
                                                            offset:
                                                                Offset(0, 3),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Text(
                                                        "View Direction",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                            Text(
                                              'Delivery Status: ${provider.orderData['data']['delivery_status'][0].toUpperCase() + provider.orderData['data']['delivery_status'].substring(1)}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: provider.orderData['data']['delivery_status'] ==
                                                            "Delivered" ||
                                                        provider.orderData['data']['delivery_status'] ==
                                                            "delivered"
                                                    ? Colors.green
                                                    : provider.orderData['data']['delivery_status'] ==
                                                                "pending" ||
                                                            provider.orderData['data']['delivery_status'] ==
                                                                "Pending"
                                                        ? Colors.amber
                                                        : provider.orderData['data']['delivery_status'] ==
                                                                    "Partial" ||
                                                                provider.orderData['data']['delivery_status'] ==
                                                                    "partial" ||
                                                                provider.orderData['data']['delivery_status'] ==
                                                                    "Hold" ||
                                                                provider.orderData['data']['delivery_status'] ==
                                                                    "hold"
                                                            ? Colors.orange
                                                            : provider.orderData['data']['delivery_status'] == "Cancelled" ||
                                                                    provider.orderData['data']
                                                                            ['delivery_status'] ==
                                                                        "cancelled"
                                                                ? Colors.red
                                                                : Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                              ),
                              Container(
                                width: double.maxFinite,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                padding: EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.supervised_user_circle,
                                      size: 35,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Supplier Info",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: 260.0,
                                          child: Text(
                                            'Name : ' +
                                                provider.orderData['data']
                                                    ['supplier_name'] +
                                                '',
                                            maxLines: 2,
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    provider.orderData['data']['items'].length,
                                itemBuilder: (BuildContext ctx, index) {
                                  String quantityString =
                                      provider.orderData['data']['items'][index]
                                          ['quantity'];
                                  double quantityDouble =
                                      double.parse(quantityString);
                                  String formattedQuantity =
                                      NumberFormat("#,##0", "en_US")
                                          .format(quantityDouble);

                                  String priceString =
                                      provider.orderData['data']['items'][index]
                                          ['price'];
                                  double priceDouble =
                                      double.parse(priceString);

                                  double calculate =
                                      priceDouble * quantityDouble;
                                  String formattedPrice_calculate =
                                      NumberFormat("#,##0", "en_US")
                                          .format(calculate);

                                  return InkWell(
                                    onTap: () {
                                      print(provider.orderData);
                                    },
                                    child: Container(
                                      width: double.maxFinite,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      padding: EdgeInsets.all(15.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.inventory_2,
                                                size: 35,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 140.0,
                                                    child: Text(
                                                      provider.orderData['data']
                                                              ['items'][index]
                                                          ['product_name'],
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 140.0,
                                                    child: Text(
                                                      provider.orderData['data']
                                                              ['items'][index]
                                                          ['product_barcode'],
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Quantity: $formattedQuantity',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              Text(
                                                'Price: $formattedPrice_calculate',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              // Text('Product mrp: $priceDouble'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      width: double.maxFinite,
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: myColor.ThemeColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.9),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Invoice:',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Container(
                                child: Text(
                                  provider.orderData['data']['order_no'],
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Balance Amount:',
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                  double.parse(
                                          provider.orderData['data']['balance'])
                                      .ceil()
                                      .toString(),
                                  style: TextStyle(fontSize: 18))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          double.parse(provider.orderData['data']['balance']) ==
                                  0
                              ? SizedBox()
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 172.0,
                                      child: provider.orderData['data']
                                                  ['payment_method'] ==
                                              null
                                          ? Text(
                                              maxLines: 2,
                                              'Received By Rider :',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 18),
                                            )
                                          : Text(
                                              maxLines: 2,
                                              'Received By Rider  ( ${(provider.orderData['data']['payment_method'].toString())})',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                    ),
                                    Text(
                                      double.parse(provider.orderData["data"]
                                              ["rider_amount"])
                                          .ceil()
                                          .toString(),
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Amount:',
                                  style: TextStyle(fontSize: 18)),
                              Text(
                                  double.parse(provider.orderData['data']
                                          ['grand_total'])
                                      .ceil()
                                      .toString(),
                                  style: TextStyle(fontSize: 18))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(
                          left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Total Items: ' +
                                      provider.orderData['data']['items'].length
                                          .toString(),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.4),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final result = await provider.orderData['data']
                                                ['balance'] ==
                                            '0.0000' ||
                                        double.parse(provider.orderData["data"]
                                                    ["rider_amount"])
                                                .ceil() >=
                                            double.parse(
                                                    provider.orderData['data']
                                                        ['grand_total'])
                                                .ceil()
                                    ? show_msg(
                                        "success",
                                        "Total Amount has already been paid.",
                                        context)
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                paymentDropdown(
                                                  rider_amount: double.parse(
                                                          provider.orderData[
                                                                  "data"]
                                                              ["rider_amount"])
                                                      .ceil(),
                                                  customer:
                                                      provider.orderData['data']
                                                          ['customer_id'],
                                                  inv_id:
                                                      provider.orderData['data']
                                                          ['order_id'],
                                                  inv_no:
                                                      provider.orderData['data']
                                                          ['order_no'],
                                                  balance_amount: double.parse(
                                                          provider.orderData[
                                                                  'data']
                                                              ['balance'])
                                                      .ceil()
                                                      .toString(),
                                                  updateID:
                                                      provider.orderData['data']
                                                          ['order_id'],
                                                  update_id:
                                                      provider.orderData['data']
                                                          ['order_id'],
                                                  id: widget.id,
                                                  userID: provider.userId
                                                      .toString(),
                                                  status:
                                                      '${provider.orderData['data']['payment_status'][0].toUpperCase() + provider.orderData['data']['payment_status'].substring(1)}',
                                                )));

                                if (result == true) {
                                  setState(() {
                                    provider.fetchOrderData(widget.id);
                                    print('HELLO Rebuild');
                                  });
                                }

                                if (double.parse(provider.orderData["data"]
                                            ["rider_amount"])
                                        .ceil() <=
                                    double.parse(provider.orderData['data']
                                            ['grand_total'])
                                        .ceil()) {
                                  print("Open the Gate: 👍");
                                } else if (double.parse(provider
                                            .orderData["data"]["rider_amount"])
                                        .ceil() >=
                                    double.parse(provider.orderData['data']
                                            ['grand_total'])
                                        .ceil()) {
                                  print("No Permission 👍");
                                }

                                print('Hello navigator');
                                print(
                                    provider.orderData['data']['customer_id']);

                                print(provider.orderData['data']['order_id']);
                                print(provider.orderData['data']['order_no']);
                                print(provider.orderData['data']['balance']);
                                print(
                                  widget.update_id,
                                );
                                print(provider.userId.toString());
                                print("id: ${widget.id.toString()}");
                              },
                              child: Text(provider.orderData['data']
                                          ['balance'] ==
                                      '0.0000'
                                  ? 'Delivered'
                                  : 'Delivery Status'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: () {
                            provider.openWhatsApp(
                                context,
                                provider.orderData['data']['customer_phone']
                                    .toString());
                          },
                          child: Text(
                            'Chat with Customer',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
    );
  }

  show_msg(status, message, context) {
    return AwesomeDialog(
      context: context,
      dialogType: (status == 'error') ? DialogType.error : DialogType.success,
      animType: AnimType.rightSlide,
      title: (status == 'error') ? 'Error' : 'Success',
      desc: message,
      // btnCancelOnPress: () {},
      btnOkOnPress: () {},
    )..show();
  }
}

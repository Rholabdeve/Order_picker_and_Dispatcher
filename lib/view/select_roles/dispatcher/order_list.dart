import 'package:delivery_man/view/select_roles/dispatcher/view_order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:shimmer/shimmer.dart';

import '../../../controller/order_list/order_list_controller.dart';

class OrderList extends StatefulWidget {
  final String route_id;
  final String date;

  const OrderList({Key? key, required this.route_id, required this.date})
      : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  void initState() {
    super.initState();
    _initOrders();
  }

  Future<void> _initOrders() async {
    final controller = Provider.of<OrdersController>(context, listen: false);
    controller.user_id = await OrdersController.readUserId();
    await controller.fetchData(
        controller.user_id!, widget.route_id, widget.date);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OrdersController>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Orders List'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                controller.fetchData(
                    controller.user_id!, widget.route_id, widget.date);
              },
              child: Icon(
                Icons.refresh,
                size: 30,
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Colors.black.withOpacity(0.7), width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isDense: true,
                          isExpanded: true,
                          hint: Text('Filter Order'),
                          value: context
                              .watch<OrdersController>()
                              .selectedPaymentStatus,
                          onChanged: (String? newValue) {
                            context
                                .read<OrdersController>()
                                .updateSelectedPaymentStatus(newValue);
                          },
                          items: context
                              .watch<OrdersController>()
                              .paymentStatusOptions
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search by Invoice No',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (query) {
                          context
                              .read<OrdersController>()
                              .updateSearchQuery(query);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            controller.isLoading
                ? Expanded(child: _buildShimmerEffect())
                : controller.filteredOrders.isEmpty
                    ? Expanded(child: Center(child: Text("No Orders Found!")))
                    : Expanded(
                        child: RefreshIndicator(
                          onRefresh: () => controller.refreshScreen(
                              widget.route_id, widget.date),
                          child: ListView.builder(
                              itemCount: controller.filteredOrders.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return InkWell(
                                  onTap: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViewOrder(
                                          id: controller.filteredOrders[index]
                                                      ['order_id']
                                                  ?.toString() ??
                                              '',
                                          update_id: controller
                                                  .filteredOrders[index]['id']
                                                  ?.toString() ??
                                              '',
                                          payment_status: controller
                                                  .filteredOrders[index]
                                                      ["payment_status"]
                                                  ?.toString() ??
                                              'Unknown',
                                          payment_type: controller
                                                  .filteredOrders[index]
                                                      ["payment_method"]
                                                  ?.toString() ??
                                              'Unknown', // Fixing payment_method as well
                                          payment_amount_paid: controller
                                                  .filteredOrders[index]
                                                      ["rider_amount"]
                                                  ?.toString() ??
                                              '0.0',
                                        ),
                                      ),
                                    );

                                    if (result == true) {
                                      setState(() {
                                        controller.fetchData(
                                          controller.user_id!,
                                          widget.route_id,
                                          widget.date,
                                        );
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: double.maxFinite,
                                    margin: EdgeInsets.only(
                                        left: 10.0, right: 10.0, bottom: 10.0),
                                    padding: EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
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
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                  formatSaleDate(controller
                                                              .filteredOrders[
                                                          index]["sale_date"] ??
                                                      ""),
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 13.5,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ),
                                            Flexible(
                                              child: Text(
                                                "Delivery Status: ${controller.filteredOrders[index]['delivery_status']}",
                                                style: TextStyle(
                                                    color: controller.filteredOrders[index]["delivery_status"] ==
                                                                "Delivered" ||
                                                            controller.filteredOrders[index]
                                                                    [
                                                                    "delivery_status"] ==
                                                                "delivered"
                                                        ? Colors.green
                                                        : controller.filteredOrders[index]["delivery_status"] ==
                                                                    "Pending" ||
                                                                controller.filteredOrders[index]["delivery_status"] ==
                                                                    "pending"
                                                            ? Colors.amber
                                                            : controller.filteredOrders[index]["delivery_status"] == "Partial" ||
                                                                    controller.filteredOrders[index]["delivery_status"] ==
                                                                        "partial" ||
                                                                    controller.filteredOrders[index]["delivery_status"] ==
                                                                        "Hold" ||
                                                                    controller.filteredOrders[index]["delivery_status"] ==
                                                                        "hold"
                                                                ? Colors.orange
                                                                : controller.filteredOrders[index]["delivery_status"] == "Cancelled" ||
                                                                        controller.filteredOrders[index]["delivery_status"] == "cancelled"
                                                                    ? Colors.red
                                                                    : Colors.black,
                                                    fontSize: 14.5,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.inventory_2,
                                              size: 35.0,
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    controller.filteredOrders[
                                                                index]
                                                            ['reference_no'] ??
                                                        "",
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 240,
                                                  child: Text(
                                                      controller.filteredOrders[
                                                                  index][
                                                              "customer_name"] ??
                                                          "",
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Payment Status:",
                                                      style: TextStyle(
                                                          color: controller.filteredOrders[index]["payment_status"] ==
                                                                      "paid" ||
                                                                  controller.filteredOrders[index][
                                                                          "payment_status"] ==
                                                                      "Paid"
                                                              ? Colors.green
                                                              : controller.filteredOrders[index]["payment_status"] ==
                                                                          "Completed" ||
                                                                      controller.filteredOrders[index]["payment_status"] ==
                                                                          "completed"
                                                                  ? Colors.green
                                                                  : controller.filteredOrders[index]["payment_status"] ==
                                                                              "pending" ||
                                                                          controller.filteredOrders[index]["payment_status"] ==
                                                                              "Pending"
                                                                      ? Colors
                                                                          .amber
                                                                      : controller.filteredOrders[index]["payment_status"] == "partial" ||
                                                                              controller.filteredOrders[index]["payment_status"] == "Partial" ||
                                                                              controller.filteredOrders[index]["payment_status"] == "Hold" ||
                                                                              controller.filteredOrders[index]["payment_status"] == "hold"
                                                                          ? Colors.orange
                                                                          : Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      "${controller.filteredOrders[index]['payment_status']}",
                                                      style: TextStyle(
                                                          color: controller.filteredOrders[index]["payment_status"] ==
                                                                      "paid" ||
                                                                  controller.filteredOrders[index][
                                                                          "payment_status"] ==
                                                                      "Paid"
                                                              ? Colors.green
                                                              : controller.filteredOrders[index]["payment_status"] ==
                                                                          "Completed" ||
                                                                      controller.filteredOrders[index]["payment_status"] ==
                                                                          "completed"
                                                                  ? Colors.green
                                                                  : controller.filteredOrders[index]["payment_status"] ==
                                                                              "pending" ||
                                                                          controller.filteredOrders[index]["payment_status"] ==
                                                                              "Pending"
                                                                      ? Colors
                                                                          .amber
                                                                      : controller.filteredOrders[index]["payment_status"] == "partial" ||
                                                                              controller.filteredOrders[index]["payment_status"] == "Partial" ||
                                                                              controller.filteredOrders[index]["payment_status"] == "Hold" ||
                                                                              controller.filteredOrders[index]["payment_status"] == "hold"
                                                                          ? Colors.orange
                                                                          : Colors.black,
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return ListView.builder(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
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

  String formatSaleDate(String saleDate) {
    DateTime dateTime = DateTime.parse(saleDate);
    return DateFormat('MM-d-y,h:mma').format(dateTime);
  }
}

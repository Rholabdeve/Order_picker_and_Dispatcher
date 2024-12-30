import 'package:delivery_man/controller/payment_collection/payment_collection_controller.dart';
import 'package:delivery_man/view/select_roles/dispatcher/component/snackbar.dart';
import 'package:delivery_man/view/select_roles/dispatcher/view_order.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter_config/flutter_config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shimmer/shimmer.dart';

class PaymentCollection extends StatefulWidget {
  final String updateID;
  final String userID;
  final customer;
  final inv_id;
  final inv_no;
  final balance_amount;
  final String update_id;
  final String id;
  final status;
  final String? item;
  final rider_amount;

  const PaymentCollection(
      {Key? key,
      this.inv_id,
      this.inv_no,
      this.status,
      this.customer,
      this.balance_amount,
      required this.updateID,
      required this.userID,
      required this.update_id,
      required this.id,
      this.item,
      this.rider_amount})
      : super(key: key);

  @override
  _PaymentCollectionState createState() => _PaymentCollectionState();
}

class _PaymentCollectionState extends State<PaymentCollection> {
  late PaymentController _paymentController;

  @override
  void initState() {
    super.initState();
    _paymentController = PaymentController();
    _paymentController.fetchComplaintTypes();
    _paymentController.fetchData(widget.id, context);
    if (widget.inv_id != null) {
      _paymentController.invoiceController.text = widget.inv_no;
      _paymentController.selectedInvoice = widget.inv_id;
      _paymentController.balance_amount_controller.text = widget.balance_amount;
      _paymentController.amountController.text = widget.balance_amount;
    }
    _paymentController.getData();
    _paymentController.dateController.text =
        DateFormat('dd-MM-yyyy').format(DateTime.now());

    print("Invoice Id: ${widget.inv_id}");
    print("Invoice Controller Id:${_paymentController.invoiceController.text}");
    print("Selected Invoice:${_paymentController.selectedInvoice}");
    print(
        "Balance Controller:${_paymentController.balance_amount_controller.text}");
    print("Amount Controller:${_paymentController.amountController.text}");
  }

  @override
  Widget build(BuildContext context) {
    print('Update ID ${widget.updateID}');
    print('User ID ${widget.userID}');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Image(
          height: 30,
          fit: BoxFit.contain,
          image: AssetImage(
            'assets/images/distrho_logo.png',
          ),
        ),
        centerTitle: true,
      ),
      body: ModalProgressHUD(
        inAsyncCall: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _paymentController.formKey,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: SizedBox(
                              width: double.maxFinite,
                              height: 80,
                              child: TextFormField(
                                controller: _paymentController.dateController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Enter Date",
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Date Is Required";
                                  }
                                  return null;
                                },
                                readOnly: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: SizedBox(
                              width: double.maxFinite,
                              height: 80,
                              child: TextFormField(
                                controller:
                                    _paymentController.invoiceController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Against Invoice",
                                  border:
                                      OutlineInputBorder(), //label text of field
                                ),
                                onChanged: (value) {
                                  // subject = value;
                                  setState(() {
                                    print('hello  yoo');
                                  });
                                },
                                readOnly: true,
                                onTap: () => {
                                  (widget.inv_id == null)
                                      ? showModalBottomSheet(
                                          useSafeArea: true,
                                          shape: const BeveledRectangleBorder(),
                                          backgroundColor: Colors.white,
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (context) => StatefulBuilder(
                                            builder: (BuildContext context,
                                                void Function(void Function())
                                                    setState) {
                                              return Scaffold(
                                                appBar: AppBar(
                                                  leading: IconButton(
                                                    icon: Icon(Icons.arrow_back,
                                                        color: Colors.black),
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(),
                                                  ),
                                                ),
                                                body: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: TextFormField(
                                                        controller:
                                                            _paymentController
                                                                .searchController,
                                                        onChanged: (value) => {
                                                          setState(
                                                            () {
                                                              if (_paymentController
                                                                  .searchController
                                                                  .text
                                                                  .isNotEmpty) {
                                                                _paymentController.tempSearch = _paymentController
                                                                    .filter
                                                                    .where((element) => element[
                                                                            'reference_no']
                                                                        .toLowerCase()
                                                                        .contains(_paymentController
                                                                            .searchController
                                                                            .text
                                                                            .toLowerCase()))
                                                                    .toList();
                                                                _paymentController
                                                                        .invoice =
                                                                    _paymentController
                                                                        .tempSearch;
                                                                print(_paymentController
                                                                    .tempSearch);
                                                              } else {
                                                                _paymentController
                                                                        .invoice =
                                                                    _paymentController
                                                                        .filter;
                                                              }
                                                            },
                                                          ),
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          prefixIcon: Icon(
                                                            Icons.search,
                                                            color: Colors.green,
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          border: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                          hintText:
                                                              'Search Invoices',
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Flexible(
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            ListView.builder(
                                                              physics:
                                                                  NeverScrollableScrollPhysics(),
                                                              scrollDirection:
                                                                  Axis.vertical,
                                                              shrinkWrap: true,
                                                              itemCount:
                                                                  _paymentController
                                                                      .invoices
                                                                      .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          ctx,
                                                                      index) {
                                                                return InkWell(
                                                                  onTap: () {
                                                                    if (_paymentController.invoices[index]
                                                                            [
                                                                            'reference_no'] !=
                                                                        null) {
                                                                      setState(
                                                                          () {
                                                                        _paymentController
                                                                            .invoiceController
                                                                            .text = _paymentController.invoices[index]
                                                                                ['reference_no']
                                                                            .toString();

                                                                        _paymentController
                                                                            .amountController
                                                                            .text = _paymentController.invoices[index]
                                                                                ['balance']
                                                                            .toString();

                                                                        _paymentController
                                                                            .balance_amount_controller
                                                                            .text = _paymentController.invoices[index]
                                                                                ['balance']
                                                                            .toString();

                                                                        _paymentController
                                                                            .selectedInvoice = _paymentController
                                                                                .invoices[index]
                                                                            [
                                                                            'id'];
                                                                        // customer = _customer[index]['id']!;
                                                                      });
                                                                    }
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Card(
                                                                    child:
                                                                        ListTile(
                                                                      leading: Icon(
                                                                          Icons
                                                                              .inventory_2),
                                                                      title: Text(
                                                                          _paymentController.invoices[index]
                                                                              [
                                                                              'reference_no']),
                                                                      subtitle: Text('PKR. ' +
                                                                          _paymentController.invoices[index]
                                                                              [
                                                                              "balance"]),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : print('ab'),
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Select Invoice";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SizedBox(
                              width: double.infinity,
                              height: 80,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                readOnly: false,
                                controller: _paymentController
                                    .balance_amount_controller,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Balance Amount",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  // subject = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Balance Amount Is Required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: double.infinity,
                              height: 80,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: _paymentController.amountController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Amount Received",
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  // subject = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Amount Is Required";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 80,
                            margin: EdgeInsets.only(left: 10.0, right: 10.0),
                            width: double.maxFinite,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(width: 0.5),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              hint: Text(widget.status == "Paid"
                                  ? "Online Transfer"
                                  : 'Please choose Payment Type'),
                              value: _paymentController.selectedPriority,
                              onChanged: widget.status == 'Paid'
                                  ? null
                                  : (newValue) {
                                      setState(() {
                                        _paymentController.selected_Priority =
                                            newValue;
                                      });
                                    },
                              items: (widget.status == 'Paid'
                                      ? ['Online Transfer']
                                      : _paymentController.priority)
                                  .map((location) {
                                return DropdownMenuItem(
                                  value: location,
                                  child: Text(location),
                                );
                              }).toList(),
                              validator: (value) {
                                // Skip validation if status is "Paid"
                                if (widget.status == 'Paid') {
                                  return null;
                                }
                                return value == null
                                    ? 'Priority required'
                                    : null;
                              },
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 42,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          widget.item == "Partial"
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 80,
                                    child: TextFormField(
                                      controller:
                                          _paymentController.partialMarks,
                                      readOnly: false,
                                      //controller: _balance_amount_controller,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        labelText: "Enter Remarks",
                                        border:
                                            OutlineInputBorder(), //label text of field
                                      ),
                                      onChanged: (value) {
                                        // subject = value;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter Remarks";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 20.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              height: 50,
              width: double.maxFinite,
              child: widget.item == "Delivered"
                  ? ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _paymentController.isLoading = true;
                        });
                        //done by Ali
                        double amount = double.tryParse(
                                _paymentController.amountController.text) ??
                            0.0;
                        double balance = double.tryParse(_paymentController
                                .balance_amount_controller.text) ??
                            0.0;

                        if (amount > balance) {
                          print("Error");
                          _paymentController.amountController.text =
                              widget.balance_amount;
                          showInSnackBar(
                              'Given amount is exceeded than total amount',
                              color: Colors.red);
                          setState(() {
                            _paymentController.isLoading = false;
                          });
                        } else if (amount <= balance &&
                            _paymentController.formKey.currentState!
                                .validate()) {
                          _paymentController.formKey.currentState!.save();

                          if (_paymentController
                                      .balance_amount_controller.text !=
                                  '0' &&
                              balance == amount) {
                            await _paymentController.sendImage(
                                '${FlutterConfig.get('BASEURL')}paymentcollections/create',
                                _paymentController.localPath,
                                _paymentController.selectedInvoice.toString(),
                                _paymentController.retailer_id.toString(),
                                _paymentController.selected_Priority.toString(),
                                _paymentController.chequeController.text,
                                _paymentController.amountController.text,
                                _paymentController.created_by.toString(),
                                _paymentController.notesController.text,
                                //add new filed............
                                _paymentController.partialMarks.text,
                                context);
                            await _paymentController.updateStatus(
                              widget.update_id,
                              widget.userID.toString(),
                              'Delivered',
                            );
                            setState(() {
                              _paymentController.isLoading = false;
                            });

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
                          } else {
                            setState(() {
                              _paymentController.isLoading = false;
                            });
                            Fluttertoast.showToast(
                                msg:
                                    " Received Amount is Not Equal to Balance ",
                                gravity: ToastGravity.TOP,
                                toastLength: Toast.LENGTH_SHORT,
                                // fontSize: 20,
                                backgroundColor: Colors.red);
                          }
                        } else {
                          setState(() {
                            _paymentController.isLoading = false;
                          });
                        }
                      },
                      child: _paymentController.isLoading == true
                          ? CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            )
                          : Text('Add Payment'),
                    )
                  : ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _paymentController.isLoading = true;
                        });
                        //done by Ali
                        double amount = double.tryParse(
                                _paymentController.amountController.text) ??
                            0.0;
                        double balance = double.tryParse(_paymentController
                                .balance_amount_controller.text) ??
                            0.0;

                        if (amount > balance) {
                          print("Error");
                          double balanceAmount = double.tryParse(
                                  widget.balance_amount.toString()) ??
                              0.0;
                          double riderAmount =
                              double.tryParse(widget.rider_amount.toString()) ??
                                  0.0;

                          int resultAmount =
                              (balanceAmount - riderAmount).toInt();
                          _paymentController.amountController.text =
                              resultAmount.toString();
                          showInSnackBar(
                              'Given amount is exceeded than total amount',
                              color: Colors.red);
                          setState(() {
                            _paymentController.isLoading = false;
                          });
                        } else if (amount <= balance &&
                            _paymentController.formKey.currentState!
                                .validate()) {
                          _paymentController.formKey.currentState!.save();

                          if (_paymentController
                                      .balance_amount_controller.text !=
                                  '0' &&
                              amount != 0) {
                            setState(() {
                              _paymentController.isLoading = true;
                            });

                            await _paymentController.sendImage(
                              '${FlutterConfig.get('BASEURL')}paymentcollections/create',
                              _paymentController.localPath,
                              _paymentController.selectedInvoice.toString(),
                              _paymentController.retailer_id.toString(),
                              _paymentController.selected_Priority.toString(),
                              _paymentController.chequeController.text,
                              _paymentController.amountController.text,
                              _paymentController.created_by.toString(),
                              _paymentController.notesController.text,
                              //add new filed............
                              _paymentController.partialMarks.text,
                              context,
                            );
                            await _paymentController.updateStatus(
                              widget.update_id,
                              widget.userID.toString(),
                              'Partial',
                            );
                            setState(() {
                              _paymentController.isLoading = false;
                            });

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
                          } else {
                            setState(() {
                              _paymentController.isLoading = false;
                            });

                            showInSnackBar(
                                'Balance and Amount Should not be zero',
                                color: Colors.red);
                          }
                        } else {
                          setState(() {
                            _paymentController.isLoading = false;
                          });
                        }
                      },
                      child: _paymentController.isLoading == true
                          ? CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            )
                          : Text('Add Payment'),
                    ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  // ignore: unused_element
  void _showRemarksDialog() {
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Process the form data
                          _paymentController.RemarksData(
                              widget.id, remarksController.text, context);
                          print('Remarks: ${remarksController.text}');
                          Navigator.of(context).pop();
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

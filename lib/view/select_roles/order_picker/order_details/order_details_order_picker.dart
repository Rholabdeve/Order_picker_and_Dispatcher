import 'package:delivery_man/const/my_color.dart';
import 'package:delivery_man/widgets/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../controller/order_detail_picker/order_detail_picker_controller.dart';
import '../home_screen_order_picker/home_screen_order_picker.dart';

class OrderDetailsOrderPicker extends StatefulWidget {
  final String data_id;

  const OrderDetailsOrderPicker({Key? key, required this.data_id})
      : super(key: key);

  @override
  State<OrderDetailsOrderPicker> createState() =>
      _OrderDetailsOrderPickerState();
}

class _OrderDetailsOrderPickerState extends State<OrderDetailsOrderPicker> {
  void initState() {
    super.initState();
    final provider = Provider.of<OrderDetailsProvider>(context, listen: false);
    provider.dateId = widget.data_id;
    provider.fetchSalesDetails(widget.data_id);
    print("get_id ${widget.data_id}");
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderDetailsProvider>(context);
    var mq = MediaQuery.of(context).size;
    print('Data idhar ${provider.data}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 211, 0, 70),
        centerTitle: true,
        title: Text(
          'Order Details',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => HomeScreenOrderPicker()),
                  (Route<dynamic> route) => false);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: provider.data.isEmpty
          ? Center(
              child: CircularProgressIndicator(
              color: myColor.themeColor,
            ))
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: provider.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      String quantityString = provider.data[index]['quantity'];
                      int quantityInt = int.parse(
                          double.parse(quantityString).toInt().toString());
                      String mrpString = provider.data[index]['mrp'];
                      int mrpInt = int.parse(mrpString.split('.')[0]);

                      var carton_size =
                          int.parse(provider.data[index]['carton_size']);
                      var carton_quantities;

                      carton_quantities = (quantityInt / carton_size);

                      var carton_quantity = carton_quantities.round();

                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(7.0),
                            padding: EdgeInsets.all(7.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      offset: Offset(2, 2),
                                      blurRadius: 2)
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        new PageRouteBuilder(
                                            opaque: false,
                                            barrierDismissible: true,
                                            pageBuilder:
                                                (BuildContext context, _, __) {
                                              return Container(
                                                color: Colors.black38,
                                                alignment: Alignment.center,
                                                child: Material(
                                                    color: Colors.redAccent
                                                        .withOpacity(0.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Hero(
                                                        tag: "image",
                                                        child: Image.asset(
                                                          "assets/images/no_image.png",
                                                          fit: BoxFit.cover,
                                                          height: 400.00,
                                                          width: 400.0,
                                                        ),
                                                      ),
                                                    )),
                                              );
                                            }));
                                  },
                                  child: Hero(
                                    tag: 'image',
                                    child: Container(
                                      height: mq.height * 0.12,
                                      width: mq.width * 0.17,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                              'assets/images/no_image.png'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 180.0,
                                      child: Text(
                                        maxLines: 2,
                                        'Name: ${provider.data[index]['product_name']}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    // Text('Quantity: $quantityInt'),
                                    Text(
                                      'Mrp: $mrpInt',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      'Carton Quantity: $carton_quantity',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      'Loose Pieces: $quantityInt',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      'Expiry: ${provider.data[index]['expiry']}',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Center(
                                        child: checkBarcode(
                                      index,
                                    )),
                                  ],
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: myColor.themeColor),
                                  onPressed: () {
                                    provider.scanBarcode(index);
                                  },
                                  child: Text(
                                    'Scan',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(
                      color: Colors.black,
                      thickness: 1,
                    ),
                  ),
                  if (provider.allOrdersPicked())
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'All products are picked!',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: myColor.themeColor),
                            onPressed: () async {
                              print('On Press ${widget.data_id}');
                              SchedulerBinding.instance.addPostFrameCallback(
                                (_) async {
                                  FlushBar.flushBarMessageGreen(
                                      message: 'All Orders Are Matched',
                                      context: context);
                                },
                              );
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeScreenOrderPicker()),
                                  (Route<dynamic> route) => false);
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    )
                  else
                    Container(),
                ],
              ),
            ),
    );
  }

  Widget checkBarcode(int index) {
    final provider = Provider.of<OrderDetailsProvider>(context, listen: false);
    if (provider.data[index]['second_name'] == null ||
        provider.data[index]['second_name'].isEmpty) {
      return Container();
    }
    bool isMatch = provider.data[index]['second_name'] == 'Matched';
    return Text(
      provider.data[index]['second_name'],
      style: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: isMatch ? Colors.green : Colors.red,
      ),
    );
  }
}

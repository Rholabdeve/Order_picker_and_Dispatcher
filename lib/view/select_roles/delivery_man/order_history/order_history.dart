import 'package:delivery_man/const/my_color.dart';
import 'package:delivery_man/widgets/custom_container.dart';
import 'package:flutter/material.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order History',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.only(top: 10),
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: mq.height * 0.02,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CustomContainer(
              spreadRadius: 1,
              color: Colors.white,
              shadowBlurRadius: 4,
              shadowColor: Colors.grey.withOpacity(0.3),
              sizeHeight: mq.height * 0.14,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                  vertical: 10, horizontal: mq.width * 0.03),
              // color: const Color.fromARGB(255, 255, 166, 160),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order ID #100060',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Amount',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: mq.height * 0.005),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Status: ',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Delivered',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: myColor.themeColor),
                          ),
                        ],
                      ),
                      Text(
                        '\$1010',
                        style: TextStyle(
                            color: myColor.themeColor,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  SizedBox(height: mq.height * 0.005),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        maxRadius: 4,
                      ),
                      SizedBox(width: mq.width * 0.01),
                      Text(
                        'Order at 22 Jun 2024',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

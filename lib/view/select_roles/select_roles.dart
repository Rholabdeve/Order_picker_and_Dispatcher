import 'package:delivery_man/const/my_color.dart';
import 'package:delivery_man/widgets/custom_container.dart';
import 'package:flutter/material.dart';

import 'order_picker/login_screen/login_screen.dart';

class SelectRoles extends StatelessWidget {
  const SelectRoles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: CustomContainer(
                shadowColor: Colors.grey.withOpacity(0.5),
                shadowBlurRadius: 5,
                spreadRadius: 5,
                color: myColor.themeColor,
                alignment: Alignment.center,
                sizeHeight: mq.height * 0.1,
                sizeWidth: mq.width * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.delivery_dining_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(
                      width: mq.width * 0.03,
                    ),
                    const Text(
                      'Delivery Man',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: mq.height * 0.05,
          ),
          Center(
            child: InkWell(
              onTap: () {},
              child: CustomContainer(
                shadowColor: Colors.grey.withOpacity(0.5),
                shadowBlurRadius: 5,
                spreadRadius: 5,
                color: myColor.greenColorTheme,
                alignment: Alignment.center,
                sizeHeight: mq.height * 0.1,
                sizeWidth: mq.width * 0.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageIcon(
                        size: 30,
                        color: Colors.white,
                        AssetImage('assets/images/order-picker.png')),
                    SizedBox(
                      width: mq.width * 0.03,
                    ),
                    Text(
                      'Order Picker',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

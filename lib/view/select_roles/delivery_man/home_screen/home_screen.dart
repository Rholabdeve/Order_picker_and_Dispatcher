import 'package:delivery_man/const/my_color.dart';
import 'package:delivery_man/widgets/custom_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Active Orders',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            ListView.separated(
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: mq.height * 0.02,
              ),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return CustomContainer(
                    radius: 11,
                    sizeHeight: mq.height * 0.2,
                    shadowColor: Colors.grey,
                    // border: Border.all(color: Colors.black, width: 1),
                    // padding: EdgeInsets.symmetric(vertical: mq.height * 0.01),
                    // color: Colors.white,
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: mq.height * 0.03,
                            width: mq.width * 0.18,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: myColor.themeColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            child: Text(
                              'Pending',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Order ID: #100029',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 12),
                              ),
                              SizedBox(
                                height: mq.height * 0.025,
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(CupertinoIcons.location_solid),
                                  Text(
                                    'Address not found',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: mq.height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomContainer(
                                      border: Border.all(color: Colors.grey),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'View Details',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: mq.width * 0.03,
                                  ),
                                  Expanded(
                                    child: CustomContainer(
                                      color: myColor.themeColor,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Direction',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar(context) {
    var mq = MediaQuery.of(context).size;
    return AppBar(
      leading: Icon(CupertinoIcons.person_alt),
      title: Text(
        'Your Name Delivery Man',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      actions: [
        Icon(Icons.restart_alt),
        SizedBox(
          width: mq.width * 0.02,
        ),
        Icon(Icons.more_vert)
      ],
    );
  }
}

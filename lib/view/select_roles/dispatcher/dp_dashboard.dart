import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:delivery_man/controller/session_controller/session_controller.dart';
import 'package:delivery_man/view/select_roles/dispatcher/component/location.dart';
import 'package:delivery_man/view/select_roles/dispatcher/order_list.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controller/dp_dashboard/dp_dashboard_controller.dart';
import 'component/drawer_navigate.dart';

class DpDashboard extends StatefulWidget {
  const DpDashboard({Key? key}) : super(key: key);
  @override
  _DpDashboardState createState() => _DpDashboardState();
}

class _DpDashboardState extends State<DpDashboard> {
  @override
  void initState() {
    final dpDashBoardController =
        Provider.of<DpDashboardController>(context, listen: false);

    dpDashBoardController.store_first_last_name();
    get_permission();
    get_location();
    super.initState();
  }

  Widget build(BuildContext context) {
    final session = SessionController.instance;
    return ChangeNotifierProvider(
      create: (_) => DpDashboardController(),
      child: Consumer<DpDashboardController>(builder: (context, controller, _) {
        return PopScope(
          canPop: false,
          child: ModalProgressHUD(
            inAsyncCall: controller.isLoading,
            child: Builder(builder: (context) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color(0xff87C440),
                  title: Image(
                    height: 30,
                    fit: BoxFit.contain,
                    image: AssetImage(
                      'assets/images/distrho_logo.png',
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          controller.refreshData();
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
                body: ModalProgressHUD(
                  inAsyncCall: controller.saving,
                  child: RefreshIndicator(
                    onRefresh: () => controller.refreshData(),
                    child: ListView(scrollDirection: Axis.vertical, children: [
                      Column(
                        children: [
                          Stack(children: [
                            Container(
                              width: double.maxFinite,
                              padding: EdgeInsets.all(10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff87C440),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          10, 15, 0, 10),
                                      child: Image(
                                        width: 80,
                                        image: AssetImage(
                                            'assets/images/man1.png'),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.50,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(30),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Welcome'),
                                            SizedBox(height: 2),
                                            Text(
                                              '${session.userSession.loginData?.firstName} ${session.userSession.loginData?.lastName}',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0xffb4003c),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                padding: EdgeInsets.all(10.0),
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(30),
                                  ),
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
                                    Text(
                                      "Received Total Pending Amount:",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 5.0),
                                    Text(
                                      "Rs: ${double.tryParse(controller.totalAmountReceived.toString())?.ceil() ?? 0}",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xffb4003c),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Assigned Routes",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          controller.routes.isEmpty
                              ? _buildShimmerEffect()
                              : StreamBuilder<List>(
                                  stream: controller.routesController.stream,
                                  builder: (context, snapshot) {
                                    if (controller.isLoading) {
                                      return _buildShimmerEffect();
                                    } else if (snapshot.hasData &&
                                        snapshot.data!.isNotEmpty) {
                                      return ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return InkWell(
                                            onTap: () async {
                                              String? selectedDate =
                                                  await controller
                                                      .selectDate(context);
                                              if (selectedDate != null) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrderList(
                                                      route_id:
                                                          snapshot.data![index]
                                                              ['route_name'],
                                                      date: selectedDate,
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: snapshot.data![index]
                                                        ['route_name'] ==
                                                    null
                                                ? SizedBox()
                                                : Container(
                                                    width: double.maxFinite,
                                                    margin: EdgeInsets.only(
                                                      left: 10.0,
                                                      right: 10.0,
                                                      bottom: 10.0,
                                                    ),
                                                    padding:
                                                        EdgeInsets.all(20.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.5),
                                                          spreadRadius: 5,
                                                          blurRadius: 7,
                                                          offset: Offset(0, 3),
                                                        ),
                                                      ],
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(Icons
                                                                .inventory_2),
                                                            SizedBox(
                                                                width: 20.0),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                          [
                                                                          'route_name']
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Icon(Icons
                                                            .arrow_forward),
                                                      ],
                                                    ),
                                                  ),
                                          );
                                        },
                                      );
                                    } else {
                                      return Center(
                                          child: Text("No routes available"));
                                    }
                                  },
                                ),
                        ],
                      ),
                    ]),
                  ),
                ),
                drawer: DrawerNavigate(
                  names:
                      '${session.userSession.loginData?.firstName} ${session.userSession.loginData?.lastName}',
                  emails: controller.email,
                  dashboards: '/dp_dashboard',
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}

show_msg(status, message, context, {VoidCallback? onTap}) {
  return AwesomeDialog(
    context: context,
    dialogType: (status == 'error') ? DialogType.error : DialogType.success,
    animType: AnimType.rightSlide,
    title: (status == 'error') ? 'Error' : 'Success',
    desc: message,
    // btnCancelOnPress: () {},
    btnOkOnPress: onTap,
  )..show();
}

Widget _buildShimmerEffect() {
  return ListView.builder(
    shrinkWrap: true,
    physics: AlwaysScrollableScrollPhysics(),
    itemCount: 3,
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          padding: EdgeInsets.all(30.0),
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

// ignore_for_file: use_build_context_synchronously

import 'package:delivery_man/view/login_as/login_as.dart';
import 'package:flutter/material.dart';

import '../../../../controller/session_controller/session_controller.dart';

// ignore: must_be_immutable
class DrawerNavigate extends StatelessWidget {
  final String dashboards;
  String? emails;
  String? names;
  DrawerNavigate({Key? key, required this.dashboards, this.emails, this.names})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: Color(0xff87C440),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))),
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                              'assets/images/distrho_logo_green.png'),
                          fit: BoxFit.contain),
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: SizedBox(
                          width: 180,
                          child: Text(
                            '${names ?? ''}',
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 180.0,
                        child: Text(
                          '${emails ?? ' '}',
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // Container(
                      //   height: 30,
                      //   width: 80,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(5.0),
                      //     color: Colors.black,
                      //   ),
                      //   child: Center(
                      //     child: Text(
                      //       'Edit Profile',
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Color(0xff87C440),
                width: 1, //                   <--- border width here
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, dashboards);
              },
              child: ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: Center(
                    child: Text(
                  'Dashboard',
                )),
              ),
            ),
          ),
          // SizedBox(
          //   height: 6,
          // ),
          // Container(
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(6),
          //     border: Border.all(
          //       color: Color(0xff87C440),
          //       width: 1, //                   <--- border width here
          //     ),
          //   ),
          //   child: InkWell(
          //     onTap: () => {Navigator.pushNamed(context, '/tracking')},
          //     child: ListTile(
          //       leading: Icon(
          //         Icons.location_city,
          //         color: Colors.black,
          //       ),
          //       title: Center(child: Text('Tracking')),
          //     ),
          //   ),
          // ),

          Container(
            margin: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Color(0xff87C440),
                width: 1, //                   <--- border width here
              ),
            ),
            child: InkWell(
              onTap: () {
                final session = SessionController.instance;
                session.clearSession();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginAs(),
                  ),
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                ),
                title: Center(
                    child: Text(
                  'Logout',
                )),
              ),
            ),
          ),
        ]));
  }
}

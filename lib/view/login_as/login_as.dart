import 'package:flutter/material.dart';

import '../select_roles/dispatcher/login.dart';
import '../select_roles/order_picker/login_screen/login_screen.dart';

class LoginAs extends StatefulWidget {
  const LoginAs({super.key});

  @override
  State<LoginAs> createState() => _LoginAsState();
}

class _LoginAsState extends State<LoginAs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          Positioned(
            top: -50.0,
            right: 0.0,
            child: Container(
              width: 550,
              child: Image(
                image: AssetImage(
                  'assets/images/splash_up.png',
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -50.0,
            left: 0.0,
            child: Container(
              width: 550,
              child: Image(
                image: AssetImage(
                  'assets/images/splash_down.png',
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Image(
                  height: 200,
                  fit: BoxFit.contain,
                  image: AssetImage(
                    'assets/images/distrho_logo_green.png',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'Login As',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff87C440),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: BoxDecoration(
                    color: Color(0xff87C440),
                    borderRadius: BorderRadius.circular(3)),
                child: InkWell(
                  onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListTile(
                      leading: Image.asset("assets/images/order-picker.png"),
                      tileColor: Color(0xff87C440),
                      title: Center(
                          child: Text(
                        "Order Picker",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      )),
                      trailing: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                decoration: new BoxDecoration(
                    color: Color(0xff87C440),
                    borderRadius: BorderRadius.circular(3)),
                child: InkWell(
                  onTap: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Login(login_type: 'delivery_person'),
                      ),
                    )
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ListTile(
                      leading: Icon(
                        Icons.emoji_transportation,
                        color: Colors.white,
                        size: 50,
                      ),
                      tileColor: Color(0xff87C440),
                      title: Center(
                          child: Text("Dispatcher",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22))),
                      trailing: Icon(Icons.arrow_forward, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

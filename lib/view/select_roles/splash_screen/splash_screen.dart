import 'dart:async';
import 'package:delivery_man/controller/session_controller/session_controller.dart';
import 'package:flutter/material.dart';
import '../../login_as/login_as.dart';
import '../order_picker/home_screen_order_picker/home_screen_order_picker.dart';
import '../dispatcher/dp_dashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginStatusAndNavigate();
    });
  }

  Future<void> _checkLoginStatusAndNavigate() async {
    final session = SessionController.instance;
    await session.loadSession();

    print('Splash Screen login_id: ${session.userSession.loginData?.id}');
    session
        .loadSession()
        .then((response) => _timer = Timer(Duration(seconds: 3), () {
              if (session.userSession.loginData?.wareHouseId == '0' &&
                  session.userSession.loginData?.id != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreenOrderPicker()),
                );
              } else if (session.userSession.loginData?.wareHouseId == '5' &&
                  session.userSession.loginData?.id != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DpDashboard()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginAs()),
                );
              }
            }));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Image.asset("assets/images/distrho_logo_green1.png"),
        ),
      ),
    );
  }
}

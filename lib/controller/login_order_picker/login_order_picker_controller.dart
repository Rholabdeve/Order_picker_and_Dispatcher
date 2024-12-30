import 'package:delivery_man/controller/session_controller/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/order_picker_repo/order_picker_repository.dart';
import '../../repository/order_picker_repo/order_picker_repository_impl.dart';
import '../../view/select_roles/order_picker/home_screen_order_picker/home_screen_order_picker.dart';
import '../../widgets/flushbar.dart';

class Login_Picker_Controller extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final OrderPickerRepository _orderRepository = OrderPickerRepositoryImpl();
  String userName = '';
  String email_ = '';
  String company_ = '';

  String get username => userName;
  String get email => email_;
  String get company => company_;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool saving_ = false;
  var wearhouse_id;
  bool get saving => saving_;

  Future<void> login(BuildContext context) async {
    var res = await _orderRepository.login(
        usernameController.text, passwordController.text);
    FocusScope.of(context).unfocus();
    if (res['code_status'] == true) {
      wearhouse_id = res['login_data']['warehouse_id'];
      final session = SessionController.instance;
      session.setSession(
          res['login_data']['id'],
          res['login_data']['username'],
          res['login_data']['email'],
          '0',
          res['login_data']['first_name'],
          res['login_data']['last_name']);
      print('Response: $res');
      storeid();
      print("wearhouseid $wearhouse_id");

      SchedulerBinding.instance.addPostFrameCallback(
        (_) async {
          saving_ = false;
          notifyListeners();
          FlushBar.flushBarMessageGreen(
              message: 'Login Successfully', context: context);
        },
      );
      notifyListeners();
      print('Login Id: ${session.userSession.loginData?.id}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreenOrderPicker(),
        ),
      );
    } else {
      saving_ = false;
      notifyListeners();
      FlushBar.flushBarMessage(message: '${res['message']}', context: context);

      print('Login Status: ${res['code_status']}');
    }
  }

  Future storeid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('wearhpuse_id', wearhouse_id);
  }
}

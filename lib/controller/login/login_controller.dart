import 'dart:async';
import 'package:flutter/material.dart';

import '../../repository/dispatcher_repo/dispatcher_repository_impl.dart';
import '../../view/select_roles/dispatcher/component/snackbar.dart';
import '../../view/select_roles/dispatcher/dp_dashboard.dart';
import '../session_controller/session_controller.dart';

class LoginController extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final dispatcherRepo = DispatcherRepositoryImpl();
  bool show_Pass = false;
  bool saving = false;
  String? _orderBookerName;
  var res;

  bool get showPass => show_Pass;

  void togglePasswordVisibility() {
    show_Pass = !show_Pass;
    notifyListeners();
  }

  Future<void> login(String loginType, BuildContext context, String email,
      String password) async {
    if (formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      saving = true;
      notifyListeners();

      String _groupId = (loginType == 'delivery_person') ? '5' : '0';

      res = await dispatcherRepo.login(email, password, _groupId);
      print('wajih login Data: $res');
      final session = SessionController.instance;

      if (res['code_status'] == true) {
        session.setSession(
            res['login_data']['id'],
            res['login_data']['username'],
            res['login_data']['email'],
            '5',
            res['login_data']['first_name'],
            res['login_data']['last_name']);
        _orderBookerName = res['login_data']['first_name'];
        print('Login order booker name: $_orderBookerName');
        print('Warehouse ID ${res['login_data']['warehouse_id']}');

        saving = false;
        notifyListeners();
        showInSnackBar('Login Successfully', context: context);

        if (loginType == 'delivery_person') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DpDashboard()),
          );
        }
      } else {
        saving = false;
        print("object");
        showInSnackBar(res['message'] ?? 'Invalid Credentials',
            color: Colors.red, context: context);
        notifyListeners();
      }
    }
  }
}

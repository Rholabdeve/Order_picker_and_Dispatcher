import 'package:flutter/widgets.dart';

class ApiController with ChangeNotifier {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;

  bool password_Visible = false;

  bool get passwordVisible => password_Visible;

  void hide_UnHide() {
    password_Visible = !password_Visible;
    notifyListeners();
  }
}

import 'dart:async';

import 'package:delivery_man/controller/session_controller/session_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../repository/dispatcher_repo/dispatcher_repository_impl.dart';

class DpDashboardController extends ChangeNotifier {
  final dispatcherRepo = DispatcherRepositoryImpl();
  bool isLoading = false;
  bool saving = false;
  int status = 0;
  List routes = [];
  final StreamController<List> routesController = StreamController<List>();
  String totalAmountReceived = "";
  final TextEditingController _dateController = TextEditingController();
  double pending = 0;
  double delivered = 0;
  double cancel = 0;
  double total = 0;

  String? user_id;
  String? email;
  String? user_name;

  DpDashboardController() {
    _init();
  }

  Future<void> _init() async {
    await _getData();
    await refreshData();
  }

  Future<void> _getData() async {
    final session = SessionController.instance;
    user_id = session.userSession.loginData?.id;
    email = session.userSession.loginData?.email;
    user_name = session.userSession.loginData?.username;
    notifyListeners();
  }

  Future<void> refreshData() async {
    await _fetchRoutes();
    await _fetchData();
  }

  Future<void> _fetchRoutes() async {
    if (user_id == null) return;

    isLoading = true;
    notifyListeners();

    var res = await dispatcherRepo.getDmRoutes(user_id!);
    if (res['code_status'] == true) {
      routes = res['rows'];
      totalAmountReceived = res["rows"][0]["rider_balance"];

      print("Total Pending Amount: ${totalAmountReceived}");
      routesController.sink.add(routes);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> _fetchData() async {
    if (user_id == null) return;

    isLoading = true;
    notifyListeners();

    var now = DateTime.now();
    var formattedDate = DateFormat('yyyy-MM-dd').format(now);
    var res = await dispatcherRepo.getDpTargets(user_id!, formattedDate);

    if (res['code_status'] == true && res['rows'].isNotEmpty) {
      var targets = res['rows'][0];
      pending = double.parse(targets['pending']?.toString() ?? '0');
      delivered = double.parse(targets['delivered']?.toString() ?? '0');
      cancel = double.parse(targets['cancel']?.toString() ?? '0');
      total = double.parse(targets['total']?.toString() ?? '0');
    }

    isLoading = false;
    notifyListeners();
  }

  Stream<List> get routesStream => routesController.stream;

  @override
  void dispose() {
    routesController.close();
    super.dispose();
  }

  Future<String?> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      _dateController.text = formattedDate;
      notifyListeners();
      print(_dateController.text);
      print('Formatted Date: $formattedDate');

      return formattedDate;
    } else {
      return null;
    }
  }

  String firstName = '';
  String lastName = '';
  void store_first_last_name() async {
    final session = SessionController.instance;
    await session.loadSession();
    firstName = session.userSession.loginData!.firstName.toString();
    lastName = session.userSession.loginData!.lastName.toString();
    notifyListeners();
  }
}

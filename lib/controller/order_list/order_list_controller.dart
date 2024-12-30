import 'package:delivery_man/controller/session_controller/session_controller.dart';
import 'package:flutter/material.dart';

import '../../repository/dispatcher_repo/dispatcher_repository_impl.dart';

class OrdersController extends ChangeNotifier {
  List _orders = [];
  List _filteredOrders = [];
  String _searchQuery = '';
  bool _isLoading = false;
  String? user_id;
  String? _selectedPaymentStatus = 'All';
  List<String> get paymentStatusOptions => _paymentStatusOptions;
  final dispatcherRepo = DispatcherRepositoryImpl();

  final List<String> _paymentStatusOptions = [
    'All',
    'Paid',
    'Pending',
    'Partial',
    'Completed'
  ];

  bool get isLoading => _isLoading;
  List get filteredOrders => _filteredOrders;
  String get selectedPaymentStatus => _selectedPaymentStatus!;

  Future<void> fetchData(String userId, String date, String route) async {
    _isLoading = true;
    notifyListeners();

    var res = await dispatcherRepo.getDmOrders(userId, route, date);
    if (res['code_status'] == true) {
      _orders = res['rows'];
      _orders.sort((a, b) => b['sale_date'].compareTo(a['sale_date']));
      _filteredOrders = _orders;
      print(_orders);
      filterOrders();
    }

    _isLoading = false;
    notifyListeners();
  }

  static Future<String?> readUserId() async {
    final session = SessionController.instance;
    return session.userSession.loginData?.id;
  }

  void filterOrders() {
    _filteredOrders = _orders.where((order) {
      final referenceNo = order['reference_no'].toString().toLowerCase();
      final paymentStatus = order['payment_status'].toString().toLowerCase();

      bool matchesSearchQuery =
          referenceNo.contains(_searchQuery.toLowerCase());
      bool matchesPaymentStatus = _selectedPaymentStatus == 'All' ||
          paymentStatus == _selectedPaymentStatus!.toLowerCase();

      return matchesSearchQuery && matchesPaymentStatus;
    }).toList();
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    filterOrders();
  }

  void updateSelectedPaymentStatus(String? newValue) {
    _selectedPaymentStatus = newValue;
    filterOrders();
  }

  Future<void> refreshScreen(routeId, date) async {
    await fetchData(user_id!, routeId, date);
  }
}

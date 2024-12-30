import 'package:delivery_man/repository/dispatcher_repo/dispatcher_repository.dart';

import 'dispatcher_api.dart';

class DispatcherRepositoryImpl implements DispatcherRepository {
  final DispatcherApi _api = DispatcherApi();

  @override
  Future<dynamic> login(String username, String password, String groupId) {
    return _api.login(username, password, groupId);
  }

  @override
  Future<dynamic> getDueInvoice(String customerId) {
    return _api.getDueInvoice(customerId);
  }

  @override
  Future<dynamic> getDmRoutes(String userId) {
    return _api.getDmRoutes(userId);
  }

  @override
  Future<dynamic> getDmOrders(String userId, String date, String route) {
    return _api.getDmOrders(userId, date, route);
  }

  @override
  Future<dynamic> getSingleSale(String id) {
    return _api.getSingleSale(id);
  }

  @override
  Future<dynamic> dmUpdateStatus(String userId, String id, String status) {
    return _api.dmUpdateStatus(userId, id, status);
  }

  @override
  Future<dynamic> getDpTargets(String userId, String date) {
    return _api.getDpTargets(userId, date);
  }

  @override
  Future<dynamic> updateRemarks(String saleId, String remarks) {
    return _api.updateRemarks(saleId, remarks);
  }

  @override
  Future<dynamic> complaintType() {
    return _api.complaintType();
  }
}

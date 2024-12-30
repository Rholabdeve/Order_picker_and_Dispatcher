abstract class DispatcherRepository {
  Future<dynamic> login(String username, String password, String groupId);
  Future<dynamic> getDueInvoice(String customerId);
  Future<dynamic> getDmRoutes(String userId);
  Future<dynamic> getDmOrders(String userId, String date, String route);
  Future<dynamic> getSingleSale(String id);
  Future<dynamic> dmUpdateStatus(String userId, String id, String status);
  Future<dynamic> getDpTargets(String userId, String date);
  Future<dynamic> updateRemarks(String saleId, String remarks);
  Future<dynamic> complaintType();
}

abstract class OrderPickerRepository {
  Future<dynamic> getProducts(String subcategoryId, String categoryId);
  Future<dynamic> getCategories(String categoryId);
  Future<dynamic> getSales(String riderId);
  Future<dynamic> getSalesDetails(String riderId);
  Future<dynamic> orderStatus(String saleId, String status);
  Future<dynamic> addOrder(Map<String, String> orderData);
  Future<dynamic> orderHistory(String customerId);
  Future<dynamic> login(String email, String password);
  Future<dynamic> updateProfile(Map<String, String> profileData);
  Future<dynamic> createCustomer(Map<String, String> customerData);
  Future<dynamic> createSo(Map<String, String> orderData);
  Future<dynamic> orderTracking(String customerId);
  Future<dynamic> updateAddress(
      String customerId, String address, String mapLink);
  Future<dynamic> updatePassword(String email, String password);
  Future<dynamic> smsApi(Map<String, String> smsData);
  Future<dynamic> customersEmails();
  Future<dynamic> scanproduct(String barcodenum, String wearhouse_id);
  Future<dynamic> barcodeupdate(
      String barcodenum, String product_id, String user_id);
}

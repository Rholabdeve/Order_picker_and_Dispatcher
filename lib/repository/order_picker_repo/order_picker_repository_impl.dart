import 'package:delivery_man/repository/order_picker_repo/order_picker_repository.dart';
import 'package:delivery_man/repository/order_picker_repo/orders_picker_api.dart';

class OrderPickerRepositoryImpl implements OrderPickerRepository {
  final OrderPickerApi _api = OrderPickerApi();

  @override
  Future<dynamic> barcodeupdate(
    String barcodenum,
    String product_id,
    String user_id,
  ) {
    return _api.barcodeupdate(barcodenum, product_id, user_id);
  }

  @override
  Future<dynamic> scanproduct(String barcodenum, String wearhouse_id) {
    return _api.scanproduct(barcodenum, wearhouse_id);
  }

  @override
  Future<dynamic> getProducts(String subcategoryId, String categoryId) {
    return _api.getProducts(subcategoryId, categoryId);
  }

  @override
  Future<dynamic> getCategories(String categoryId) {
    return _api.getCategories(categoryId);
  }

  @override
  Future<dynamic> getSales(String riderId) {
    return _api.getSales(riderId);
  }

  @override
  Future<dynamic> getSalesDetails(String riderId) {
    return _api.getSalesDetails(riderId);
  }

  @override
  Future<dynamic> orderStatus(String saleId, String status) {
    return _api.orderStatus(saleId, status);
  }

  Future<dynamic> addOrder(Map<String, String> orderData) {
    return _api.addOrder(
      warehouseId: orderData['warehouse_id'] ?? '',
      poNumber: orderData['po_number'] ?? '',
      poDate: orderData['po_date'] ?? '',
      customerId: orderData['customer_id'] ?? '',
      supplierId: orderData['supplier_id'] ?? '',
      userId: orderData['user_id'] ?? '',
      items: orderData['items'] ?? '',
    );
  }

  @override
  Future<dynamic> orderHistory(String customerId) {
    return _api.orderHistory(customerId);
  }

  @override
  Future<dynamic> login(String email, String password) {
    return _api.login(email, password);
  }

  @override
  Future<dynamic> updateProfile(Map<String, String> profileData) {
    return _api.updateProfile(
      profileData['id'] ?? '',
      profileData['name'] ?? '',
      profileData['email'] ?? '',
      profileData['phone'] ?? '',
    );
  }

  @override
  Future<dynamic> createCustomer(Map<String, String> customerData) {
    return _api.createCustomer(
      name: customerData['name'] ?? '',
      email: customerData['email'] ?? '',
      phone: customerData['phone'] ?? '',
      password: customerData['password'] ?? '',
      cnic: customerData['cnic'] ?? '',
      address: customerData['address'] ?? '',
      lat: customerData['lat'] ?? '',
      long: customerData['long'] ?? '',
      shopType: customerData['shop_type'] ?? '',
    );
  }

  @override
  Future<dynamic> createSo(Map<String, String> orderData) {
    return _api.createSO(
      poNumber: orderData['po_number'] ?? '',
      supplierId: orderData['supplier_id'] ?? '',
      customerId: orderData['customer_id'] ?? '',
      items: orderData['items'] ?? '',
      paymentMethod: orderData['payment_method'] ?? '',
      deliveryCharge: orderData['delivery_charge'] ?? '',
    );
  }

  @override
  Future<dynamic> orderTracking(String customerId) {
    return _api.orderTracking(customerId);
  }

  @override
  Future<dynamic> updateAddress(
      String customerId, String address, String mapLink) {
    return _api.updateAddress(customerId, address, mapLink);
  }

  @override
  Future<dynamic> updatePassword(String email, String password) {
    return _api.updatePassword(email, password);
  }

  @override
  Future<dynamic> smsApi(Map<String, String> smsData) {
    return _api.smsApi(
      smsData['mobilenum'] ?? '',
      smsData['message'] ?? '',
      smsData['shortcode'] ?? '',
    );
  }

  @override
  Future<dynamic> customersEmails() {
    return _api.customersEmails();
  }
}

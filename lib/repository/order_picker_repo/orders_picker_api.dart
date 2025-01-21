import '../../data/network/network_api_services.dart';
import '../../services/global.dart';

class OrderPickerApi extends BaseApi {
  static var secret = globalKeys.secret_key;

  Map<String, dynamic> _createBody(Map<String, dynamic> additionalData) {
    final body = {
      "secret_key": secret,
    };
    body.addAll(additionalData);

    return body;
  }

  Future<dynamic> barcodeupdate(
      String barcodenum, String product_id, String user_id) async {
    var apiUrl = globalKeys.updatebarcode;
    final response = await postApi(
        apiUrl,
        _createBody({
          "barcode": barcodenum,
          "product_id": product_id,
          "user_id": user_id
        }));
    print(
        'Barcode_number $barcodenum, Wearhouse_id $product_id, user_id $user_id');
    return response;
  }

  Future<dynamic> scanproduct(String barcodenum, String wearhouse_id) async {
    var apiUrl = globalKeys.scanproduct;
    final response = await postApi(
        apiUrl,
        _createBody({
          "barcode": barcodenum,
          "warehouse_id": wearhouse_id,
        }));
    print('Barcode_number $barcodenum, Wearhouse_id $wearhouse_id');
    return response;
  }

  Future<dynamic> getProducts(String subcategoryId, String categoryId) async {
    var apiUrl = globalKeys.productList;
    final response = await postApi(
        apiUrl,
        _createBody({
          "category": categoryId,
          "sub_category": subcategoryId,
        }));
    print('Product List: Category $categoryId, Sub Category $subcategoryId');
    return response;
  }

  Future<dynamic> getCategories(String categoryId) async {
    var apiUrl = globalKeys.getCategories;
    final response = await postApi(
        apiUrl,
        _createBody({
          "parent_id": categoryId,
        }));
    print("Home Categories Data: $response");
    return response;
  }

  Future<dynamic> getSales(String riderId) async {
    var apiUrl = globalKeys.sales_picker;
    final response = await postApi(
        apiUrl,
        _createBody({
          "id": riderId,
        }));
    print("Home Sales Data: $response");
    return response;
  }

  Future<dynamic> getSalesDetails(String riderId) async {
    var apiUrl = globalKeys.order_picker_details;
    final response = await postApi(
        apiUrl,
        _createBody({
          "sale_id": riderId,
        }));
    print("Get Sale Detail: $response");
    return response;
  }

  Future<dynamic> orderStatus(String saleId, String status) async {
    var apiUrl = globalKeys.order_status;
    final response = await postApi(
        apiUrl,
        _createBody({
          "sale_id": saleId,
          "status": status,
        }));
    print("Order Status: $response");
    return response;
  }

  Future<dynamic> addOrder({
    required String warehouseId,
    required String poNumber,
    required String poDate,
    required String customerId,
    required String supplierId,
    required String userId,
    required String items,
  }) async {
    var apiUrl = globalKeys.createOrder;
    final response = await postApi(
        apiUrl,
        _createBody({
          "warehouse_id": warehouseId,
          "po_number": poNumber,
          "po_date": poDate,
          "customer_id": customerId,
          "supplier_id": supplierId,
          "user_id": userId,
          "items": items,
        }));
    print("Add Order Response: $response");
    return response;
  }

  Future<dynamic> orderHistory(String customerId) async {
    var apiUrl = globalKeys.orderHistory;
    final response = await postApi(
        apiUrl,
        _createBody({
          "customer_id": customerId,
        }));
    print("Order History: $response");
    return response;
  }

  Future<dynamic> login(String email, String password) async {
    var apiUrl = globalKeys.login;
    final response = await postApi(
        apiUrl,
        _createBody({
          "username": email,
          "password": password,
        }));
    return response;
  }

  Future<dynamic> updateProfile(
      String id, String name, String email, String phone) async {
    var apiUrl = globalKeys.update_profile;
    final response = await postApi(
        apiUrl,
        _createBody({
          "id": id,
          "name": name,
          "email": email,
          "phone": phone,
        }));
    print('Update Profile: $response');
    return response;
  }

  Future<dynamic> createCustomer({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String cnic,
    required String address,
    required String lat,
    required String long,
    required String shopType,
  }) async {
    var apiUrl = globalKeys.createCustomer;
    final response = await postApi(
        apiUrl,
        _createBody({
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
          "cnic": cnic,
          "address": address,
          "lati": lat,
          "long": long,
          "shop_type": shopType,
        }));
    return response;
  }

  Future<dynamic> createSO({
    required String poNumber,
    required String supplierId,
    required String customerId,
    required String items,
    required String paymentMethod,
    required String deliveryCharge,
  }) async {
    var apiUrl = globalKeys.createSo;
    final response = await postApi(
        apiUrl,
        _createBody({
          "po_number": poNumber,
          "supplier_id": supplierId,
          "customer_id": customerId,
          "items": items,
          "payment_method": paymentMethod,
          "delivery_charge": deliveryCharge,
        }));
    return response;
  }

  Future<dynamic> orderTracking(String customerId) async {
    var apiUrl = globalKeys.orderTracking;
    final response = await postApi(
        apiUrl,
        _createBody({
          "customer_id": customerId,
        }));
    print('Order Tracking Response: $response');
    return response;
  }

  Future<dynamic> updateAddress(
      String customerId, String address, String mapLink) async {
    var apiUrl = globalKeys.updateAddress;
    final response = await postApi(
        apiUrl,
        _createBody({
          "id": customerId,
          "address": address,
          "maplink": mapLink,
        }));
    print('Update Address Response: $response');
    return response;
  }

  Future<dynamic> updatePassword(String email, String password) async {
    var apiUrl = globalKeys.updatePassword;
    final response = await postApi(
        apiUrl,
        _createBody({
          "email": email,
          "password": password,
        }));
    return response;
  }

  Future<dynamic> smsApi(
      String mobileNum, String message, String shortCode) async {
    var apiUrl = globalKeys.sms_api;
    final response = await postApi(
        apiUrl,
        _createBody({
          "mobilenum": mobileNum,
          "message": message,
          "shortcode": shortCode,
        }));
    return response;
  }

  Future<dynamic> customersEmails() async {
    var apiUrl = globalKeys.customersEmails;
    final response = await postApi(apiUrl, _createBody({}));
    return response;
  }
}

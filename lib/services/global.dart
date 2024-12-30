import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';

class globalKeys {
  static var default_warehouse = '9';

  static var secret_key = FlutterConfig.get('SECRET_KEY');
  static var baseUrl = FlutterConfig.get('BASEURL');
  //
  static var productList = "${baseUrl}products/lists";
  static var scanproduct = "${baseUrl}OrderPicker/search_product";
  static var sms_api = "${baseUrl}Auth/smsAPI";
  static var order_status = "${baseUrl}OrderPicker/order_status";
  static var createSo = "${baseUrl}Autosalesorder/createso";
  static var getCategories = "${baseUrl}products/categories";
  static var createOrder = "${baseUrl}salesorders/create";
  static var orderHistory = "${baseUrl}orders/order_historyorah";
  static var orderTracking = "${baseUrl}orders/order_tracking";
  static var createCustomer = "${baseUrl}customers/create";
  static var updateAddress = "${baseUrl}customers/updateAddress";
  static var updatePassword = "${baseUrl}customers/updatepassword";
  static var customersEmails = "${baseUrl}customers/customerEmails";
  static var customersContact = "${baseUrl}customers/Customercontact";
  static var login = '${baseUrl}auth/login';
  static var update_profile = "${baseUrl}customers/updateprofile";
  static var sales_picker = "${baseUrl}OrderPicker/sales";
  static var order_picker_details = "${baseUrl}OrderPicker/detail";
  static var imageUrl = "https://orah.distrho.com/uploads/products/";
  static String? name;
  static String? street;
  static String? locality;
  static String? administrativeArea;
  static int medicineQuantity = 0;
  static double? latitude;
  static double? longitude;

  static TextEditingController addressController = TextEditingController();

  static final sliderImage = [
    'assets/images/slider/slider1.jpeg',
    'assets/images/slider/slider2.jpeg',
    'assets/images/slider/slider3.jpeg',
    'assets/images/slider/slider4.jpeg',
  ];

  //Dispatcher api end-points
  // static var base_URL = "https://rhotrack.rhocom360.com/api/mobileapp/";
  // static var base_URL = "https://rhotrack.rholabproducts.com/api/mobileapp/";
  // static var base_URL ="https://demo-rhotrack.rholabproducts.com/api/mobileapp/";
  // static var base_URL ="https://rholabproducts.com/rhocom_rhotrack/api/mobileapp/";
  // static var base_URL ="https://rholabproducts.com/rhocom_suppliers/api/mobileapp/";
  // static var base_URL = "https://rholab.distrho.com/api/mobileapp/";

  static var get_single_sale_api = baseUrl + 'sales/order';
  static var login_api = baseUrl + 'auth/login';
  static var get_due_invoice = baseUrl + 'sales/dueinvoices';
  static var dm_routes_list = baseUrl + 'assignorders/routes';
  static var dm_order_list = baseUrl + 'assignorders/orders';
  static var dm_update_status = baseUrl + 'assignorders/change_status';
  static var dm_summery = baseUrl + 'assignorders/summary_detail';
  static var updateRemarks = baseUrl + 'paymentcollections/updateRemarks';
  static var complaintOptions = baseUrl + 'Complains/get_complaints';
}

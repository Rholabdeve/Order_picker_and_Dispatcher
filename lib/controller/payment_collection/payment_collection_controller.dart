import 'dart:convert';
import 'dart:io';
import 'package:delivery_man/controller/session_controller/session_controller.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../model/complaint_model.dart';
import '../../repository/dispatcher_repo/dispatcher_repository_impl.dart';
import '../../view/select_roles/dispatcher/component/snackbar.dart';

import '../../view/select_roles/dispatcher/dp_dashboard.dart';

class PaymentController extends ChangeNotifier {
  final dispatcherRepo = DispatcherRepositoryImpl();

  File? image;
  String localPath = '';
  final _picker = ImagePicker();
  bool load = false;
  bool saving = false;
  List filter = [];
  List tempSearch = [];
  String? customer_id = '';
  String? retailer_id = '';
  String? created_by = '';
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  final TextEditingController invoiceController = TextEditingController();
  final TextEditingController chequeController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController partialMarks = TextEditingController();
  final TextEditingController balance_amount_controller =
      TextEditingController();
  final TextEditingController remarksController = TextEditingController();
  Map _order = {};

  Future<void> fetchData(String id, BuildContext context) async {
    try {
      print('ID $id');
      var res = await dispatcherRepo.getSingleSale(id);
      print('Order Details $res');
      if (res['code_status'] == true) {
        _order['data'] = res['order'];
        notifyListeners();
      } else {
        show_msg('error', res['message'], context);
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  List invoice = [];
  List get invoices => invoice;
  String selectedInvoice = '';
  String get selectedInvoices => selectedInvoice;

  List<String> priority = ['Cash', 'Online Transfer', 'Cash + Online'];

  List<ComplaintType> complaintTypes = [];

  var selected_Priority;
  get selectedPriority => selected_Priority;

  var selectedComplain;

  Future<void> fetchComplaintTypes() async {
    try {
      var response = await dispatcherRepo.complaintType();
      print('API Response: $response');

      if (response is List) {
        complaintTypes = response
            .map<ComplaintType>((item) {
              if (item is Map<String, dynamic> &&
                  item['id'] is int &&
                  item['complain_type'] is String) {
                return ComplaintType(
                  id: item['id'] as int,
                  complainType: item['complain_type'] as String,
                );
              }
              return ComplaintType(id: 0, complainType: '');
            })
            .cast<ComplaintType>()
            .toList();
        notifyListeners();
      } else {
        complaintTypes = [];
      }
    } catch (e) {
      print('Error fetching complaint types: $e');
      complaintTypes = [];
      notifyListeners();
    }
  }

  // ignore: unused_element
  Future<void> _fetchInvoice(customer_id) async {
    saving = true;
    notifyListeners();

    try {
      var res = await dispatcherRepo.getDueInvoice(customer_id.toString());
      print('Customer ID ${customer_id.toString()}');
      if (res['code_status'] == true) {
        saving = false;
        invoice = res['invoices'].toList();
        filter = res['invoices'].toList();
        notifyListeners();
      }
    } catch (e) {
      saving = false;
      print('Error fetching invoice: $e');
      notifyListeners();
    }
  }

  Future getImage() async {
    try {
      final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);

      if (pickedFile != null) {
        localPath = pickedFile.path;
        load = true;
      } else {
        localPath = "";
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    } finally {
      notifyListeners();
    }
  }

  Future sendImage(
      String apiUrl,
      String imagePath,
      String sale_id,
      String customer_id,
      String paid_by,
      String cheque_no,
      String amount,
      String created_by,
      String note,
      String,
      BuildContext context) async {
    try {
      saving = true;
      notifyListeners();

      var request = http.MultipartRequest("POST", Uri.parse(apiUrl));
      request.fields['secret_key'] = FlutterConfig.get('SECRET_KEY');
      request.fields['sale_id'] = sale_id.toString();
      request.fields['customer_id'] = customer_id.toString();
      request.fields['paid_by'] = paid_by.toString();
      request.fields['cheque_no'] = cheque_no.toString();
      request.fields['amount'] = amount.toString();
      request.fields['created_by'] = created_by.toString();
      request.fields['note'] = note.toString();
      request.fields['partialRemarks'] = partialMarks.text.toString();

      if (imagePath.isNotEmpty) {
        request.files
            .add(await http.MultipartFile.fromPath('attachment', imagePath));
      }

      var response = await request.send();
      var result = await response.stream.bytesToString();
      var res = jsonDecode(result);

      saving = false;
      notifyListeners();

      if (res['code_status']) {
        showInSnackBar('Payment Saved Successfully');
      } else {
        showInSnackBar(res['message'], color: Colors.red);
      }
    } catch (e) {
      saving = false;
      notifyListeners();
      print(e.toString());
      showInSnackBar('An error occurred. Please try again.', color: Colors.red);
    }
  }

  Future<void> updateStatus(String id, String user_id, String status) async {
    print('Update wajih');
    print(id);
    var res = await dispatcherRepo.dmUpdateStatus(user_id, id, status);
    print('Update Status $res');
    if (res['code_status'] == true) {
      print('Update Status Success');
      print(res);
      // await show_msg('success', res['message'], context);
    } else {
      print(res);
      // await show_msg('error', res['message'], context);
    }
  }

  @override
  void dispose() {
    dateController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void getData() async {
    final session = SessionController.instance;
    created_by = session.userSession.loginData?.id;
    // customer_id = prefs.getString('customer_visit_id');
    // retailer_id = prefs.getString('retailer_visit_id');
    notifyListeners();
  }

  Future<void> RemarksData(sale_id, remarks, context) async {
    var res = await dispatcherRepo.updateRemarks(sale_id, remarks);
    print('Update Status $res');
    if (res['code_status'] == true) {
      show_msg('success', res['message'], context);
    } else {
      show_msg('error', res['message'], context);
    }
  }
}

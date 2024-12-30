import 'package:delivery_man/services/global.dart';

import '../../data/exception/api_exceptions.dart';
import '../../data/network/network_api_services.dart';

class DispatcherApi extends BaseApi {
  Future<dynamic> login(
      String username, String password, String groupId) async {
    var secret = globalKeys.secret_key;
    var loginApi = globalKeys.login_api;
    try {
      return await postApi(loginApi, {
        "secret_key": secret,
        "username": username,
        "password": password,
        "group_id": groupId,
      });
    } catch (e) {
      throw ApiException('Failed to log in: $e');
    }
  }

  Future<dynamic> getDueInvoice(String customerId) async {
    var secret = globalKeys.secret_key;
    var apiUrl = globalKeys.get_due_invoice;
    try {
      return await postApi(apiUrl, {
        "secret_key": secret,
        "customer_id": customerId,
      });
    } catch (e) {
      throw ApiException('Failed to fetch due invoice: $e');
    }
  }

  Future<dynamic> getDmRoutes(String userId) async {
    var secret = globalKeys.secret_key;
    var apiUrl = globalKeys.dm_routes_list;
    try {
      return await postApi(apiUrl, {
        "secret_key": secret,
        "user_id": userId,
      });
    } catch (e) {
      throw ApiException('Failed to fetch routes: $e');
    }
  }

  Future<dynamic> getDmOrders(String userId, String date, String route) async {
    var secret = globalKeys.secret_key;
    var apiUrl = globalKeys.dm_order_list;
    try {
      return await postApi(apiUrl, {
        "secret_key": secret,
        "user_id": userId,
        "date": date,
        "route": route,
      });
    } catch (e) {
      throw ApiException('Failed to get Dm Orders: $e');
    }
  }

  Future<dynamic> getSingleSale(String id) async {
    var secret = globalKeys.secret_key;
    var apiUrl = globalKeys.get_single_sale_api;
    try {
      return await postApi(apiUrl, {
        "secret_key": secret,
        "id": id,
      });
    } catch (e) {
      throw ApiException('Failed to get single sale: $e');
    }
  }

  Future<dynamic> dmUpdateStatus(
      String userId, String id, String status) async {
    var secret = globalKeys.secret_key;
    var apiUrl = globalKeys.dm_update_status;
    try {
      return await postApi(apiUrl, {
        "secret_key": secret,
        "user_id": userId,
        "id": id,
        "status": status,
      });
    } catch (e) {
      throw ApiException('Failed to Update Status: $e');
    }
  }

  Future<dynamic> getDpTargets(String userId, String date) async {
    var secret = globalKeys.secret_key;
    var apiUrl = globalKeys.dm_summery;
    try {
      return await postApi(apiUrl, {
        "secret_key": secret,
        "user_id": userId,
        "date": date,
      });
    } catch (e) {
      throw ApiException('Failed to get DP targets: $e');
    }
  }

  Future<dynamic> updateRemarks(String saleId, String remarks) async {
    var secret = globalKeys.secret_key;
    var apiUrl = globalKeys.updateRemarks;
    try {
      return await postApi(apiUrl, {
        "secret_key": secret,
        "sale_id": saleId,
        "remarks": remarks,
      });
    } catch (e) {
      throw ApiException('Failed to update Remarks: $e');
    }
  }

  Future<dynamic> complaintType() async {
    var secret = globalKeys.secret_key;
    var apiUrl = globalKeys.complaintOptions;
    try {
      return await postApi(apiUrl, {
        "secret_key": secret,
      });
    } catch (e) {
      throw ApiException('Failed to get Complain Type: $e');
    }
  }
}

import 'package:delivery_man/controller/home_order_picker/home_order_picker_controller.dart';
import 'package:delivery_man/controller/order_detail_picker/order_detail_picker_controller.dart';
import 'package:delivery_man/controller/scanproduct/scanproduct_controller.dart';
import 'package:get_it/get_it.dart';
import '../controller/api_controller/controllers.dart';
import '../controller/login/login_controller.dart';
import '../controller/network_checker/check_connection_provider.dart';
import '../controller/dp_dashboard/dp_dashboard_controller.dart';
import '../controller/order_list/order_list_controller.dart';
import '../controller/payment_collection/payment_collection_controller.dart';
import '../controller/payment_dropdown/payment_dropdown_controller.dart';
import '../controller/view_order/view_order_controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  print("object1");
  sl.registerLazySingleton<CheckNetworkProvider>(() => CheckNetworkProvider());
  sl.registerLazySingleton<DpDashboardController>(
      () => DpDashboardController());
  sl.registerLazySingleton<ApiController>(() => ApiController());
  sl.registerLazySingleton<LoginController>(() => LoginController());
  sl.registerLazySingleton<OrdersController>(() => OrdersController());
  sl.registerLazySingleton<ViewOrderController>(() => ViewOrderController());
  sl.registerLazySingleton<PaymentDropdownController>(
      () => PaymentDropdownController());
  sl.registerLazySingleton<PaymentController>(() => PaymentController());
  sl.registerLazySingleton<HomeOrderPickerController>(
      () => HomeOrderPickerController());
  sl.registerLazySingleton<OrderDetailsProvider>(() => OrderDetailsProvider());
  sl.registerLazySingleton<ScanProductController>(
      () => ScanProductController());
}

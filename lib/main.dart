import 'dart:io';
import 'package:delivery_man/controller/home_order_picker/home_order_picker_controller.dart';
import 'package:delivery_man/controller/order_detail_picker/order_detail_picker_controller.dart';
import 'package:delivery_man/controller/scanproduct/scanproduct_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter_config/flutter_config.dart';
import 'controller/api_controller/controllers.dart';
import 'controller/dp_dashboard/dp_dashboard_controller.dart';
import 'controller/login/login_controller.dart';
import 'controller/network_checker/check_connection_provider.dart';
import 'controller/order_list/order_list_controller.dart';
import 'controller/payment_collection/payment_collection_controller.dart';
import 'controller/payment_dropdown/payment_dropdown_controller.dart';
import 'controller/view_order/view_order_controller.dart';
import 'view/select_roles/dispatcher/dp_dashboard.dart';
import 'view/select_roles/splash_screen/splash_screen.dart';
import 'view/select_roles/dispatcher/component/snackbar.dart';
import 'utils/di_container.dart' as di;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CheckNetworkProvider()),
        ChangeNotifierProvider(create: (_) => ApiController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => DpDashboardController()),
        ChangeNotifierProvider(create: (_) => OrdersController()),
        ChangeNotifierProvider(create: (_) => ViewOrderController()),
        ChangeNotifierProvider(create: (_) => PaymentDropdownController()),
        ChangeNotifierProvider(create: (_) => PaymentController()),
        ChangeNotifierProvider(create: (_) => HomeOrderPickerController()),
        ChangeNotifierProvider(create: (_) => OrderDetailsProvider()),
        ChangeNotifierProvider(create: (_) => ScanProductController()),
      ],
      child: Builder(
        builder: (context) {
          Provider.of<CheckNetworkProvider>(context, listen: false);

          MaterialColor buildMaterialColor(Color color) {
            List<double> strengths = <double>[.05];
            Map<int, Color> swatch = {};
            final int r = color.red, g = color.green, b = color.blue;
            for (int i = 1; i < 10; i++) {
              strengths.add(0.1 * i);
            }
            strengths.forEach((strength) {
              final double ds = 0.5 - strength;
              swatch[(strength * 1000).round()] = Color.fromRGBO(
                r + ((ds < 0 ? r : (255 - r)) * ds).round(),
                g + ((ds < 0 ? g : (255 - g)) * ds).round(),
                b + ((ds < 0 ? b : (255 - b)) * ds).round(),
                1,
              );
            });
            return MaterialColor(color.value, swatch);
          }

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Distrho Warehouse',
            scaffoldMessengerKey: snackbarKey,
            navigatorKey: navigatorKey,
            theme: ThemeData(
              useMaterial3: false,
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.light,
                  statusBarColor: Colors.black,
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              primarySwatch: buildMaterialColor(const Color(0xff87C440)),
              textTheme: const TextTheme(),
            ),
            routes: {
              '/dp_dashboard': (context) => const DpDashboard(),
            },
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

class NavUtil {
  static BuildContext? get context => navigatorKey.currentContext;
  static NavigatorState? get navigator => navigatorKey.currentState;
}

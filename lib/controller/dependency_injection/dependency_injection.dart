import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../network_checker/check_connection_provider.dart';

class DependencyInjection {
  static void init(BuildContext context) {
    Provider.of<CheckNetworkProvider>(context, listen: false);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peppex_delivery/constants/app_routes.dart';
import 'package:peppex_delivery/constants/app_theme.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:peppex_delivery/helpers/root.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('es_ES');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: Root(),
      getPages: AppRoutes.routes,
    );
  }
}

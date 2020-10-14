import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peppex_delivery/constants/app_routes.dart';
import 'package:peppex_delivery/constants/app_theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: "/",
      getPages: AppRoutes.routes,
    );
  }
}

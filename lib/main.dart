import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:peppex_delivery/constants/app_theme.dart';

//import 'package:peppex_delivery/ui/screens/home.dart';
//import 'package:peppex_delivery/ui/screens/login.dart';
import 'package:peppex_delivery/ui/screens/register.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Peppex Delivery',
    theme: appTheme(),
    debugShowCheckedModeBanner: false,
    home: Register(),
  ));
}

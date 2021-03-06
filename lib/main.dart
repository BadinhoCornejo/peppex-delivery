import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:peppex_delivery/controllers/controllers.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.put<AuthController>(AuthController());
  Get.put<CategoriesController>(CategoriesController());
  Get.put<OrderController>(OrderController());
  Get.put<CartController>(CartController());
  runApp(App());
}

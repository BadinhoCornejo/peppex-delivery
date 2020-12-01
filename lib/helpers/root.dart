import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:peppex_delivery/controllers/auth_controller.dart';
import 'package:peppex_delivery/ui/auth/auth.dart';
import 'package:peppex_delivery/ui/screens/home.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return (Get.find<AuthController>().user != null) ? Home() : Login();
    });
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peppex_delivery/controllers/auth_controller.dart';
import 'package:peppex_delivery/ui/components/categories.dart';
import 'package:peppex_delivery/ui/components/products.dart';
import 'package:peppex_delivery/ui/components/top_app_bar.dart';

//import 'package:peppex_delivery/controllers/counter_controller.dart';

class Home extends StatelessWidget {
  //final CounterController c = Get.put(CounterController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      appBar: TopAppBar(appBarText: 'Menú'),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Categories(),
            Expanded(
              child: ProductsContainer()
            )
          ],
        ),
      ),
    ),
  );
}

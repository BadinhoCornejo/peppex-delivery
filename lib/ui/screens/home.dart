import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peppex_delivery/controllers/auth_controller.dart';

import 'package:peppex_delivery/controllers/counter_controller.dart';

class Home extends StatelessWidget {
  final CounterController c = Get.put(CounterController());
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Obx(() => Text('Esto es Peppex')),
            bottomOpacity: 0.0,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Obx(() => Text('Clicks: ${c.count}')),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              authController.signOut();
            },
            backgroundColor: Theme.of(context).buttonColor,
          ),
        ),
      );
}

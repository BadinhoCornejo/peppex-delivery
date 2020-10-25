import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peppex_delivery/controllers/controllers.dart';

class Home extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Esto es Peppex'),
            bottomOpacity: 0.0,
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: Text('Hola!'),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:peppex_delivery/controllers/controllers.dart';
import 'package:peppex_delivery/helpers/helpers.dart';
import 'package:peppex_delivery/ui/components/components.dart';
import 'package:peppex_delivery/ui/components/input_field_generic.dart';
import 'package:peppex_delivery/ui/components/myorder_map.dart';
import 'package:peppex_delivery/ui/components/top_app_bar.dart';

class Checkout extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final OrderController orderController = OrderController.to;
  final CartController cartController = CartController.to;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dniController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: TopAppBar(
          appBarText: 'Pagar pedido',
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      child: InputFieldGeneric(
                        validator: Validator().name,
                        controller: nameController,
                        context: context,
                        textHint: 'Nombres y apellidos',
                        hasRadius: false,
                        onChanged: (value) => null,
                        onSaved: (value) => nameController.text = value,
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      child: InputFieldGeneric(
                        validator: Validator().dni,
                        controller: dniController,
                        context: context,
                        textHint: 'Número de DNI',
                        hasRadius: false,
                        onChanged: (value) => null,
                        onSaved: (value) => dniController.text = value,
                      ),
                    ),
                    Divider(),
                    Container(
                      padding: EdgeInsets.only(left: 8),
                      child: InputFieldGeneric(
                        validator: Validator().notEmpty,
                        controller: addressController,
                        context: context,
                        textHint: 'Dirección de entrega',
                        hasRadius: false,
                        onChanged: (value) => null,
                        onSaved: (value) => addressController.text = value,
                      ),
                    ),
                    Divider(),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 250,
                    child: MainButton(
                      buttonText: 'Completar pedido',
                      function: null,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          SystemChannels.textInput.invokeMethod(
                              'TextInput.hide'); //to hide the keyboard - if any
                          String userUid =
                              authController.userSnapshot.value.uid;
                          DocumentReference userDoc =
                              _db.collection('users').doc(userUid);
                          num amount =
                              await orderController.calcAmount(userDoc);
                          bool res = await orderController.newOrder(
                              userDoc,
                              nameController.text,
                              dniController.text,
                              addressController.text,
                              amount);
                          print(res);
                          if (res) {
                            cartController.cleanCart(userDoc);
                            Get.snackbar(
                              '¡Tu orden fue generada!',
                              'A continuación, verás el recorrido de tu pedido',
                              icon: Icon(
                                Icons.check_circle_outline,
                                color: Colors.green,
                              ),
                              shouldIconPulse: true,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 10),
                              backgroundColor: Theme.of(context).primaryColor,
                              colorText: Colors.white,
                            );
                            Get.offAll(MyOrderMap());
                          } else {
                            Get.snackbar(
                              'No se pudo generar la orden',
                              'Por favor, completar todos los campos.',
                              icon: Icon(Icons.error_outline),
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 10),
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

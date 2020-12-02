import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:peppex_delivery/controllers/controllers.dart';
import 'package:peppex_delivery/helpers/helpers.dart';
import 'package:peppex_delivery/ui/components/components.dart';
import 'package:peppex_delivery/ui/components/input_field_generic.dart';
import 'package:peppex_delivery/ui/components/top_app_bar.dart';
import 'package:peppex_delivery/ui/screens/map.dart';

class Checkout extends StatelessWidget {
  final OrderController orderController = OrderController.to;
  final CartController cartController = CartController.to;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
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
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        child: InputFieldGeneric(
                          keyboardType: TextInputType.name,
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
                          keyboardType: TextInputType.number,
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
                          keyboardType: TextInputType.phone,
                          validator: Validator().phone,
                          controller: phoneController,
                          context: context,
                          textHint: 'Número de teléfono',
                          hasRadius: false,
                          onChanged: (value) => null,
                          onSaved: (value) => phoneController.text = value,
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        child: InputFieldGeneric(
                          keyboardType: TextInputType.emailAddress,
                          validator: Validator().email,
                          controller: orderController.emailController,
                          context: context,
                          textHint: 'Correo electrónico',
                          hasRadius: false,
                          onChanged: (value) => null,
                          onSaved: (value) =>
                              orderController.emailController.text = value,
                        ),
                      ),
                      Divider(),
                      Container(
                        padding: EdgeInsets.only(left: 8),
                        child: InputFieldGeneric(
                          keyboardType: TextInputType.number,
                          validator: Validator().notEmpty,
                          controller: orderController.cardController,
                          context: context,
                          textHint: 'Número de tarjeta',
                          hasRadius: false,
                          onChanged: (value) => null,
                          onSaved: (value) =>
                              orderController.cardController.text = value,
                        ),
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 8),
                              child: InputFieldGeneric(
                                keyboardType: TextInputType.number,
                                validator: Validator().notEmpty,
                                controller:
                                    orderController.expirationMonthController,
                                context: context,
                                textHint: 'MM',
                                hasRadius: false,
                                onChanged: (value) => null,
                                onSaved: (value) => orderController
                                    .expirationMonthController.text = value,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 8),
                              child: InputFieldGeneric(
                                keyboardType: TextInputType.number,
                                validator: Validator().notEmpty,
                                controller:
                                    orderController.expirationYearController,
                                context: context,
                                textHint: 'YY',
                                hasRadius: false,
                                onChanged: (value) => null,
                                onSaved: (value) => orderController
                                    .expirationYearController.text = value,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 8),
                              child: InputFieldGeneric(
                                keyboardType: TextInputType.number,
                                validator: Validator().notEmpty,
                                controller: orderController.cvvController,
                                context: context,
                                textHint: 'CVV',
                                hasRadius: false,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                    orderController.cvvController.text = value,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 8),
                              child: InputFieldGeneric(
                                keyboardType: TextInputType.streetAddress,
                                validator: Validator().notEmpty,
                                controller: addressController,
                                context: context,
                                textHint: 'Dirección de entrega',
                                hasRadius: false,
                                onChanged: (value) => null,
                                onSaved: (value) =>
                                    addressController.text = value,
                              ),
                            ),
                          ),
                          Container(
                            width: 120,
                            padding: EdgeInsets.only(right: 16),
                            alignment: Alignment.centerRight,
                            child: Text('Trujillo, Perú'),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
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
                          String userUid = _auth.currentUser.uid;
                          DocumentReference userDoc =
                              _db.collection('users').doc(userUid);
                          num amount =
                              await orderController.calcAmount(userDoc);
                          bool res = await orderController.newOrder(
                              userDoc,
                              nameController.text,
                              dniController.text,
                              phoneController.text,
                              addressController.text,
                              amount);
                          print('ORDER --> $res');
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
                            Get.offAll(MapPage());
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

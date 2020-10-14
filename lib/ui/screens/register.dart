import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peppex_delivery/helpers/helpers.dart';
import 'package:peppex_delivery/ui/components/components.dart';
import 'package:peppex_delivery/ui/screens/screens.dart';
import 'package:peppex_delivery/controllers/controllers.dart';

import 'package:get/get.dart';

import '../../constants/peppex_icons.dart';

class Register extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.3), BlendMode.dstATop),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 44),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text('Ingresa tus datos',
                          style: Theme.of(context).textTheme.headline3),
                    ),
                  ),
                  Container(
                    height: 500,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(53, 15, 53, 13),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              top: 55.0,
                              child: Form(
                                key: _formKey,
                                child: Container(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 80),
                                      InputField(
                                        context: context,
                                        textHint: 'Nombres y apellidos',
                                        iconData: Peppex.bytesize_user,
                                        isPassword: false,
                                        hasRadius: false,
                                        controller:
                                            authController.nameController,
                                        validator: Validator().name,
                                        onChanged: (value) => null,
                                        onSaved: (value) => authController
                                            .nameController.text = value,
                                      ),
                                      InputField(
                                        context: context,
                                        textHint: 'Correo electrónico',
                                        iconData: Peppex.carbon_email,
                                        isPassword: false,
                                        hasRadius: false,
                                        controller:
                                            authController.emailController,
                                        validator: Validator().email,
                                        onChanged: (value) => null,
                                        onSaved: (value) => authController
                                            .emailController.text = value,
                                      ),
                                      InputField(
                                        context: context,
                                        textHint: 'Contraseña',
                                        iconData: Peppex.bi_lock_fill,
                                        isPassword: true,
                                        hasRadius: false,
                                        controller:
                                            authController.passwordController,
                                        validator: Validator().password,
                                        onChanged: (value) => null,
                                        onSaved: (value) => authController
                                            .passwordController.text = value,
                                      ),
                                      // InputField(
                                      //   context: context,
                                      //   textHint: 'Confirmar contrasñea',
                                      //   iconData: Peppex.bi_lock_fill,
                                      //   isPassword: true,
                                      //   hasRadius: false,
                                      // ),
                                      SizedBox(height: 22),
                                      SizedBox(
                                          child: MainButton(
                                            buttonText: 'Registrarse',
                                            function: null,
                                            onPressed: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                SystemChannels.textInput
                                                    .invokeMethod(
                                                        'TextInput.hide'); //to hide the keyboard - if any
                                                authController
                                                    .registerWithEmailAndPassword(
                                                        context);
                                              }
                                            },
                                          ),
                                          width: 150)
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).primaryColor,
                                radius: 45.0,
                                child: Icon(Peppex.bytesize_user,
                                    size: 40, color: Colors.white),
                              ),
                            )
                          ],
                        )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: TextButton.icon(
                          onPressed: () => Get.to(Login()),
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          label: Text('Regresar al login',
                              style: Theme.of(context).textTheme.subtitle2)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

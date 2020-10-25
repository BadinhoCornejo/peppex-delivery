import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peppex_delivery/controllers/controllers.dart';
import 'package:peppex_delivery/ui/components/components.dart';
import 'register.dart';

import 'package:get/get.dart';

import 'package:peppex_delivery/helpers/helpers.dart';
import '../../constants/peppex_icons.dart';

class Login extends StatelessWidget {
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
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                  child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Peppex.whh_foodtray,
                            color: Colors.white, size: 45),
                        SizedBox(height: 7.5),
                        Text('Peppex',
                            style: Theme.of(context).textTheme.headline3),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(53, 15, 53, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        InputField(
                          context: context,
                          textHint: 'Correo electrónico',
                          iconData: Peppex.carbon_email,
                          isPassword: false,
                          hasRadius: true,
                          controller: authController.emailController,
                          validator: Validator().email,
                          onChanged: (value) => null,
                          onSaved: (value) =>
                              authController.emailController.text = value,
                        ),
                        SizedBox(height: 30),
                        InputField(
                          context: context,
                          textHint: 'Contraseña',
                          iconData: Peppex.bi_lock_fill,
                          isPassword: true,
                          hasRadius: true,
                          controller: authController.passwordController,
                          validator: Validator().password,
                          onChanged: (value) => null,
                          onSaved: (value) =>
                              authController.passwordController.text = value,
                        ),
                        SizedBox(height: 30),
                        MainButton(
                            buttonText: 'Ingresar',
                            function: null,
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                authController
                                    .signInWithEmailAndPassword(context);
                              }
                            }),
                        SizedBox(height: 14),
                        ElevatedButton.icon(
                          onPressed: () async {
                            authController.signInWithGoogle(context);
                          },
                          icon: Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Ingresar con Google',
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(253, 107, 96, 1),
                            ),
                          ),
                        ),
                        SizedBox(height: 18),
                        TextButton(
                          onPressed: () {},
                          child: Text('Ingresar como invitado',
                              style: Theme.of(context).textTheme.subtitle2),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.23,
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('¿No tienes cuenta?',
                              style: Theme.of(context).textTheme.subtitle2),
                          TextButton(
                            onPressed: () => Get.to(Register()),
                            child: Text('Regístrate',
                                style: Theme.of(context).textTheme.bodyText2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

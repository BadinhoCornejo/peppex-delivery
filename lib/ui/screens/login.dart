import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peppex_delivery/ui/components/input_field.dart';
import 'package:peppex_delivery/ui/components/main_button.dart';

import '../../constants/peppex_icons.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
              fit: BoxFit.fill)
            ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Peppex.whh_foodtray, color: Colors.white, size: 45),
                  SizedBox(height: 7.5),
                  Text('Peppex', style: Theme.of(context).textTheme.headline3)
                ],
              )
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(53, 15, 53, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputField(context: context, textHint: 'Correo electrónico', iconData: Peppex.carbon_email, isPassword: false, hasRadius: true),
                    SizedBox(height: 30),
                    InputField(context: context, textHint: 'Contraseña', iconData: Peppex.bi_lock_fill, isPassword: true, hasRadius: true),
                    SizedBox(height: 30),
                    MainButton(buttonText: 'Ingresar', function: null),
                    SizedBox(height: 14),
                    ElevatedButton.icon(
                      onPressed: null, 
                      icon: Icon(FontAwesomeIcons.google, color: Colors.white), 
                      label: Text('Ingresar con Google', style: Theme.of(context).textTheme.subtitle2), 
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(253, 107, 96, 1))
                      )
                    ),
                    SizedBox(height: 18),
                    TextButton(
                    onPressed: () { }, 
                    child: Text(
                      'Ingresar como invitado',
                      style: Theme.of(context).textTheme.subtitle2)
                  )],
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿No tienes cuenta?',
                    style: Theme.of(context).textTheme.subtitle2),
                  TextButton(
                    onPressed: () { }, 
                    child: Text(
                      'Regístrate',
                      style: Theme.of(context).textTheme.bodyText2)
                  )
                ],
              ),
            )
        ])
      ),
    );
  }
}
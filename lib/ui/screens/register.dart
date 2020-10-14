import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peppex_delivery/ui/components/input_field.dart';
import 'package:peppex_delivery/ui/components/main_button.dart';

import '../../constants/peppex_icons.dart';

class Register extends StatelessWidget {
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
              flex: 1,
              child: Align(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 44),
                  child: Text('Ingresa tus datos', style: Theme.of(context).textTheme.headline3),
                ),
                alignment: Alignment.bottomCenter,
              )
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(53, 15, 53, 13),
                child: Stack( 
                  children: [
                    Positioned.fill(
                      top: 55.0,
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(height: 80),
                            InputField(context: context, textHint: 'Nombres y apellidos', iconData: Peppex.bytesize_user, isPassword: false, hasRadius: false),
                            InputField(context: context, textHint: 'Correo electrónico', iconData: Peppex.carbon_email, isPassword: false, hasRadius: false),
                            InputField(context: context, textHint: 'Contraseña', iconData: Peppex.bi_lock_fill, isPassword: true, hasRadius: false),
                            InputField(context: context, textHint: 'Confirmar contrasñea', iconData: Peppex.bi_lock_fill, isPassword: true, hasRadius: false),
                            SizedBox(height: 22),
                            SizedBox(
                              child: MainButton(buttonText: 'Registrarse', function: null),
                              width: 150
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        )
                      )
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 55.0,
                        child: Icon(Peppex.bytesize_user, size: 55, color: Colors.white),
                      ),
                    )
                  ],
                )
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topCenter,
                child: TextButton.icon(
                  onPressed: () {}, 
                  icon: Icon(Icons.arrow_back, color: Colors.white), 
                  label: Text('Regresar al login', style: Theme.of(context).textTheme.subtitle2)
                ),
              ),
            )
          ])
        )
      );
  }
}
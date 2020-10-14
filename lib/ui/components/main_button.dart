import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {

  final Function function;
  final String buttonText;

   MainButton(
      {Key key,
      @required this.buttonText,
      @required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () { function(); }, child: Text(buttonText, style: TextStyle(color: Colors.black)));
  }
}
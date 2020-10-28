import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Function function;
  final String buttonText;
  final void Function() onPressed;

  MainButton({
    Key key,
    @required this.onPressed,
    @required this.buttonText,
    @required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Text(buttonText, style: TextStyle(color: Colors.black)));
  }
}

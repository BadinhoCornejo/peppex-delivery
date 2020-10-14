import 'package:flutter/material.dart';

import '../../constants/peppex_icons.dart';

class InputField extends StatefulWidget{

  final BuildContext context;
  final String textHint;
  final IconData iconData;
  final bool isPassword;
  final bool hasRadius;

    InputField(
      {Key key,
      @required this.context,
      @required this.textHint,
      @required this.iconData,
      @required this.isPassword,
      @required this.hasRadius})
      : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();

}

class _InputFieldState extends State<InputField> {

  bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.isPassword;
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.iconData, size: 20),
        hintText: widget.textHint,
        border: OutlineInputBorder(
          borderRadius: widget.hasRadius ? BorderRadius.circular(8) : BorderRadius.zero
        ),
        suffixIcon: widget.isPassword ? IconButton(
            icon: _obscureText ? Icon(Peppex.dashicons_visibility) : Icon(Peppex.dashicons_hidden_1), 
            onPressed: () { _toggle(); },
          ) : null
      ),
      obscureText: _obscureText,
    );
  }
}
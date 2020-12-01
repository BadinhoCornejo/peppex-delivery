import 'package:flutter/material.dart';

class InputFieldGeneric extends StatefulWidget {
  final BuildContext context;
  final String textHint;
  final bool hasRadius;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function(String) validator;
  final Function(String) onChanged;
  final Function(String) onSaved;

  InputFieldGeneric({
    Key key,
    @required this.validator,
    @required this.controller,
    @required this.keyboardType,
    @required this.context,
    @required this.textHint,
    @required this.hasRadius,
    this.onChanged,
    this.onSaved,
  }) : super(key: key);

  @override
  _InputFieldGenericState createState() => _InputFieldGenericState();
}

class _InputFieldGenericState extends State<InputFieldGeneric> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 8),
        hintText: widget.textHint,
        border: OutlineInputBorder(
          borderRadius:
              widget.hasRadius ? BorderRadius.circular(8) : BorderRadius.zero,
          borderSide: new BorderSide(
            color: Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: new BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(
            color: Colors.transparent,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: new BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: new BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

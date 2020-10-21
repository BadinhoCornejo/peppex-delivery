import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {

  final bool isActive;
  final String text;

  CategoryButton({Key key, this.isActive, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 15, 7, 15),
      child: ElevatedButton(
        onPressed: () {
          print('Height is ${context.size.height}');
          print('Width is ${context.size.width}');
          print('Test is ${this.text}');
        }, 
        child: Text(text, style: Theme.of(context).textTheme.headline4),
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all<Size>(Size(110, 40)),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(0)),
          backgroundColor: MaterialStateProperty.all<Color>(isActive? Theme.of(context).primaryColor : Color.fromRGBO(240, 240, 240, 1)),
          elevation: MaterialStateProperty.all<double>(0)
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

class ProductThumb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        // crossAxisCount is the number of columns
        crossAxisCount: 2,
        // This creates two columns with two items in each column
        children: List.generate(2, (index) {
          return Center(
            child: Container(
              color: index == 1? Colors.red : Colors.blue,
            ),
          );
        }),
      ) 
    );
  }
}
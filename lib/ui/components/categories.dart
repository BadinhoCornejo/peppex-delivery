import 'package:flutter/material.dart';
import 'package:peppex_delivery/models/category.model.dart';
import 'package:peppex_delivery/services/api.dart';
import 'package:peppex_delivery/ui/components/category.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Api.getCategories(),
      builder: (context, snapshot) {
        return Container(
          height: 54,
          child: ListView.builder(
            itemCount: snapshot.data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Category categoria = snapshot.data[index];
              return CategoryButton(isActive: false, text: categoria.categoryName);
            }
          ),
        );
      }
    );
  }
}
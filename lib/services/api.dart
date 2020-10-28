import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:peppex_delivery/models/category.model.dart';
import 'package:peppex_delivery/models/product.model.dart';


class Api {

  static Future<List<Category>> getCategories() async {
    List<Category> categories = new List<Category>();
    final response = await rootBundle.loadString('extras/categories.json');
    List<dynamic> data = jsonDecode(response);
    categories = data.map((i) => Category.fromJson(i)).toList();
    return categories;
  }

  static Future<List<Product>> getProducts() async {
    List<Product> products = new List<Product>();
    final response = await rootBundle.loadString('extras/products.json');
    List<dynamic> data = jsonDecode(response);
    products = data.map((i) => Product.fromJson(i)).toList();
    return products;
  }

}

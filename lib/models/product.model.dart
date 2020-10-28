import 'package:meta/meta.dart';

class Product {
  final String uid;
  final String name;
  final double price;
  final String imageUrl;
  final double rating;
  final int total;

  Product({
    @required this.uid,
    @required this.name,
    @required this.price,
    @required this.imageUrl,
    @required this.rating,
    @required this.total
  });
  
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      uid: json['uid'],
      name: json['categoryName'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      rating: json['rating'],
      total: json['total']
    );
  }

}
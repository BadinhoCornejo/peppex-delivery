import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String uid;
  String name;
  String imageUrl;
  num price;

  ProductModel({this.uid, this.name, this.imageUrl, this.price});

  factory ProductModel.fromMap(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data();

    return ProductModel(
      uid: documentSnapshot.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: data['price'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() =>
      {"uid": uid, "name": name, "imageUrl": imageUrl, "price": price};
}

import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String uid;
  String name;
  String imageUrl;
  num price;
  num status;

  ProductModel({this.uid, this.name, this.imageUrl, this.price, this.status});

  factory ProductModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data();

    return ProductModel(
      uid: documentSnapshot.id,
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: data['price'] ?? 0,
      status: data['status'] ?? 0,
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> data) {
    return ProductModel(
      uid: '',
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      price: data['price'] ?? 0,
      status: data['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "imageUrl": imageUrl,
        "price": price,
        "status": status,
      };
}

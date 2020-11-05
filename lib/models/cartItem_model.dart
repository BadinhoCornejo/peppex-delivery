import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peppex_delivery/models/models.dart';

class CartItemModel {
  String uid;
  ProductModel product;
  String productReference;
  num quantity;

  CartItemModel({this.uid, this.product, this.productReference, this.quantity});

  factory CartItemModel.fromMap(DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data();

    return CartItemModel(
      uid: documentSnapshot.id,
      product: ProductModel.fromMap(data['product']),
      productReference: data['productRef'] ?? '',
      quantity: data['quantity'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "quantity": quantity,
        "productRef": product.uid
      };
}

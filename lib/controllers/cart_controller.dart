import 'dart:async';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peppex_delivery/models/models.dart';

class CartController extends GetxController {
  static CartController to = Get.find();

  Stream<List<CartItemModel>> listCart(DocumentReference userDoc) {
    return userDoc.collection('cart').snapshots().map((QuerySnapshot query) =>
        query.docs.map((e) => CartItemModel.fromMap(e)).toList());
  }

  Future<bool> addProduct(
      DocumentReference userDoc, ProductModel product) async {
    bool productAdded = false;

    QuerySnapshot res = await userDoc
        .collection('cart')
        .where('productRef', isEqualTo: product.uid)
        .get();

    if (res.isNull && product.status == 1) {
      CartItemModel cartItem = new CartItemModel(
        uid: '',
        product: product,
        productReference: product.uid,
        quantity: 1,
      );

      this._newProduct(userDoc, cartItem);
      productAdded = true;
    } else if (product.status == 1) {
      CartItemModel cartItem = CartItemModel.fromMap(res.docs[0]);
      add(userDoc, cartItem);
      productAdded = true;
    } else {
      productAdded = false;
    }

    return productAdded;
  }

  void add(DocumentReference userDoc, CartItemModel cartItem) {
    cartItem.quantity += 1;
    this.updateCartItem(userDoc, cartItem);
  }

  void quit(DocumentReference userDoc, CartItemModel cartItem) {
    if (cartItem.quantity == 1) {
      userDoc.collection('cart').doc(cartItem.uid).delete();
    } else {
      cartItem.quantity -= 1;
      this.updateCartItem(userDoc, cartItem);
    }
  }

  void cleanCart(DocumentReference userDoc) {
    userDoc.collection('cart').snapshots().forEach((res) =>
        res.docs.forEach((e) => userDoc.collection('cart').doc(e.id).delete()));
  }

  void updateCartItem(DocumentReference userDoc, CartItemModel cartItem) {
    userDoc.collection('cart').doc(cartItem.uid).set(cartItem.toJson());
  }

  void _newProduct(DocumentReference userDoc, CartItemModel cartItem) async {
    userDoc.collection('cart').add(cartItem.toJson());
  }
}

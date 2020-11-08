import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peppex_delivery/models/models.dart';
import 'auth_controller.dart';

class CartController extends GetxController {
  static CartController to = Get.find();
  final AuthController _authController = AuthController.to;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DocumentReference userDoc;
  Rx<User> userSnapshot = Rx<User>();

  @override
  void onInit() async {
    userSnapshot.value = await _authController.getUser;
    userDoc = _db.collection('users').doc(userSnapshot.value.uid);
  }

  Stream<List<CartItemModel>> listCart() {
    return userDoc.collection('cart').snapshots().map((QuerySnapshot query) =>
        query.docs.map((e) => CartItemModel.fromMap(e)).toList());
  }

  Future<bool> addProduct(ProductModel product) async {
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

      this._newProduct(cartItem);
      productAdded = true;
    } else if (product.status == 1) {
      CartItemModel cartItem = CartItemModel.fromMap(res.docs[0]);
      add(cartItem);
      productAdded = true;
    } else {
      productAdded = false;
    }

    return productAdded;
  }

  void add(CartItemModel cartItem) {
    cartItem.quantity += 1;
    this.updateCartItem(cartItem);
  }

  void quit(CartItemModel cartItem) {
    if (cartItem.quantity == 1) {
      userDoc.collection('cart').doc(cartItem.uid).delete();
    } else {
      cartItem.quantity -= 1;
      this.updateCartItem(cartItem);
    }
  }

  void cleanCart() {
    userDoc.collection('cart').snapshots().forEach((res) =>
        res.docs.forEach((e) => userDoc.collection('cart').doc(e.id).delete()));
  }

  void _newProduct(CartItemModel cartItem) {
    userDoc.collection('cart').add(cartItem.toJson());
  }

  void updateCartItem(CartItemModel cartItem) {
    userDoc.collection('cart').doc(cartItem.uid).set(cartItem.toJson());
  }
}

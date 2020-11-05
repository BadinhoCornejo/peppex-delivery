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

  void addProduct(CartItemModel cartItem) {
    // TODO: Verificar si ya existe el producto comprobando el productRef
  }

  void newProduct(CartItemModel cartItem) {
    userDoc.collection('cart').add(cartItem.toJson());
  }

  void updateProduct(CartItemModel cartItem) {
    userDoc.collection('cart').doc(cartItem.uid).set(cartItem.toJson());
  }
}

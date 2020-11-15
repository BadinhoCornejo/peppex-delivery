import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peppex_delivery/models/models.dart';

class OrderController extends GetxController {
  static OrderController to = Get.find();

  Future<DocumentReference> newOrder(
      DocumentReference userDoc,
      String customerName,
      String customerDoc,
      String address,
      num amount) async {
    List<CartItemModel> cartItems = await getCartItems(userDoc);
    List<String> products = cartItems.map((e) => e.productReference).toList();

    OrderModel order = new OrderModel(
      uid: '',
      customerName: customerName,
      customerDoc: customerDoc,
      address: address,
      orderDate: new DateTime.now(),
      amount: amount,
      products: products,
    );

    return userDoc.collection('orders').add(order.toJson());
  }

  Future<num> calcAmount(DocumentReference userDoc) async {
    List<CartItemModel> cartItems = await getCartItems(userDoc);
    num amount = 0;

    cartItems.forEach((element) {
      amount = amount + (element.product.price * element.quantity);
    });

    return amount;
  }

  @visibleForTesting
  Future<List<CartItemModel>> getCartItems(DocumentReference userDoc) async {
    QuerySnapshot cart = await userDoc.collection('cart').get();
    return cart.docs.map((e) => CartItemModel.fromMap(e)).toList();
  }
}

import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peppex_delivery/models/models.dart';

class OrderController extends GetxController {
  static OrderController to = Get.find();

  Future<bool> newOrder(DocumentReference userDoc, String customerName,
      String customerDoc, String address, num amount) async {
    try {
      print(customerDoc + ' ' + address + ' ' + customerName);
      List<CartItemModel> cartItems = await getCartItems(userDoc);
      List<String> products = cartItems.map((e) => e.productReference).toList();

      if (_fieldsEmpty(customerName, customerDoc, address)) return false;

      if (!_isAmountValid(amount)) return false;

      OrderModel order = new OrderModel(
        uid: '',
        customerName: customerName,
        customerDoc: customerDoc,
        address: address,
        orderDate: new DateTime.now(),
        amount: amount,
        products: products,
      );

      await userDoc.collection('orders').add(order.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<num> calcAmount(DocumentReference userDoc) async {
    try {
      List<CartItemModel> cartItems = await getCartItems(userDoc);
      num amount = 0;

      cartItems.forEach((element) {
        if (!_isPriceValid(element.product.price)) return 0;

        if (!_isQuantityValid(element.quantity)) return 0;

        amount = amount + (element.product.price * element.quantity);
      });

      return amount;
    } catch (e) {
      throw (e);
    }
  }

  @visibleForTesting
  Future<List<CartItemModel>> getCartItems(DocumentReference userDoc) async {
    QuerySnapshot cart = await userDoc.collection('cart').get();
    return cart.docs.map((e) => CartItemModel.fromMap(e)).toList();
  }

  bool _isAmountValid(num amount) {
    return amount >= 25 && amount <= 125;
  }

  bool _fieldsEmpty(String customerName, String customerDoc, String address) {
    return customerName.length == 0 ||
        customerDoc.length == 0 ||
        address.length == 0;
  }

  bool _isPriceValid(num price) {
    return price >= 1;
  }

  bool _isQuantityValid(num quantity) {
    return quantity >= 1 && quantity <= 4;
  }
}

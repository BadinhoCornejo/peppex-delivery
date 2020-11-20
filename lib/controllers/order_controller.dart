import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peppex_delivery/models/models.dart';

class OrderController extends GetxController {
  static OrderController to = Get.find();

  Future<bool> newOrder(DocumentReference userDoc, String customerName,
      String customerDoc, String address, num amount) async {
    try {
      List<CartItemModel> cartItems = await getCartItems(userDoc);
      List<String> products = cartItems.map((e) => e.productReference).toList();

      if (_fieldsEmpty(customerName, customerDoc, address, products))
        throw new StateError('Campos incompletos');

      if (!_isAmountValid(amount)) throw new StateError('Monto no válido');

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
      throw new StateError(e.message);
    }
  }

  Future<num> calcAmount(DocumentReference userDoc) async {
    try {
      List<CartItemModel> cartItems = await getCartItems(userDoc);
      num amount = 0;

      cartItems.forEach((element) {
        if (!_isPriceValid(element.product.price))
          throw new StateError('El precio debe ser mayor o igual a 1');

        if (!_isQuantityValid(element.quantity))
          throw new StateError(
              'La cantidad no debe superar las 4 unidades o debe ser mayor o igual a 1');

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

  bool _fieldsEmpty(String customerName, String customerDoc, String address,
      List<String> products) {
    return customerName.length == 0 ||
        customerDoc.length == 0 ||
        address.length == 0 ||
        products.length == 0;
  }

  bool _isPriceValid(num price) {
    return price >= 1;
  }

  bool _isQuantityValid(num quantity) {
    return quantity >= 1 && quantity <= 4;
  }
}

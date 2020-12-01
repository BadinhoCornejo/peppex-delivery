import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peppex_delivery/models/models.dart';

class OrderController extends GetxController {
  static OrderController to = Get.find();

  Future<bool> newOrder(
      DocumentReference userDoc,
      String customerName,
      String customerDoc,
      String customerPhone,
      String address,
      num amount) async {
    try {
      List<CartItemModel> cartItems = await getCartItems(userDoc);
      List<String> products = cartItems.map((e) => e.productReference).toList();

      if (_isFieldsEmpty(customerName, customerDoc, customerPhone, address)) {
        Get.snackbar(
          'No se pudo generar la orden',
          'Por favor, completar todos los campos.',
          icon: Icon(Icons.error_outline),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      if (!_isAmountValid(amount)) {
        Get.snackbar(
          'No se pudo generar la orden',
          'Considere un monto entre S/ 25 y S/ 125.',
          icon: Icon(Icons.error_outline),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      var activeOrder = await getActiveOrder(userDoc);

      if (activeOrder != null) {
        Get.snackbar(
          'No se pudo generar la orden',
          'Al parecer ya has realizado un pedido.',
          icon: Icon(Icons.error_outline),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return false;
      }

      OrderModel order = new OrderModel(
        uid: '',
        customerName: customerName,
        customerDoc: customerDoc,
        customerPhone: customerPhone,
        active: 1,
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

  Future<OrderModel> getActiveOrder(DocumentReference userDoc) async {
    QuerySnapshot res =
        await userDoc.collection('orders').where('active', isEqualTo: 1).get();

    if (res.docs.length == 0) return null;

    return new OrderModel.fromMap(res.docs[0]);
  }

  Future<OrderModel> getDeliveredOrder(DocumentReference userDoc) async {
    QuerySnapshot res =
        await userDoc.collection('orders').where('active', isEqualTo: 2).get();

    if (res.docs.length == 0) return null;

    return new OrderModel.fromMap(res.docs[0]);
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

  bool _isFieldsEmpty(String customerName, String customerDoc,
      String customerPhone, String address) {
    return customerName.length == 0 ||
        customerDoc.length == 0 ||
        customerPhone.length == 0 ||
        address.length == 0;
  }

  bool _isPriceValid(num price) {
    return price >= 1;
  }

  bool _isQuantityValid(num quantity) {
    return quantity >= 1 && quantity <= 4;
  }
}

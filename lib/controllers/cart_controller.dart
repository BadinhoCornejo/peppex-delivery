import 'package:flutter/material.dart';
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

  addProduct({
    DocumentReference userDoc,
    ProductModel product,
    BuildContext context,
  }) async {
    try {
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

        await this.newProduct(userDoc, cartItem);
        Get.snackbar(
          '¡Producto agregado al carrito!',
          'Clic aquí para ver su carrito',
          icon: Icon(Icons.check_circle),
          shouldIconPulse: true,
          onTap: (_) {
            // Get.to(Cart());
          },
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Theme.of(context).primaryColor,
          colorText: Colors.white,
        );
      } else if (product.status == 1) {
        CartItemModel cartItem = CartItemModel.fromMap(res.docs[0]);
        add(userDoc, cartItem);
        Get.snackbar(
          '¡Te gusta mucho este producto!',
          'Clic aquí para ver su carrito',
          icon: Icon(
            Icons.local_fire_department,
            color: Colors.redAccent,
          ),
          shouldIconPulse: true,
          onTap: (_) {
            // Get.to(Cart());
          },
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Theme.of(context).primaryColor,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Lo sentimos. Este producto no está dispnible',
          'Aún tenemos preparados deliciosos platillos :)',
          icon: Icon(Icons.info_outline),
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Colors.lightBlue,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        '¡Ups! Hubo un error al agregar este producto',
        'Por favor, intente nuevamente.',
        icon: Icon(Icons.error_outline),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 10),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  add(DocumentReference userDoc, CartItemModel cartItem) async {
    try {
      cartItem.quantity += 1;
      await this._updateCartItem(userDoc, cartItem);
    } catch (e) {
      Get.snackbar(
        '¡Ups! Hubo un error al agregar este producto',
        'Por favor, intente nuevamente.',
        icon: Icon(Icons.error_outline),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 10),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  quit(DocumentReference userDoc, CartItemModel cartItem) async {
    try {
      if (cartItem.quantity == 1) {
        await userDoc.collection('cart').doc(cartItem.uid).delete();
      } else {
        cartItem.quantity -= 1;
        await this._updateCartItem(userDoc, cartItem);
      }
    } catch (e) {
      Get.snackbar(
        '¡Ups! Hubo un error al quitar este producto',
        'Por favor, intente nuevamente.',
        icon: Icon(Icons.error_outline),
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 10),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  cleanCart(DocumentReference userDoc) {
    userDoc.collection('cart').snapshots().forEach((res) => res.docs.forEach(
        (e) async => await userDoc.collection('cart').doc(e.id).delete()));
  }

  _updateCartItem(DocumentReference userDoc, CartItemModel cartItem) async {
    await userDoc.collection('cart').doc(cartItem.uid).set(cartItem.toJson());
  }

  @visibleForTesting
  Future<DocumentReference> newProduct(
      DocumentReference userDoc, CartItemModel cartItem) async {
    return await userDoc.collection('cart').add(cartItem.toJson());
  }
}

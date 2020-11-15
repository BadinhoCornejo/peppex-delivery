import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:peppex_delivery/controllers/controllers.dart';
import 'package:peppex_delivery/models/cartItem_model.dart';
import 'package:peppex_delivery/models/models.dart';

main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  const userUid = 'LfWJvgJbC5T1Y4IqvPuFSCB7kLH3';

  group('Order process works correctly', () {
    test('Get cart products', () async {
      FirebaseFirestore db = FirebaseFirestore.instance;
      OrderController orderController = OrderController();
      DocumentReference userDoc = db.collection('users').doc(userUid);
      List<CartItemModel> cartItems = new List<CartItemModel>();
      ProductModel product = new ProductModel(
        uid: '',
        name: 'Carne',
        imageUrl:
            'https://cdn.colombia.com/gastronomia/2017/01/25/salchipapas-1703.webp',
        price: 25,
        status: 1,
      );

      cartItems.add(CartItemModel(
        product: product,
        uid: '56kwjfgMzGweb70BmQd2',
        productReference: 'bBowyy80zENt9v8rVR1j',
        quantity: 1,
      ));

      expect(await orderController.getCartItems(userDoc), cartItems);
    });
  });
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peppex_delivery/controllers/controllers.dart';
import 'package:peppex_delivery/models/models.dart';
import 'auth_controller.dart';

class OrderController extends GetxController {
  static OrderController to = Get.find();
  final AuthController _authController = AuthController.to;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DocumentReference userDoc;
  Rx<User> userSnapshot = Rx<User>();

  @override
  void onInit() async {
    userSnapshot.value = await _authController.getUser;
    userDoc = _db.collection('users').doc(userSnapshot.value.uid);
  }

  void newOrder(String customerName, String customerDoc, String address) async {
    QuerySnapshot cart = await userDoc.collection('cart').get();
    List<CartItemModel> cartItems =
        cart.docs.map((e) => CartItemModel.fromMap(e)).toList();
    List<String> products = cartItems.map((e) => e.productReference).toList();
    num amount = 0;

    cartItems.forEach((element) {
      amount = amount + (element.product.price * element.quantity);
    });

    OrderModel order = new OrderModel(
      uid: '',
      customerName: customerName,
      customerDoc: customerDoc,
      address: address,
      orderDate: new DateTime.now(),
      amount: amount,
      products: products,
    );

    userDoc.collection('orders').add(order.toJson());
  }
}

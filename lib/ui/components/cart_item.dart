import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peppex_delivery/controllers/auth_controller.dart';
import 'package:peppex_delivery/controllers/cart_controller.dart';
import 'package:peppex_delivery/models/models.dart';

class CartItem extends StatelessWidget {
  final CartController cartController = CartController.to;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final CartItemModel cartItem;

  CartItem({Key key, @required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 369,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: NetworkImage(cartItem.product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 160,
                padding: EdgeInsets.only(left: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cartItem.product.name,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'S/ ' +
                          (cartItem.product.price * cartItem.quantity)
                              .toStringAsFixed(2),
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 160,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          TextButton(
                            child: Icon(Icons.remove,
                                color: Colors.black, size: 16),
                            onPressed: () {
                              String userUid =
                                  _auth.currentUser.uid;
                              DocumentReference userDoc =
                                  _db.collection('users').doc(userUid);
                              cartController.quit(userDoc, cartItem);
                            },
                          ),
                          Text(cartItem.quantity.toString(),
                              style: TextStyle(color: Colors.black)),
                          TextButton(
                            child:
                                Icon(Icons.add, color: Colors.black, size: 16),
                            onPressed: () {
                              String userUid =
                                  _auth.currentUser.uid;
                              DocumentReference userDoc =
                                  _db.collection('users').doc(userUid);
                              cartController.add(userDoc, cartItem);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 19,
                      width: 19,
                      alignment: Alignment.center,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        padding: EdgeInsets.all(0),
                        color: Theme.of(context).primaryColor,
                        child: Icon(Icons.close, color: Colors.black, size: 16),
                        onPressed: () {
                          String userUid =
                              _auth.currentUser.uid;
                          DocumentReference userDoc =
                              _db.collection('users').doc(userUid);
                          cartController.remove(userDoc, cartItem);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

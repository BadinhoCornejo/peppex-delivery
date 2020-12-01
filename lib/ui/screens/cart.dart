import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:peppex_delivery/controllers/controllers.dart';
import 'package:peppex_delivery/helpers/helpers.dart';
import 'package:peppex_delivery/models/cartItem_model.dart';
import 'package:peppex_delivery/ui/components/bot_nav_bar.dart';
import 'package:peppex_delivery/ui/components/cart_item.dart';
import 'package:peppex_delivery/ui/components/components.dart';
import 'package:peppex_delivery/ui/components/scrollBehavior.dart';
import 'package:peppex_delivery/ui/components/top_app_bar.dart';
import 'package:peppex_delivery/ui/screens/checkout.dart';

class Cart extends StatelessWidget {
  final CartController cartController = CartController.to;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final OrderController orderController = OrderController.to;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: TopAppBar(appBarText: 'Carrito'),
          bottomNavigationBar: BottomNavBar(currentIndex: -1),
          body: Container(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 25,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Formatter.toShortDateWithDayAndMonth(DateTime.now()),
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: StreamBuilder<List<CartItemModel>>(
                        stream: cartController.listCart(
                          _db.collection('users').doc(_auth.currentUser.uid),
                        ),
                        builder: (context,
                            AsyncSnapshot<List<CartItemModel>> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data == null ||
                              snapshot.data.length == 0) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Center(
                                child: Text(
                                  'Aún no cuenta con productos en su carrito',
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            );
                          }
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: ScrollConfiguration(
                              behavior: MyBehavior(),
                              child: ListView(
                                children: List.generate(
                                  snapshot.data.length,
                                  (index) => _listCartItems(
                                    context,
                                    snapshot.data[index],
                                  ),
                                )
                                  ..add(
                                    Divider(),
                                  )
                                  ..add(
                                    SizedBox(
                                      height: 16,
                                    ),
                                  )
                                  ..add(
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total:',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        Text(
                                          'S/ ${cartController.calcAmount(snapshot.data).toStringAsFixed(2)}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                      ],
                                    ),
                                  )
                                  ..add(
                                    SizedBox(
                                      height: 24,
                                    ),
                                  ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: MainButton(
                      onPressed: () {
                        Get.to(Checkout());
                      },
                      buttonText: 'Pagar',
                      function: null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _listCartItems(BuildContext context, CartItemModel cartItem) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: CartItem(cartItem: cartItem),
    );
  }
}

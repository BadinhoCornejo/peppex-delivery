import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:peppex_delivery/controllers/controllers.dart';
import 'package:peppex_delivery/helpers/helpers.dart';
import 'package:peppex_delivery/models/cartItem_model.dart';
import 'package:peppex_delivery/ui/components/bot_nav_bar.dart';
import 'package:peppex_delivery/ui/components/cart_item.dart';
import 'package:peppex_delivery/ui/components/top_app_bar.dart';

class Cart extends StatelessWidget {

  final AuthController authController = Get.put(AuthController());
  final CartController cartController = Get.put(CartController());
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  
  @override
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(appBarText: 'Carrito'),
      bottomNavigationBar: BottomNavBar(currentIndex: -1),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Container(
              height: 25,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Formatter.toShortDateWithDayAndMonth(DateTime.now()), style: Theme.of(context).textTheme.headline6)
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height -
                  50 -
                  TopAppBar().preferredSize.height,
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Center(
                child: Obx(
                  () => StreamBuilder<List<CartItemModel>>(
                    stream: cartController.listCart(
                      _db.collection('users').doc(authController.userSnapshot.value.uid)
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Center(
                            child: Text(
                              'Aún no cuenta con productos en su carrito',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        );
                      }
                      return ListView(
                          children: List.generate(
                              snapshot.data.length,
                              (index) => _listCartItems(
                                  context, snapshot.data[index])));
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      )
    )
  );

  Widget _listCartItems(BuildContext context, CartItemModel cartItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: CartItem(cartItem: cartItem)
    );
  }

}
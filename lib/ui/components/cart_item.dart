import 'package:flutter/material.dart';
import 'package:peppex_delivery/models/models.dart';

class CartItem extends StatelessWidget {

  final CartItemModel cartItem;

  CartItem({Key key, @required this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: NetworkImage(cartItem.product.imageUrl), fit: BoxFit.cover)
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(cartItem.product.name, style: TextStyle(color: Colors.black)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Icon(Icons.remove, color: Colors.black, size: 16),
                  onPressed: () {}
                ),
                Text(cartItem.quantity.toString(), style: TextStyle(color: Colors.black)),
                TextButton(
                  child: Icon(Icons.add, color: Colors.black, size: 16),
                  onPressed: () {}
                ),
              ],
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('S/ ' + (cartItem.product.price * cartItem.quantity).toStringAsFixed(2), style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Container(
              height: 19,
              width: 19,
              alignment: Alignment.center,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)
                ),
                padding: EdgeInsets.all(0),
                color: Theme.of(context).primaryColor,
                child: Icon(Icons.close, color: Colors.black, size: 16),
                onPressed: () {}
              ),
            ),
          ],
        )
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:peppex_delivery/models/models.dart';

class ProductThumb extends StatelessWidget {

  final ProductModel product;

  const ProductThumb({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 112,
            width: 132,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover
              )
            ),
          ),
          SizedBox(height: 7),
          Container(
            width: 132,
            child: Text(product.name, style: Theme.of(context).textTheme.headline5),
          ),
          SizedBox(height: 7),
          Container(
            width: 132,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('S/ ' + product.price.toStringAsFixed(2), style: Theme.of(context).textTheme.headline4),
                Container(
                  height: 19,
                  width: 19,
                  alignment: Alignment.center,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    padding: EdgeInsets.all(0),
                    color: Theme.of(context).primaryColor,
                    child: Icon(Icons.add, color: Colors.black, size: 16),
                    onPressed: () {
                      print('Agregado al carrito el producto: ' + product.name);
                    }
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:peppex_delivery/constants/peppex_icons.dart';

class TopAppBar extends StatelessWidget with PreferredSizeWidget {
  final String appBarText;

  TopAppBar({Key key, this.appBarText}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(appBarText), bottomOpacity: 0.0, actions: [
      IconButton(
          icon: Icon(Peppex.eva_search_outline),
          onPressed: () {
            print(preferredSize.height);
          }),
      IconButton(
        icon: Icon(Peppex.ant_design_shopping_cart_outlined),
        onPressed: () {},
      ),
      IconButton(icon: Icon(Peppex.bytesize_filter), onPressed: () {})
    ]);
  }
}

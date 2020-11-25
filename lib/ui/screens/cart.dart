import 'package:flutter/material.dart';
import 'package:peppex_delivery/helpers/helpers.dart';
import 'package:peppex_delivery/ui/components/bot_nav_bar.dart';
import 'package:peppex_delivery/ui/components/top_app_bar.dart';

class Cart extends StatelessWidget {
  
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
          ],
        ),
      )
    )
  );
}
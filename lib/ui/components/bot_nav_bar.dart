import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peppex_delivery/constants/peppex_icons.dart';
import 'package:peppex_delivery/ui/screens/home.dart';


class BottomNavBar extends StatelessWidget {

  final int currentIndex;

  const BottomNavBar({
    Key key,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        currentIndex: currentIndex < 0 ? 0 : currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Peppex.ic_twotone_menu_book),
            label: 'Menú'
          ),
          BottomNavigationBarItem(
            icon: Icon(Peppex.whh_foodtray, size: 19),
            label: 'Mi pedido'
          ),
          BottomNavigationBarItem(
            icon: Icon(Peppex.bytesize_user),
            label: 'Mi cuenta'
          )
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: currentIndex < 0
            ? Colors.grey[600]
            : Theme.of(context).primaryColor,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.to(Home());
              break;
            case 1:
              break;
            case 2:
              break;
          }
        }
    );
  }


}
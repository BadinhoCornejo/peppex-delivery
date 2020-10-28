import 'package:get/get.dart';
import 'package:peppex_delivery/ui/screens/screens.dart';
import 'package:peppex_delivery/ui/auth/auth.dart';

class AppRoutes {
  AppRoutes._();
  static final routes = [
    GetPage(name: '/', page: () => Splash()),
    GetPage(name: '/login', page: () => Login()),
    GetPage(name: '/signup', page: () => Register()),
    GetPage(name: '/home', page: () => Home()),
  ];
}

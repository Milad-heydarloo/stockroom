import 'package:get/get.dart';
import 'package:project/BUY/1_2/sabte_sefaresh_one_two.dart';
import 'package:project/BUY/4/SupplierDetailsPage.dart';
import 'package:project/BuySell_GetX/Supiller/Location_GetX/supplier_list_screen.dart';
import 'package:project/Drawer/loginpage.dart';
import 'package:project/PagesOrderProduct/PagesOP.dart';
import 'package:project/main.dart';
import 'package:project/orderArchive.dart';

class Routes {
  static const String home = '/home';
  static const String Supplier = '/SupplierListScreen';
  static const String login = '/login';
  static const String splash = '/splash';
  static const String create_order = '/create_order';
  static const String op = '/op';
  static const String Ap = '/Ap';

  static List<GetPage> getPages = [

    GetPage(name: home, page: () => OrderListPage()),
    GetPage(name: Supplier, page: () => SupplierListScreens()),
    GetPage(name: login, page: () => LoginPage()),
    GetPage(name: splash, page: () => SplashPages()),
    GetPage(name: create_order, page: () => OrderBuyProductPage()),
    GetPage(name: op, page: () => OrderPage()),
    GetPage(name: Ap, page: () => OrderListPageArchive()),

  ];
}

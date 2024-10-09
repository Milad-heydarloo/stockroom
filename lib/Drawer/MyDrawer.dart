import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/BUY/1_2/sabte_sefaresh_one_two.dart';
import 'package:project/BuySell_GetX/Category/category_static.dart';
import 'package:project/Drawer/DrawerController.dart';
import 'package:project/Drawer/auth_controller.dart';
import 'package:project/Drawer/user_model.dart';


class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    final MyDrawerController drawerController = Get.find<MyDrawerController>();

    return FutureBuilder<User?>(
      future: authController.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data;

        if (user == null) {
          return Center(child: Text('No user data available'));
        }

        return Drawer(

          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text('${user.name} ${user.family}'),
                  accountEmail: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${user.email}'),
                      Text(
                        'نوع کاربری: ${user.availability.isNotEmpty ? user.availability.first : "نامشخص"}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  currentAccountPicture: null,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  margin: EdgeInsets.all(10),
                  otherAccountsPicturesSize: Size.square(75),
                  arrowColor: Colors.white,
                  otherAccountsPictures: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://saater.liara.run/api/files/_pb_users_auth_/${user.id}/${user.avatar}",
                      ),
                    ),
                  ],
                ),
                Obx(() => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: Icon(Icons.home),
                      title: Text("صفحه اصلی سفارشات در جریان"),
                      selected: drawerController.selectedIndex.value == 0,
                      selectedTileColor: Colors.blue.withOpacity(0.3),
                      onTap: () {
                        drawerController.setSelectedIndex(0);
                        Get.toNamed('/home');
                      },
                    ))),     Obx(() => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: Icon(Icons.supervisor_account),
                      title: Text( 'تامین کننده'),
                      selected: drawerController.selectedIndex.value == 1,
                      selectedTileColor: Colors.blue.withOpacity(0.3),
                      onTap: () {
                        drawerController.setSelectedIndex(1);
                        Get.toNamed('/SupplierListScreen');
                      },
                    ))), Obx(() => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: Icon(Icons.category_outlined),
                      title: Text( 'دسته بندی'),
                      selected: drawerController.selectedIndex.value == 2,
                      selectedTileColor: Colors.blue.withOpacity(0.3),
                      onTap: () {
                        drawerController.setSelectedIndex(2);
                       Get.to(() => general_category_page_static());

                        // Get.toNamed('/SupplierListScreen');
                      },
                    ))), Obx(() => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: Icon(Icons.shopping_basket_outlined),
                      title: Text( 'خرید کالا'),
                      selected: drawerController.selectedIndex.value == 3,
                      selectedTileColor: Colors.blue.withOpacity(0.3),
                      onTap: () {
                        drawerController.setSelectedIndex(3);

                       Get.to(() => OrderBuyProductPage());

                      // Get.toNamed('/SupplierListScreen');
                      },
                    ))),
                Obx(() => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: Icon(Icons.production_quantity_limits_outlined),
                      title: Text("کالای خرید شده"),
                      selected: drawerController.selectedIndex.value == 4,
                      selectedTileColor: Colors.blue.withOpacity(0.3),
                      onTap: () {
                        drawerController.setSelectedIndex(4);
                        Get.toNamed('/op');
                      },
                    ))),      Obx(() => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: Icon(Icons.send_and_archive),
                      title: Text("آرشیو سفارشات"),
                      selected: drawerController.selectedIndex.value == 5,
                      selectedTileColor: Colors.blue.withOpacity(0.3),
                      onTap: () {
                        drawerController.setSelectedIndex(5);
                        Get.toNamed('/Ap');
                      },
                    ))),
                Obx(() => Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("خروج از حساب کاربری"),
                      selected: drawerController.selectedIndex.value == 6,
                      selectedTileColor: Colors.blue.withOpacity(0.3),
                      onTap: () {
                        drawerController.setSelectedIndex(6);
                        authController.logout();
                      },
                    ))),
              ],
            ),
          ),
        );
      },
    );
  }
}
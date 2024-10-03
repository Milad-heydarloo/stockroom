import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:project/BUY/4/SupplierDetailsPage.dart';
import 'package:project/BUY/ControllerBuy/GeneralCategoryController.dart';
import 'package:project/Drawer/MyDrawer.dart';
import 'package:project/Drawer/auth_controller.dart';
import 'package:project/utiliti/double_extenstions.dart';

import 'package:searchfield/searchfield.dart';

// void main() {
//   // Get.put(AuthController(),
//   //     permanent: true); // Ensure AuthController is always in memory
//
//   Get.put(GeneralCategoryController()); // ثبت کنترلر
//   Get.put(SupplierDetailsController()); // ثبت کنترلر
//   runApp(
//     GetMaterialApp(
//
//       home: OrderBuyProductPage(),
//     ),
//   );
// }

class OrderBuyProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GeneralCategoryController controller =
        Get.find<GeneralCategoryController>();
    //controller.fetch_order_buy_product();
    return Scaffold(
      appBar: AppBar(
        title: Text('ثبت سفارش خرید'),
      //  automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     //  عملکرد بازگشت سفارشی
        //     //   Get.to(() => SupplierDetailsPage(orderId));
        //     Get.offAllNamed('/home');
        //   },
        // ),
      ),
      drawer: MyDrawer(),
      body: GetBuilder<GeneralCategoryController>(
        id: 'updatebuyproduct', // شناسه‌ای که در متد update استفاده می‌شود
        initState: (state) async => await controller.fetch_order_buy_product(),
        builder: (controller) {
          if (controller.orderBuyProducts.isEmpty) {
            return Center(
              child: Text('هیچ خریدی موجود نیست'),
            );
          }

          return ListView.builder(
            itemCount: controller.orderBuyProducts.length,
            itemBuilder: (context, index) {
              final order = controller.orderBuyProducts[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // نمایش اطلاعات supplier
                      IconButton(
                        onPressed: () {
                          if (order.buy_product.isEmpty) {
                            controller.delet_buy_order(order.id);
                          } else {
                            Get.snackbar(
                              'اول محصولات خرید را حذف کنید',
                              'شما مجاز به حذف سفارش نیستید.',
                              backgroundColor: Colors.red,
                            );
                          }
                        },
                        icon: Icon(Icons.delete),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Company Name: ${order.companyname}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Phone: ${order.phonenumber}'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Mobile: ${order.mobilenumber}'),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Address: ${order.address}'),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          'مبلغ فاکتور :   ${order.pricefactor.convertToPrice()}'),
                      SizedBox(height: 16.0),
                      // نمایش لیست buy_product به عنوان ExpansionTile
                      ...order.buy_product.map((product) {
                        return ExpansionTile(
                          title: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (product.snBuyProductLogin.isEmpty) {
                                    controller
                                        .deleteBuyId_BuyProdut_NameProduct_category(
                                      product.id,
                                      product.number,
                                      product.id,
                                    );
                                  } else {
                                    Get.snackbar(
                                      'اول تکلیف محصولات ورود به انبار را مشخص کنید',
                                      'شما مجاز به حذف سفارش نیستید.',
                                      backgroundColor: Colors.red,
                                    );
                                  }
                                },
                                icon: Icon(Icons.delete),
                              ),
                              Text(
                                '${product.title} نام محصول ',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          children: [
                            // نمایش آیتم‌های snBuyProductLogin زمانی که ExpansionTile باز می‌شود
                            for (var snLogin in product.snBuyProductLogin)
                              ListTile(
                                title: Text(snLogin.title),
                                subtitle: Text(snLogin.sn),
                              ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // عملکرد مورد نظر هنگام فشردن دکمه
          Get.to(() => SerchSupplier());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class SerchSupplier extends StatelessWidget {
  const SerchSupplier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GeneralCategoryController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('جستجوی فروشنده'),
      ),
      body: Column(
        children: [
          // ویجت برای بارگیری داده‌ها
          //  DataLoader(),
          // ویجت GetBuilder برای نمایش SearchField و جزئیات فروشنده
          GetBuilder<GeneralCategoryController>(
            id: '_suppliersall',
            initState: (state) async => await controller.fetchAllSuppliers(),

            builder: (controller) {
              return Column(
                children: [
                  FutureBuilder<List<String>>(
                    future: controller.fetchSuggestions(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text('فروشنده‌ای یافت نشد');
                      }
                      return SearchField<Object?>(
                        suggestions: snapshot.data!
                            .map((e) => SearchFieldListItem<Object?>(e))
                            .toList(),
                        suggestionState: Suggestion.expand,
                        textInputAction: TextInputAction.next,
                        hint: 'جستجوی فروشنده',
                        searchStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.8),
                        ),
                        searchInputDecoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.8),
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                        maxSuggestionsInViewPort: 6,
                        itemHeight: 50,
                        onSuggestionTap: (x) {
                          controller.selectSupplier(x
                              .searchKey); // به‌روزرسانی اطلاعات فروشنده در کنترلر
                        },
                      );
                    },
                  ),
                  const Divider(), // خط زیر SearchField
                  GetBuilder<GeneralCategoryController>(
                    id: '_suppliersallview',
                    builder: (controller) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text('نام شرکت: '),
                              Text(controller.selectedSupplierCompanyName ??
                                  '---'),
                              // نمایش اطلاعات یا جایگزینی "---" در صورت خالی بودن
                            ],
                          ),
                          Row(
                            children: [
                              const Text('شماره تلفن: '),
                              Text(controller.selectedSupplierPhoneNumber ??
                                  '---'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('شماره موبایل: '),
                              Text(controller.selectedSupplierMobileNumber ??
                                  '---'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('آدرس: '),
                              Text(controller.selectedSupplierAddress ?? '---'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('موقعیت: '),
                              Text(
                                  controller.selectedSupplierLocation ?? '---'),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  // SupplierDetails(
                  //   companyName: controller.selectedSupplierCompanyName,
                  //   phoneNumber: controller.selectedSupplierPhoneNumber,
                  //   mobileNumber: controller.selectedSupplierMobileNumber,
                  //   address: controller.selectedSupplierAddress,
                  //   location: controller.selectedSupplierLocation,
                  // ),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: GetBuilder<GeneralCategoryController>(
        id: '_suppliersfloatin',
        builder: (controller) {
          return FloatingActionButton(
            onPressed: () {
              // عملیات برای دکمه فشاری
              if (controller.selectedSupplierCompanyName != null) {
                // عملیات مورد نظر وقتی فروشنده انتخاب شده

                controller.createOrderBuyProduct(
                    controller.selectedSupplierID.toString());

                print('Floating Action Button Pressed');
              }
            },
            backgroundColor: controller.selectedSupplierCompanyName != null
                ? Colors.blue
                : Colors.grey,
            child: Icon(Icons.check),
          );
        },
      ),
    );
  }
}

// class DataLoader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final GeneralCategoryController controller = Get.find();
//
//     return FutureBuilder<void>(
//       future: controller.fetchAllSuppliers(), // بارگیری داده‌ها
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (snapshot.hasError) {
//           return Center(
//               child: Text('خطا در بارگیری داده‌ها: ${snapshot.error}'));
//         }
//
//         return const SizedBox
//             .shrink(); // اگر داده‌ها بارگیری شدند، هیچ چیز نمایش داده نمی‌شود
//       },
//     );
//   }
// }

// class SupplierDetails extends StatelessWidget {
//   final String? companyName;
//   final String? phoneNumber;
//   final String? mobileNumber;
//   final String? address;
//   final String? location;
//
//   const SupplierDetails({
//     Key? key,
//     this.companyName,
//     this.phoneNumber,
//     this.mobileNumber,
//     this.address,
//     this.location,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             const Text('نام شرکت: '),
//             Text(companyName ?? '---'),
//             // نمایش اطلاعات یا جایگزینی "---" در صورت خالی بودن
//           ],
//         ),
//         Row(
//           children: [
//             const Text('شماره تلفن: '),
//             Text(phoneNumber ?? '---'),
//           ],
//         ),
//         Row(
//           children: [
//             const Text('شماره موبایل: '),
//             Text(mobileNumber ?? '---'),
//           ],
//         ),
//         Row(
//           children: [
//             const Text('آدرس: '),
//             Text(address ?? '---'),
//           ],
//         ),
//         Row(
//           children: [
//             const Text('موقعیت: '),
//             Text(location ?? '---'),
//           ],
//         ),
//       ],
//     );
//   }
// }

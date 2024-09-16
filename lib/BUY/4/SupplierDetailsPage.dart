import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project/BUY/ControllerBuy/GeneralCategoryController.dart';

import 'package:project/BUY/5/general_category.dart';
import 'package:project/utiliti/double_extenstions.dart';

class SupplierDetailsController extends GetxController {
  final GeneralCategoryController generalController = Get.find();
  double totalSalePrice = 0.0;
  String orderId = '';

  void fetchOrderDetails(String orderId) {
    this.orderId = orderId;
    generalController.fetchOrderById(orderId).then((_) {
      _calculateTotalSalePrice();
      update(); // به‌روزرسانی رابط کاربری
    });
  }

  void _calculateTotalSalePrice() {
    totalSalePrice = 0.0; // بازنشانی مقدار کل

    if (generalController.OrderByIdBuyProducts.isNotEmpty) {
      totalSalePrice = generalController.OrderByIdBuyProducts.first.buy_product
          .map((buyProduct) => double.tryParse(buyProduct.saleprice) ?? 0.0)
          .fold(0.0, (prev, amount) => prev + amount);
    }
  }

  void refreshData() {
    fetchOrderDetails(orderId); // بازخوانی اطلاعات و به‌روزرسانی
  }
}

class SupplierDetailsPage extends StatelessWidget {
  final String orderId;
  final GeneralCategoryController controlerssa = Get.find();

  SupplierDetailsPage(this.orderId);

  @override
  Widget build(BuildContext context) {
    final SupplierDetailsController supplierController =
        Get.put(SupplierDetailsController());

    // بارگذاری جزئیات سفارش در اولین ساخت ویجت
    WidgetsBinding.instance.addPostFrameCallback((_) {
      supplierController.fetchOrderDetails(orderId);
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('جزئیات فروشنده'),
        ),
        body: GetBuilder<SupplierDetailsController>(
       //   id: '_suppliersfloatin',
          builder: (supplierController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('نام شرکت: '),
                          Text(supplierController.generalController
                                  .selectedSupplierCompanyName ??
                              '---'),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('شماره تلفن: '),
                          Text(supplierController.generalController
                                  .selectedSupplierPhoneNumber ??
                              '---'),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('شماره موبایل: '),
                          Text(supplierController.generalController
                                  .selectedSupplierMobileNumber ??
                              '---'),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('آدرس: '),
                          Text(supplierController
                                  .generalController.selectedSupplierAddress ??
                              '---'),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('موقعیت: '),
                          Text(supplierController
                                  .generalController.selectedSupplierLocation ??
                              '---'),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => general_category_page(orderId))!
                              .then((_) {
                            // بعد از بازگشت از صفحه دیگر، داده‌ها را مجدد بارگذاری کنید
                            supplierController.refreshData();
                          });
                          print('Add button pressed');
                        },
                        child: Text('افزودن محصول به فاکتور'),
                      ),
                      Text(
                          'مبلغ کل فاکتور: ${supplierController.totalSalePrice.convertToPricedobelBuyProduct()}'),
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder<void>(
                    future: supplierController.generalController
                        .fetchOrderById(orderId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (supplierController
                              .generalController.OrderByIdBuyProducts.isEmpty ||
                          supplierController.generalController
                              .OrderByIdBuyProducts.first.buy_product.isEmpty) {
                        return Center(
                            child: Text('محصولات رو به فاکتور وارد کنید.'));
                      }

                      final orderBuyProduct = supplierController
                          .generalController.OrderByIdBuyProducts.first;

                      return ListView.builder(
                        itemCount: orderBuyProduct.buy_product.length,
                        itemBuilder: (context, index) {
                          final buyProduct = orderBuyProduct.buy_product[index];
                          return ExpansionTile(
                            title: Column(
                              children: [
                                Text(buyProduct.title),
                                Text(' قیمت ' + buyProduct.saleprice),
                              ],
                            ),
                            children:
                                buyProduct.snBuyProductLogin.map((subItem) {
                              return ListTile(
                                title: Text(subItem.title),
                                subtitle: Text("SN: ${subItem.sn}"),
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<SupplierDetailsController>(
                //  id: 'fetchOrderById1',
                  builder: (supplierController) {
                    bool isListEmpty = supplierController
                            .generalController.OrderByIdBuyProducts.isEmpty ||
                        supplierController.generalController
                            .OrderByIdBuyProducts.first.buy_product.isEmpty;

                    return FloatingActionButton(
                      backgroundColor: isListEmpty ? Colors.blue : Colors.grey,
                      onPressed: isListEmpty
                          ? () {
                              // عملکرد دکمه چپ زمانی که لیست خالی است
                              controlerssa.generatefactororderdelete(
                                  supplierController.orderId);
                              print('Left Floating Action Button pressed');
                            }
                          : null, // غیرفعال کردن دکمه اگر لیست خالی نیست
                      child: Icon(Icons.arrow_back_ios_outlined),
                    );
                  },
                ),
              SizedBox(width: 30,),
                GetBuilder<SupplierDetailsController>(
             //     id: 'fetchOrderById2',
                  builder: (supplierController) {
                    bool isListEmpty = supplierController
                            .generalController.OrderByIdBuyProducts.isEmpty ||
                        supplierController.generalController
                            .OrderByIdBuyProducts.first.buy_product.isEmpty;

                    return FloatingActionButton(
                      backgroundColor: isListEmpty ? Colors.grey : Colors.blue,
                      onPressed: isListEmpty
                          ? null
                          : () {
                              // عملکرد دکمه راست
                              controlerssa.generatefactororder(
                                  supplierController.orderId,
                                  supplierController.totalSalePrice);
                              print('Right Floating Action Button pressed');
                              print(
                                  'Total Sale Price: ${supplierController.totalSalePrice}');
                            },
                      child: Icon(Icons.check),
                    );
                  },
                ),
              ],
            ),
            padding: EdgeInsets.only(right: 16, left: 16, bottom: 16)),
      ),
    );
  }
}

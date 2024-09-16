import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:flutter/services.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:project/BUY/ControllerBuy/GeneralCategoryController.dart';

import 'package:project/BUY/4/SupplierDetailsPage.dart';
import 'package:project/BUY/ModelBuy/model.dart';

import 'package:project/utiliti/double_extenstions.dart';

import 'package:slide_countdown/slide_countdown.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:searchfield/searchfield.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'package:get/get.dart';

class DetailsPage extends StatelessWidget {
  final String orderId;
  final String title;
  final String number;
  final String id;
  final String idproduct;

  DetailsPage(
      {required this.title,
      required this.number,
      required this.id,
      required this.orderId,
      required this.idproduct});

  @override
  Widget build(BuildContext context) {
    final GeneralCategoryController controller = Get.find();

    // if (snapshot.connectionState == ConnectionState.waiting) {
    //   return Center(child: CircularProgressIndicator());
    // } else if (snapshot.hasError) {
    //   return Center(child: Text('Error: ${snapshot.error}'));
    // }

    controller.fetchNameProductCategory(id);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // عملکرد بازگشت سفارشی
            Get.to(() => SupplierDetailsPage(orderId));
          },
        ),
        title: Text(title),
      ),
      body: FutureBuilder(
        future: controller.fetchBuyProductsById(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   number,
                //   style: TextStyle(fontSize: 48),
                // ),
                Center(
                  child: GetBuilder<GeneralCategoryController>(
                    id: 'productD',
                    builder: (controller) {
                      // چک کردن اینکه آیا داده‌ها لود شده‌اند
                      if (controller.nameProductCategorys == null) {
                        return CircularProgressIndicator(); // نمایش لودینگ تا وقتی داده‌ها بارگذاری شوند
                      }

                      // دریافت آبجکت nameProductCategory از کنترلر
                      NameProductCategory category =
                          controller.nameProductCategorys!;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Text('ID: ${category.id}'),
                          // Text('Title: ${category.title}'),
                          Text(' ${category.number}',
                              style: TextStyle(fontSize: 48)),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {
                        _showAddProductDialogB(
                            context, title, controller, orderId, idproduct);
                      },
                      icon: Icon(Icons.add)),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GetBuilder<GeneralCategoryController>(
                    id: 'productbuy',
                    builder: (controller) {
                      return ListView.builder(
                        itemCount: controller.buyProducts.length,
                        itemBuilder: (context, index) {
                          final buyProduct = controller.buyProducts[index];
                          return Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (buyProduct.snBuyProductLogin.isEmpty) {
                                    controller.deleteBuyId_BuyProdut(
                                      buyProduct.id,
                                      buyProduct.number,
                                      id,
                                    );

                                    Get.snackbar(
                                      'موفق',
                                      'سفارش شما با موفقیت حذف شد.',
                                      backgroundColor: Colors.green,
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
                              // Text(buyProduct.title),
                              // Text(buyProduct.number),
                              Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 16.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    // color: product.listbuyProduct.okbuy
                                    // ? Colors.green[100]
                                    //     : Colors.yellow[200],
                                    // تغییر رنگ پس‌زمینه بر اساس
                                    // productB.okbuy
                                    border: Border.all(
                                      // color: productB.hurry
                                      // ? Colors.blue
                                      //     : Colors.grey,
                                      // تغییر رنگ بوردر بر اساس productB.hurry
                                      width: 4, // ضخامت بوردر
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        8.0), // شکل گرد بوردر
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          children: [
                                            Card(
                                              child: Column(children: [
                                                // IconButton(
                                                //   icon: const Icon(
                                                //       Icons.mode_edit),
                                                //   onPressed: () async {
                                                //     // نمایش پروگرس بار به مدت 1 ثانیه
                                                //     showDialog(
                                                //       context: context,
                                                //       barrierDismissible: false,
                                                //       builder: (context) {
                                                //         return Center(
                                                //           child:
                                                //               CircularProgressIndicator(),
                                                //         );
                                                //       },
                                                //     );
                                                //
                                                //     // تاخیر یک ثانیه‌ای
                                                //     await Future.delayed(Duration(seconds: 1));
                                                //     await widget.orderController.fetchSupplierById(productB.supplier);
                                                //
                                                //     Navigator.of(context).pop(); // Close the progress indicator
                                                //
                                                //
                                                //     showDialog(
                                                //     context: context,
                                                //     builder: (context) =>
                                                //     ProductDetailsDialogB(
                                                //     productType:
                                                //     'رزرو محصول برای استعلام ',
                                                //     productTitle:
                                                //     productB.title,
                                                //     productId:
                                                //     productB.id,
                                                //     productPrice: productB
                                                //         .purchaseprice,
                                                //     supplier:
                                                //     productB.supplier,
                                                //
                                                //
                                                //     supplierId:
                                                //     productB.supplier,
                                                //     days: productB.days,
                                                //     dataclearing: productB
                                                //         .dataclearing,
                                                //     datecreated: productB
                                                //         .datecreated,
                                                //     number:
                                                //     productB.number,
                                                //     productB: productB,
                                                //     controller: widget
                                                //         .orderController,
                                                //     listb: widget.order.listProductB,
                                                //     proA: productA,
                                                //
                                                //     ),
                                                //   },
                                                // ),
                                              ]),
                                            ),
                                            Text('${buyProduct.title} '),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text('تعداد: '),
                                            Text(buyProduct.number),
                                            Spacer(),
                                            // Text(product.listbuyProduct.hurry
                                            // ? 'فورس'
                                            //     : 'فروش خاموش'),
                                            // Switch(
                                            // value: productB.hurry,
                                            // onChanged: (bool value) {
                                            // widget.orderController.updateProductBhurry(
                                            // productB.id, value);
                                            // },
                                            // ),
                                            //Text(productB.okbuy ? 'خرید' : 'رزرو'),
                                            // Switch(
                                            // value: productB.okbuy,
                                            // onChanged: (bool value) {
                                            // widget.orderController.updateProductBokbuy(
                                            // productB.id, value);
                                            // },
                                            // ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                const SizedBox(width: 20),
                                                Expanded(
                                                  child: TextField(
                                                    controller:
                                                        TextEditingController(
                                                            text: buyProduct
                                                                .purchaseprice
                                                                .convertToPrice()),
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'قیمت خرید',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text('\n' +
                                                      ' جمع مبلغ کل به حروف : ' +
                                                      buyProduct.purchaseprice
                                                          .toWord() +
                                                      ' ریال '),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Spacer(),
                                                Row(
                                                  children: [
                                                    Text('نوع سفارش : '),
                                                    // Text(product.listbuyProduct.official
                                                    // ? 'رسمی'
                                                    //     : 'غیر رسمی'),
                                                  ],
                                                )
                                              ],
                                            ),
                                            // Row(
                                            //   children: [
                                            //     Text(' گارانتی :  '),
                                            //     MultiSelectContainer(
                                            //       prefix: MultiSelectPrefix(
                                            //         selectedPrefix: const Padding(
                                            //           padding: EdgeInsets.only(right: 5),
                                            //           child: Icon(
                                            //             Icons.check,
                                            //             color: Colors.blue,
                                            //             size: 14,
                                            //           ),
                                            //         ),
                                            //         disabledPrefix: const Padding(
                                            //           padding: EdgeInsets.only(right: 5),
                                            //           child: Icon(
                                            //             Icons.do_disturb_alt_sharp,
                                            //             size: 14,
                                            //           ),
                                            //         ),
                                            //       ),
                                            //       items: buyProduct.garranty.map((items) {
                                            //         return MultiSelectCard(
                                            //           value: items,
                                            //           label: items.garranty,
                                            //         );
                                            //       }).toList(),
                                            //       onChange: (allSelectedItems, selectedItem) {
                                            //         // handleSelectionChange(allSelectedItems, selectedItem);
                                            //       },
                                            //     ),
                                            //   ],
                                            // ),
                                            ExpansionTileItem(
                                              title: Text(
                                                  'SN ورود و خروج به انبار',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              children: [
                                                ...buyProduct.snBuyProductLogin
                                                    .map((sn) => SizedBox(
                                                          child: Center(
                                                            widthFactor:
                                                                double.infinity,
                                                            child: Card(
                                                              child: Text(
                                                                  '- ${sn.title} (${sn.sn})',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          16)),
                                                            ),
                                                          ),
                                                          width:
                                                              double.infinity,
                                                        )),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                          //   ExpansionTile(
                          //   title: Directionality(
                          //     textDirection: TextDirection.rtl,
                          //     child:
                          //   ),
                          //   children:
                          //       buyProduct.snBuyProductLogin.map((subItem) {
                          //     return ListTile(
                          //       title: Text(subItem.title),
                          //       subtitle: Text("SN: ${subItem.sn}"),
                          //     );
                          //   }).toList(),
                          // );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAddProductDialogB(
    BuildContext context,
    String title,
    GeneralCategoryController controllersa,
    String orderId,
    String idproduct,
  ) {
    late String futureDateGregorianString;

    bool official = false;
    bool hurry = false;
    bool isValuable = false;

    int storedDays = 0;
    late String daysa;
    Jalali currentDate = Jalali.now();
    Jalali futureDate = currentDate.addDays(storedDays);

    final TextEditingController productTitleController =
        TextEditingController(text: title);
    final TextEditingController productPriceController =
        TextEditingController();
    final TextEditingController productNumberController =
        TextEditingController();
    final TextEditingController controller =
        TextEditingController(text: storedDays.toString());

    // متغیرهای جدید برای درصد و قیمت تمام شده
    final TextEditingController percentageController = TextEditingController();
    final TextEditingController finalPriceController = TextEditingController();

    // تابع برای محاسبه قیمت تمام شده
    void _calculateFinalPrice() {
      final price =
          double.tryParse(productPriceController.text.replaceAll(',', '')) ?? 0;
      final percentage = double.tryParse(percentageController.text) ?? 0;
      final finalPrice = price + (price * (percentage / 100));
      finalPriceController.text = finalPrice.convertToPricedobelBuyProduct();
    }

    List<String> removeDuplicates(List<String> list) {
      return list.toSet().toList();
    }

    List<String> g = [];
    List<String> uniqueList = [];

    void handleSelectionChange(
        List<dynamic> allSelectedItems, String selectedItem) {
      g.add(selectedItem);
      uniqueList = removeDuplicates(allSelectedItems.cast<String>());
      print(uniqueList);
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Row(children: [
            Text('$title'),
            Text(' خرید محصول '),
          ]),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  readOnly: true,
                  controller: productTitleController,
                  decoration: const InputDecoration(labelText: 'نام محصول'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: productPriceController,
                  decoration: const InputDecoration(labelText: 'قیمت خرید'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    PriceInputFormatter(),
                  ],
                  onChanged: (value) {
                    _calculateFinalPrice();
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: productNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'تعداد'),
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('امروز: '),
                        // Text(currentDate.formatCompactDateCustom()),
                      ],
                    ),
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'چند روز تا تسویه را وارد کنید'),
                      onChanged: (value) {
                        setState(() {
                          int days = int.tryParse(value) ?? storedDays;
                          futureDate = currentDate.addDays(days);

                          Jalali futureDatee = currentDate.addDays(days);

                          // تبدیل تاریخ شمسی به میلادی
                          Gregorian futureDateGregorian =
                              futureDatee.toGregorian();

                          // ساخت DateTime میلادی با ساعت 23:59:59
                          DateTime futureDateTime = DateTime(
                            futureDateGregorian.year,
                            futureDateGregorian.month,
                            futureDateGregorian.day,
                            23,
                            59,
                            59,
                          );

                          // تبدیل به رشته برای نمایش به صورت ISO 8601
                          futureDateGregorianString =
                              futureDateTime.toIso8601String();

                          daysa = days.toString();
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('تاریخ تسویه: '),
                        Text(controller.text.isEmpty
                            ? 'چند روز تا تسویه را وارد کنید'
                            : '${futureDate.year}-${futureDate.month.toString().padLeft(2, '0')}-${futureDate.day.toString().padLeft(2, '0')}'),
                      ],
                    ),
                  ],
                ),
                GetBuilder<GeneralCategoryController>(
                  id: 'garrantya',
                  builder: (controller) {
                    return MultiSelectContainer(
                      prefix: MultiSelectPrefix(
                        selectedPrefix: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                        disabledPrefix: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.do_disturb_alt_sharp,
                            size: 14,
                          ),
                        ),
                      ),
                      items: controller.selectedGarrantyItems.map((item) {
                        return MultiSelectCard(
                          value: item.garranty,
                          label: item.garranty,
                        );
                      }).toList(),
                      onChange: (allSelectedItems, selectedItem) {
                        handleSelectionChange(allSelectedItems, selectedItem);
                      },
                    );
                  },
                ),
                Row(
                  children: [
                    // Text('رسمی و غیر رسمی'),
                    Switch(
                      value: official,
                      onChanged: (value) {
                        setState(() {
                          official = value;
                          if (!official) {
                            percentageController.clear();
                            finalPriceController.clear();
                            isValuable = false;
                          }
                        });
                      },
                    ),
                    Spacer(),
                    Text(official ? 'رسمی' : 'غیر رسمی'),
                  ],
                ),
                if (official) ...[
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: percentageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'درصد اضافه'),
                    onChanged: (value) {
                      _calculateFinalPrice();
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: finalPriceController,
                    readOnly: true,
                    decoration:
                        const InputDecoration(labelText: 'قیمت تمام شده'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: isValuable,
                        onChanged: (value) {
                          setState(() {
                            isValuable = value ?? false;
                          });
                        },
                      ),
                      const Text('ارزشی'),
                    ],
                  ),
                ],
                const SizedBox(height: 10),
                Row(
                  children: [
                    // Text('عجله ای'),
                    Switch(
                      value: hurry,
                      onChanged: (value) {
                        setState(() {
                          hurry = value;
                        });
                      },
                    ),
                    Spacer(),
                    Text(hurry ? 'عجله دارد' : 'عجله ندارد'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('کنسل'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (g.isEmpty) {
                  String productTitle = productTitleController.text;
                  String productPrice = productPriceController.text
                      .convertToPrice()
                      .replaceAll(',', '');
                  String percentage = percentageController.text
                      .convertToPrice()
                      .replaceAll(',', '');
                  String finalPrice = finalPriceController.text
                      .convertToPrice()
                      .replaceAll(',', '');
                  String productNumber = productNumberController.text;
                  if (productTitle.isNotEmpty &&
                      productPrice.isNotEmpty &&
                      productNumber.isNotEmpty) {
                    // نمایش Progress Indicator
                    showDialog(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );

                    await controllersa.addProductToBuyProduct(
                        title: "${productTitle}",
                        supplierId: '${controllersa.selectedSupplierID}',
                        days: '${daysa}',
                        dateCreated:
                            '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}',
                        dataClearing:
                            '${futureDate.year}-${futureDate.month.toString().padLeft(2, '0')}-${futureDate.day.toString().padLeft(2, '0')}',
                        number: "${productNumber}",
                        dateAd: futureDateGregorianString,
                        hurry: hurry,
                        official: official,
                        purchasePrice: productPrice.split('.').first,
                        orderID: orderId,
                        idproduct: idproduct,
                        idupdate: id,
                        //     isValuable: isValuable,
                        percent: percentage,
                        saleprice: finalPrice,
                        valuable: isValuable);

                    // بستن Progress Indicator
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('محصول با موفقیت اضافه شد'),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('لطفا اطلاعات رو کامل کنید'),
                    ));
                  }
                } else {
                  print('rrrrrrrrrrrrrr');
                  print('${uniqueList.length}');

                  String productTitle = productTitleController.text;
                  String productPrice = productPriceController.text
                      .convertToPrice()
                      .replaceAll(',', '');
                  String percentage = percentageController.text
                      .convertToPrice()
                      .replaceAll(',', '');
                  String finalPrice = finalPriceController.text
                      .convertToPrice()
                      .replaceAll(',', '');
                  String productNumber = productNumberController.text;
                  if (productTitle.isNotEmpty &&
                      productPrice.isNotEmpty &&
                      productNumber.isNotEmpty) {
                    // نمایش Progress Indicator
                    showDialog(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );

                    await controllersa.addProductToBuyProductByGaranty(
                        title: "${productTitle}",
                        supplierId: '${controllersa.selectedSupplierID}',
                        days: '${daysa}',
                        dateCreated:
                            '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}',
                        dataClearing:
                            '${futureDate.year}-${futureDate.month.toString().padLeft(2, '0')}-${futureDate.day.toString().padLeft(2, '0')}',
                        number: "${productNumber}",
                        dateAd: futureDateGregorianString,
                        hurry: hurry,
                        official: official,
                        purchasePrice: productPrice.split('.').first,
                        orderID: orderId,
                        idproduct: idproduct,
                        idupdate: id,
                        //     isValuable: isValuable,
                        percent: percentage,
                        saleprice: finalPrice,
                        valuable: isValuable,
                        garanty: uniqueList);

                    // بستن Progress Indicator
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('محصول با موفقیت اضافه شد'),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('لطفا اطلاعات رو کامل کنید'),
                    ));
                  }
                }

                // به‌روزرسانی ویجت‌های وابسته
              }

              ///////////////

              ///////////////

              ,
              child: const Text('ثبت سفارش محصول'),
            ),
          ],
        ),
      ),
    );
  }
}

extension JalaliExtensionCustom on Jalali {
  String formatCompactDateCustom() {
    String month = this.month.toString().padLeft(2, '0');
    return '${this.year}/$month/${this.day.toString().padLeft(2, '0')}';
  }
}

// void main() {
//   // راه‌اندازی GetX Controller
//   Get.put(GeneralCategoryController());
//
//   runApp(MaterialApp(
//     home: DataDisplayPage(),
//   ));
// }

//
//
//
// import 'package:flutter/material.dart';
// import 'package:pocketbase/pocketbase.dart';
// import 'package:get/get.dart';
//
// import 'package:saaterco_buysell/BUY/ControllerBuy/GeneralCategoryController.dart';
// import 'package:saaterco_buysell/BUY/4/SupplierDetailsPage.dart';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:saaterco_buysell/BUY/model.dart';
//
// import 'package:saaterco_buysell/BuySell_GetX/double_extenstions.dart';
//
// import 'package:persian_datetime_picker/persian_datetime_picker.dart';
//
// class DetailsPage extends StatelessWidget {
//   final String orderId;
//   final String title;
//   final String number;
//   final String id; //name_product_category
//   final String idproduct;
//
//   DetailsPage(
//       {required this.title,
//         required this.number,
//         required this.id,
//         required this.orderId,
//         required this.idproduct});
//
//   @override
//   Widget build(BuildContext context) {
//     final GeneralCategoryController controller = Get.find();
//
//     // if (snapshot.connectionState == ConnectionState.waiting) {
//     //   return Center(child: CircularProgressIndicator());
//     // } else if (snapshot.hasError) {
//     //   return Center(child: Text('Error: ${snapshot.error}'));
//     // }
//
//     controller.fetchBuyProductsById(id);
//
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             // عملکرد بازگشت سفارشی
//             Get.to(() => SupplierDetailsPage(orderId));
//           },
//         ),
//         title: Text(title),
//       ),
//       body: FutureBuilder(
//         future: controller.fetchNameProductCategory(id),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           controller.fetchNameProductCategory(id);
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Text(
//                 //   number,
//                 //   style: TextStyle(fontSize: 48),
//                 // ),
//                 Center(
//                   child: GetBuilder<GeneralCategoryController>(
//                     id: 'productD',
//                     builder: (controller) {
//                       // چک کردن اینکه آیا داده‌ها لود شده‌اند
//                       if (controller.nameProductCategory == null) {
//                         return CircularProgressIndicator(); // نمایش لودینگ تا وقتی داده‌ها بارگذاری شوند
//                       }
//
//                       // دریافت آبجکت nameProductCategory از کنترلر
//                       NameProductCategory category =
//                       controller.nameProductCategory!;
//
//                       return Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           // Text('ID: ${category.id}'),
//                           // Text('Title: ${category.title}'),
//                           Text(' ${category.number}', style: TextStyle(fontSize: 48)),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//
//                 Container(
//                   alignment: Alignment.bottomRight,
//                   child: IconButton(
//                       onPressed: () {
//                         _showAddProductDialogB(
//                             context, title, controller, orderId, idproduct);
//                       },
//                       icon: Icon(Icons.add)),
//                 ),
//                 SizedBox(height: 20),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: controller.buyProducts.length,
//                     itemBuilder: (context, index) {
//                       final buyProduct = controller.buyProducts[index];
//                       return ExpansionTile(
//                         title: Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: Column(
//                             children: [
//                               IconButton(
//                                   onPressed: () {
//                                     if (buyProduct.snBuyProductLogin.length ==
//                                         0 ||
//                                         buyProduct.snBuyProductLogin.length <
//                                             0) {
//                                       controller.deleteBuyId_BuyProdut(
//                                           buyProduct.id, buyProduct.number, id);
//                                     } else {
//                                       Get.snackbar(
//                                           'اول تکلیف محصولات ورود به انبار را مشخص کنید',
//                                           'شما مجاز به حذف سفارش نیستید.',
//                                           backgroundColor: Colors.red);
//                                     }
//                                   },
//                                   icon: Icon(Icons.delete)),
//                               Text(buyProduct.title),
//                               Text(buyProduct.number),
//                             ],
//                           ),
//                         ),
//                         children: buyProduct.snBuyProductLogin.map((subItem) {
//                           return ListTile(
//                             title: Text(subItem.title),
//                             subtitle: Text("SN: ${subItem.sn}"),
//                           );
//                         }).toList(),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   void _showAddProductDialogB(
//       BuildContext context,
//       String title,
//       GeneralCategoryController controllersa,
//       String orderId,
//       String idproduct) {
//     late String futureDateGregorianString;
//
//     bool official = false;
//     bool hurry = false;
//
//     int storedDays = 0;
//     late String daysa;
//     Jalali currentDate = Jalali.now();
//     Jalali futureDate = currentDate.addDays(storedDays);
//
//     final TextEditingController productTitleController =
//     TextEditingController(text: title);
//     final TextEditingController productPriceController =
//     TextEditingController();
//     final TextEditingController productNumberController =
//     TextEditingController();
//     final TextEditingController controller =
//     TextEditingController(text: storedDays.toString());
//
//     // Define variables to hold supplier details
//
//     showDialog(
//       context: context,
//       builder: (context) => StatefulBuilder(
//         builder: (context, setState) => AlertDialog(
//           title: Row(children: [
//             Text('${title}'),
//             Text(' خرید محصول  '),
//           ]),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   readOnly: true,
//                   controller: productTitleController,
//                   decoration: const InputDecoration(labelText: 'نام محصول'),
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: productPriceController,
//                   decoration: const InputDecoration(labelText: 'قیمت خرید'),
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly,
//                     PriceInputFormatter(),
//                     // استفاده از فرمت‌کننده سفارشی
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 TextFormField(
//                   controller: productNumberController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(labelText: 'تعداد'),
//                 ),
//                 const SizedBox(height: 10),
//                 Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text('امروز: '),
//                         Text(currentDate.formatCompactDateCustom()),
//                       ],
//                     ),
//                     TextField(
//                       controller: controller,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(
//                           labelText: 'چند روز تا تسویه را وارد کنید'),
//                       onChanged: (value) {
//                         setState(() {
//                           int days = int.tryParse(value) ?? storedDays;
//                           futureDate = currentDate.addDays(days);
//
//                           Jalali futureDatee = currentDate.addDays(days);
//
//                           // تبدیل تاریخ شمسی به میلادی
//                           Gregorian futureDateGregorian =
//                           futureDatee.toGregorian();
//
//                           // ساخت DateTime میلادی با ساعت 23:59:59
//                           DateTime futureDateTime = DateTime(
//                             futureDateGregorian.year,
//                             futureDateGregorian.month,
//                             futureDateGregorian.day,
//                             23,
//                             59,
//                             59,
//                           );
//
//                           // تبدیل به رشته برای نمایش به صورت ISO 8601
//                           futureDateGregorianString =
//                               futureDateTime.toIso8601String();
//
//                           print('iiioooii');
//                           print('${futureDate}');
//                           daysa = days.toString();
//                         });
//                       },
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text('تاریخ تسویه: '),
//                         Text(controller.text.isEmpty
//                             ? 'چند روز تا تسویه را وارد کنید'
//                             : '${futureDate.year}-${futureDate.month.toString().padLeft(2, '0')}-${futureDate.day.toString().padLeft(2, '0')}'),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Text('رسمی و غیر رسمی'),
//                     Switch(
//                       value: official,
//                       onChanged: (value) {
//                         setState(() {
//                           official = value;
//                         });
//                       },
//                     ),
//                     Spacer(),
//                     Text('عجله ای'),
//                     Switch(
//                       value: hurry,
//                       onChanged: (value) {
//                         setState(() {
//                           hurry = value;
//                         });
//                       },
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 //      Text('Company id: $selectedSupplierId'),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: const Text('کنسل'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 String productTitle = productTitleController.text;
//                 String productPrice = productPriceController.text
//                     .convertToPrice()
//                     .replaceAll(',', ''); // Convert to integer without commas
//                 String productNumber = productNumberController.text;
//                 if (productTitle.isNotEmpty &&
//                     productPrice.isNotEmpty &&
//                     productNumber.isNotEmpty) {
//                   // نمایش Progress Indicator
//                   showDialog(
//                     context: context,
//                     barrierColor: Colors.transparent,
//                     builder: (BuildContext context) {
//                       return Center(child: CircularProgressIndicator());
//                     },
//                   );
//
//                   // if (productType == 'B') {
//
//                   await controllersa.addProductToBuyProduct(
//                       title: "${productTitle}",
//                       supplierId: '${controllersa.selectedSupplierID}',
//                       days: '${daysa}',
//                       dateCreated:
//                       '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}',
//                       dataClearing:
//                       '${futureDate.year}-${futureDate.month.toString().padLeft(2, '0')}-${futureDate.day.toString().padLeft(2, '0')}',
//                       number: "${productNumber}",
//                       dateAd: futureDateGregorianString,
//                       hurry: hurry,
//                       official: official,
//                       purchasePrice: productPrice.split('.').first,
//                       orderID: orderId,
//                       idproduct: idproduct
//                       ,idupdate: id
//                   );
//
//                   //
//                   //     await controllersa.addProductToBuyProduct(
//                   // order.id,
//                   // productTitle,
//                   // productPrice
//                   //     .split('.')
//                   //     .first,
//                   // // Remove decimals before saving
//                   // selectedSupplierId,
//                   // daysa,
//                   // '${currentDate.year}-${currentDate.month
//                   //     .toString().padLeft(2, '0')}-${currentDate
//                   //     .day.toString().padLeft(2, '0')}',
//                   // '${futureDate.year}-${futureDate.month
//                   //     .toString().padLeft(2, '0')}-${futureDate
//                   //     .day.toString().padLeft(2, '0')}',
//                   // productNumber,
//                   //
//                   // official,
//                   // hurry,
//                   // futureDateGregorianString,
//                   //
//                   // widget.order.listProductB,
//                   // productA
//                   // );
//                   // }
//                   // // بستن Progress Indicator
//                   Navigator.of(context).pop();
//                   Navigator.of(context).pop();
//
//                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                     content: Text('محصول با موفقیت اضافه شد'),
//                   ));
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                     content: Text('لطفا اطلاعات رو کامل کنید'),
//                   ));
//                 }
//               },
//               child: const Text('ثبت سفارش محصول'),
//             ),
//             // ElevatedButton(
//             //   onPressed: () {
//             //     String productTitle = productTitleController.text;
//             //     String productPrice = parsePrice(productPriceController.text);
//             //     // Convert to integer without commas
//             //     String productNumber = productNumberController.text;
//             //     if (productTitle.isNotEmpty &&
//             //         productPrice.isNotEmpty &&
//             //         productNumber.isNotEmpty &&
//             //         selectedSupplierId != '') {
//             //       if (productType == 'B') {
//             //         orderController.addProductToB(
//             //             order.id,
//             //             productTitle,
//             //             productPrice.split('.').first,
//             //             // Remove decimals before saving
//             //             selectedSupplierId,
//             //             daysa,
//             //             '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}',
//             //             '${futureDate.year}-${futureDate.month.toString().padLeft(2, '0')}-${futureDate.day.toString().padLeft(2, '0')}',
//             //             productNumber,
//             //             rezerv,
//             //             official,
//             //             hurry,
//             //             futureDateGregorianString);
//             //       }
//             //       Navigator.of(context).pop();
//             //     } else {
//             //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             //         content: Text('لطفا اطلاعات رو کامل کنید'),
//             //       ));
//             //     }
//             //   },
//             //   child: const Text('ثبت سفارش محصول'),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// extension JalaliExtensionCustom on Jalali {
//   String formatCompactDateCustom() {
//     String month = this.month.toString().padLeft(2, '0');
//     return '${this.year}/$month/${this.day.toString().padLeft(2, '0')}';
//   }
// }
//
// // void main() {
// //   // راه‌اندازی GetX Controller
// //   Get.put(GeneralCategoryController());
// //
// //   runApp(MaterialApp(
// //     home: DataDisplayPage(),
// //   ));
// // }

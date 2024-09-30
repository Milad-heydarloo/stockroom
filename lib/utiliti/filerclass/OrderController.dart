import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:http/http.dart';

import 'package:get/get.dart';
import 'package:project/Drawer/auth_controller.dart';
import 'package:project/utiliti/double_extenstions.dart';

import 'package:project/BuySell_GetX/Supiller/Location_GetX/supplier_list_screen.dart';

Client getClient() {
  return Client();
}

// class OrderControllerPage extends GetxController {
//   final PocketBase _pb = PocketBase(
//     const String.fromEnvironment('order',
//         defaultValue: 'https://saater.liara.run'),
//     lang: const String.fromEnvironment('order', defaultValue: 'en-US'),
//     httpClientFactory: kIsWeb ? () => getClient() : null,
//   );
//
//   final String collectionName = 'order';
//   final AuthController authController = Get.find<AuthController>();
//   late final user;
//   //RxList<OrderTwo> allOrders = <OrderTwo>[].obs;
//
//   RxBool isLoading = false.obs; // استفاده از RxBool برای بارگذاری
//
//   void insializ() async {
//     user = await authController.getUser();
//     isLoading.value = true;
//     //update(['hihi']);
//     await fetchAllOrders();
//     isLoading.value = false;
//    // update(['hihi']);
//   }
//
//   late Timer _timer; // تایمر برای به روز رسانی هر 10 ثانیه
//
//   @override
//   void onInit() {
//     super.onInit();
//
//     insializ();
//    // fetchAllOrderonee();
//     startAutoRefresh(); // شروع به به روز رسانی خودکار در زمان شروع
//   }
//
//   @override
//   void onClose() {
//     super.onClose();
//     _timer.cancel(); // لغو تایمر در زمان بستن کنترلر
//   }
//
//   void startAutoRefresh() {
//     _timer = Timer.periodic(Duration(seconds: 60), (timer) {
//       print('start' + DateTime.now().toString());
//       _fetchAndUpdate(); // صدا زدن متد fetchAllOrders هر 10 ثانیه
//     });
//   }
//
//   Future<void> fetchAllOrders() async {
//     try {
//     //  isLoading.value = true;
//      // update(['hihi']);
//       // List<OrderTwo> orders = await fetchAllOrderonee();
//       // orderstwo.assignAll(orders);
//     //  orderstwo.assignAll(await fetchAllOrderonee());
//     } catch (error) {
//       print('Error fetching orders: $error');
//     } finally {
//      // isLoading.value = false;
//      // update(['hihi']);
//     }
//   }
//
//   Future<void> fetchAllOrdersRefresh() async {
//     await _fetchAndUpdate();
//   }
//
//   Future<void> fetchAllOrdersSearch({String search = ''}) async {
//     currentSearch = search;
//     await _fetchAndUpdate();
//   }
//
//   Future<void> fetchAllOrdersFilter({String filter = ''}) async {
//     currentFilter = filter;
//     await _fetchAndUpdate();
//   }
//
//   Future<void> fetchAllOrdersSort({String sort = ''}) async {
//     currentSort = sort;
//     await _fetchAndUpdate();
//   }
//
//   Future<void> fetchAllOrdersPrivate({String private = ''}) async {
//     currentPrivate = private;
//     await _fetchAndUpdate();
//   }
//
//   Future<void> _fetchAndUpdate() async {
//     try {
//
//       await fetchAllOrderonee();
//      // orderstwo.assignAll(orders);
//     } catch (error) {
//       print('Error fetching orders: $error');
//     }
//   }
//
//   String currentFilter = '';
//   String currentSearch = '';
//   String currentSort = '';
//   String currentPrivate = '';
//
//
//   Future<List<OrderTwo>> fetchAllOrderonee() async {
//     orderstwo.clear();
//     List<OrderTwo> allOrders = [];
//     int page = 1;
//     int pageSize = 50; // تعداد سفارشات در هر صفحه
//     String filterQuery = '';
//     if (currentPrivate.isNotEmpty) {
//       filterQuery += 'type = "$currentPrivate"';
//     }
//     if (currentSearch.isNotEmpty) {
//       filterQuery +=
//           (filterQuery.isNotEmpty ? ' && ' : '') + 'title ~ "$currentSearch"';
//     }
//     if (currentFilter.isNotEmpty) {
//       filterQuery += (filterQuery.isNotEmpty ? ' && ' : '') + currentFilter;
//     }
//
//     while (true) {
//       try {
//         ///  ,buy_product.supplier,buy_product.login_buy_product_sn
//         // دریافت اطلاعات سفارش‌ها از PocketBase با صفحه‌بندی
//         final ordersRecord = await _pb.collection('order').getList(
//               page: page,
//               perPage: pageSize,
//            filter: filterQuery.isNotEmpty ? filterQuery : null,
//            sort: currentSort.isNotEmpty ? currentSort : null,
//               expand:
//                   'listproducta,listproductb,listproducta.sell_buy_product,listproducta.sell_buy_product.sn_buy_product_login',
//             );
//
//         // Map<String, dynamic> orderData = ordersRecord.toJson();
//         //
//         // if (ordersRecord.items.isEmpty) {
//         //   break; // اگر هیچ داده‌ای وجود نداشت، حلقه را متوقف کن
//         // }
//         // print('9898989989899889988988');
//         // // پرینت داده‌های سفارش
//         // printOrderData(orderData);
//         // print('989898998989988');
//         // print('${orderData}');
//         print('${page}'+'page');
//         for (var ordera in ordersRecord.items) {
//           await Future.delayed(Duration(milliseconds: 3));
//           Map<String, dynamic> orderDatae = ordera.toJson();
//          // print('${orderDatae.length}'+'page');
//           OrderTwo order = OrderTwo(
//             id: orderDatae['id'],
//             title: orderDatae['title'],
//             callNumber: orderDatae['callnumber'],
//             dateNow: orderDatae['datenow'],
//             dateAd: orderDatae['datead'],
//             address: orderDatae['address'],
//             niyaz: orderDatae['niyaz'],
//             phoneNumberIT: orderDatae['phonenumberit'],
//             buy: orderDatae['buy'],
//             winner: orderDatae['winner'],
//             created: orderDatae['created'],
//             registrationNumber: orderDatae['registration_number'],
//             nationalCode: orderDatae['national_code'],
//             postalCode: orderDatae['postal_code'],
//             economicCode: orderDatae['economic_code'],
//             accountingNumber: orderDatae['accounting_number'],
//             purchaseNumber: orderDatae['purchase_number'],
//             type: orderDatae['type'],
//             windowsType: orderDatae['windows_type'] != null
//                 ? List<String>.from(orderDatae['windows_type'])
//                 : null,
//             listProductA: orderDatae['expand']?.containsKey('listproducta') == true
//                 ? (orderDatae['expand']['listproducta'] as List).map((productAData) {
//               return ProductAtwo(
//                 id: productAData['id'],
//                 title: productAData['title'],
//                 salePrice: productAData['saleprice'],
//                 number: productAData['number'],
//                 purchasePrice: productAData['purchaseprice'],
//                 description: productAData['description'],
//                 garranty: productAData.containsKey('garranty') &&
//                     productAData['garranty'] != null
//                     ? List<String>.from(productAData['garranty'])
//                     : [],
//                 unavailable: productAData['unavailable'],
//                 percent: productAData['percent'],
//                 sellBuyProduct: productAData['expand']
//                     ?.containsKey('sell_buy_product') ==
//                     true
//                     ? SellBuyProducttwo(
//                   title: productAData['expand']['sell_buy_product']
//                   ['title'],
//                   purchasePrice: productAData['expand']
//                   ['sell_buy_product']['purchaseprice'],
//                   salePrice: productAData['expand']['sell_buy_product']
//                   ['saleprice'],
//                   supplier: productAData['expand']['sell_buy_product']
//                   ['supplier'],
//                   number: productAData['expand']['sell_buy_product']
//                   ['number'],
//                   garranty: productAData['expand']['sell_buy_product']
//                       .containsKey('garranty') &&
//                       productAData['expand']['sell_buy_product']
//                       ['garranty'] !=
//                           null
//                       ? List<String>.from(productAData['expand']
//                   ['sell_buy_product']['garranty'])
//                       : [],
//                   snBuyProductLogin: productAData['expand']
//                   ['sell_buy_product']['expand']
//                       ?.containsKey('sn_buy_product_login') ==
//                       true
//                       ? (productAData['expand']['sell_buy_product']
//                   ['expand']['sn_buy_product_login'] as List)
//                       .map((snProductData) {
//                     return SNProducttwo(
//                       id: snProductData['id'],
//                       sn: snProductData['sn'],
//                       title: snProductData['title'],
//                     );
//                   }).toList()
//                       : [],
//                 )
//                     : null,
//               );
//             }).toList()
//                 : [],
//             listProductB: orderDatae['expand']['listproductb'] != null
//                 ? (orderDatae['expand']['listproductb'] as List).map((productBData) {
//               return ProductBtwo(
//                 id: productBData['id'],
//                 title: productBData['title'],
//                 purchasePrice: productBData['purchaseprice'],
//                 supplier: productBData['supplier'],
//                 days: productBData['days'],
//                 dateCreated: productBData['datecreated'],
//                 dateClearing: productBData['dataclearing'],
//                 number: productBData['number'],
//                 description: productBData['description'],
//                 dateAd: productBData['datead'],
//                 okBuy: productBData['okbuy'],
//                 hurry: productBData['hurry'],
//                 official: productBData['official'],
//               );
//             }).toList()
//                 : null,
//           );
// //update(['hihi']);
//           orderstwo.add(order);
//
//           // اضافه کردن مکث کوچک برای جلوگیری از مشکلات
//
//         }
//
//
//         if (ordersRecord.items.isEmpty) {
//           break; // اگر هیچ داده‌ای وجود نداشت، حلقه را متوقف کن
//         }
//         // print('${orderData}');
//         // for (var recordData in orderData) {
//         //
//         //
//         //
//         //   //   print('9898989989899889988988');
//         //   //   print('${recordData['id']}');
//         //   //   OrderNew? orderNew=await fessshk('${recordData['id']}');
//         //   //   allOrders .add( orderNew!) ;
//         //
//         //
//         //
//         // }
//         page++; // افزایش شماره صفحه برای بار بعدی
//       } catch (e) {
//         print('Error: $e');
//         break; // در صورت بروز خطا، حلقه را متوقف کن
//       }
//     }
//     print('22222222222222222222'+orderstwo.length.toString());
//     isLoading.value = true;
//     return allOrders; // بازگشت لیست کامل سفارش‌ها
//   }
//
//   List<OrderTwo> orderstwo = [];
//
//   void printOrderDetails(Map<String, dynamic> orderDatae)  {
//     // print('Order ID: ${orderDatae['id']}');
//     // print('Title: ${orderDatae['title']}');
//     // print('Call Number: ${orderDatae['callnumber']}');
//     // print('Date Now: ${orderDatae['datenow']}');
//     // print('Date Ad: ${orderDatae['datead']}');
//     // print('Address: ${orderDatae['address']}');
//     // print('Niyaz: ${orderDatae['niyaz']}');
//     // print('Phone Number: ${orderDatae['phonenumberit']}');
//     // print('Buy: ${orderDatae['buy']}');
//     // print('Winner: ${orderDatae['winner']}');
//     // print('Created: ${orderDatae['created']}');
//     // print('Registration Number: ${orderDatae['registration_number']}');
//     // print('National Code: ${orderDatae['national_code']}');
//     // print('Postal Code: ${orderDatae['postal_code']}');
//     // print('Economic Code: ${orderDatae['economic_code']}');
//     // print('Accounting Number: ${orderDatae['accounting_number']}');
//     // print('Purchase Number: ${orderDatae['purchase_number']}');
//     // print('Type: ${orderDatae['type']}');
//     // print('Windows Type: ${orderDatae['windows_type'].join(', ')}');
//     //
//     // // Printing listProductAa
//     // if (orderDatae['expand'] != null &&
//     //     orderDatae['expand']['listproducta'] != null) {
//     //   for (var productA in orderDatae['expand']['listproducta']) {
//     //     print('\nProduct A ID: ${productA['id']}');
//     //     print('Product A Title: ${productA['title']}');
//     //     print('Product A Sale Price: ${productA['saleprice']}');
//     //     print('Product A Number: ${productA['number']}');
//     //     print('Product A Purchase Price: ${productA['purchaseprice']}');
//     //     print('Product A Description: ${productA['description']}');
//     //     print('Product A Garranty: ${productA['garranty'].join(', ')}');
//     //     print('Product A Unavailable: ${productA['unavailable']}');
//     //     print('Product A Percent: ${productA['percent']}');
//     //
//     //     if (productA['expand'] != null &&
//     //         productA['expand']['sell_buy_product'] != null) {
//     //       var sellBuyProduct = productA['expand']['sell_buy_product'];
//     //       print('Sell Buy Product Title: ${sellBuyProduct['title']}');
//     //       print(
//     //           'Sell Buy Product Purchase Price: ${sellBuyProduct['purchaseprice']}');
//     //       print('Sell Buy Product Sale Price: ${sellBuyProduct['saleprice']}');
//     //       print('Sell Buy Product Supplier: ${sellBuyProduct['supplier']}');
//     //       print('Sell Buy Product Number: ${sellBuyProduct['number']}');
//     //       print(
//     //           'Sell Buy Product Garranty: ${sellBuyProduct['garranty'].join(', ')}');
//     //
//     //       if (sellBuyProduct['expand'] != null &&
//     //           sellBuyProduct['expand']['sn_buy_product_login'] != null) {
//     //         for (var snProduct in sellBuyProduct['expand']
//     //             ['sn_buy_product_login']) {
//     //           print('SN Product ID: ${snProduct['id']}');
//     //           print('SN Product SN: ${snProduct['sn']}');
//     //           print('SN Product Title: ${snProduct['title']}');
//     //         }
//     //       }
//     //     }
//     //   }
//     // }
//     //
//     // // Printing listProductBb
//     // if (orderDatae['expand'] != null &&
//     //     orderDatae['expand']['listproductb'] != null) {
//     //   for (var productB in orderDatae['expand']['listproductb']) {
//     //     print('\nProduct B ID: ${productB['id']}');
//     //     print('Product B Title: ${productB['title']}');
//     //     print('Product B Purchase Price: ${productB['purchaseprice']}');
//     //     print('Product B Supplier: ${productB['supplier']}');
//     //     print('Product B Days: ${productB['days']}');
//     //     print('Product B Date Created: ${productB['datecreated']}');
//     //     print('Product B Date Clearing: ${productB['dataclearing']}');
//     //     print('Product B Number: ${productB['number']}');
//     //     print('Product B Description: ${productB['description']}');
//     //     print('Product B Date Ad: ${productB['datead']}');
//     //     print('Product B OK Buy: ${productB['okbuy']}');
//     //     print('Product B Hurry: ${productB['hurry']}');
//     //     print('Product B Official: ${productB['official']}');
//     //   }
//     // }
//
//     // for (var orderData in orderDatae.values) {
//     //   // Parse and map orderData to Order object
//
//     // نمایش جزئیات سفارش (همان کدی که قبلا نوشتی)
//     // ...
//
//     // ایجاد و افزودن سفارش به لیست orderstwo
//     OrderTwo order = OrderTwo(
//       id: orderDatae['id'],
//       title: orderDatae['title'],
//       callNumber: orderDatae['callnumber'],
//       dateNow: orderDatae['datenow'],
//       dateAd: orderDatae['datead'],
//       address: orderDatae['address'],
//       niyaz: orderDatae['niyaz'],
//       phoneNumberIT: orderDatae['phonenumberit'],
//       buy: orderDatae['buy'],
//       winner: orderDatae['winner'],
//       created: orderDatae['created'],
//       registrationNumber: orderDatae['registration_number'],
//       nationalCode: orderDatae['national_code'],
//       postalCode: orderDatae['postal_code'],
//       economicCode: orderDatae['economic_code'],
//       accountingNumber: orderDatae['accounting_number'],
//       purchaseNumber: orderDatae['purchase_number'],
//       type: orderDatae['type'],
//       windowsType: orderDatae['windows_type'] != null
//           ? List<String>.from(orderDatae['windows_type'])
//           : null,
//       listProductA: orderDatae['expand']?.containsKey('listproducta') == true
//           ? (orderDatae['expand']['listproducta'] as List).map((productAData) {
//               return ProductAtwo(
//                 id: productAData['id'],
//                 title: productAData['title'],
//                 salePrice: productAData['saleprice'],
//                 number: productAData['number'],
//                 purchasePrice: productAData['purchaseprice'],
//                 description: productAData['description'],
//                 garranty: productAData.containsKey('garranty') &&
//                         productAData['garranty'] != null
//                     ? List<String>.from(productAData['garranty'])
//                     : [],
//                 unavailable: productAData['unavailable'],
//                 percent: productAData['percent'],
//                 sellBuyProduct: productAData['expand']
//                             ?.containsKey('sell_buy_product') ==
//                         true
//                     ? SellBuyProducttwo(
//                         title: productAData['expand']['sell_buy_product']
//                             ['title'],
//                         purchasePrice: productAData['expand']
//                             ['sell_buy_product']['purchaseprice'],
//                         salePrice: productAData['expand']['sell_buy_product']
//                             ['saleprice'],
//                         supplier: productAData['expand']['sell_buy_product']
//                             ['supplier'],
//                         number: productAData['expand']['sell_buy_product']
//                             ['number'],
//                         garranty: productAData['expand']['sell_buy_product']
//                                     .containsKey('garranty') &&
//                                 productAData['expand']['sell_buy_product']
//                                         ['garranty'] !=
//                                     null
//                             ? List<String>.from(productAData['expand']
//                                 ['sell_buy_product']['garranty'])
//                             : [],
//                         snBuyProductLogin: productAData['expand']
//                                         ['sell_buy_product']['expand']
//                                     ?.containsKey('sn_buy_product_login') ==
//                                 true
//                             ? (productAData['expand']['sell_buy_product']
//                                     ['expand']['sn_buy_product_login'] as List)
//                                 .map((snProductData) {
//                                 return SNProducttwo(
//                                   id: snProductData['id'],
//                                   sn: snProductData['sn'],
//                                   title: snProductData['title'],
//                                 );
//                               }).toList()
//                             : [],
//                       )
//                     : null,
//               );
//             }).toList()
//           : [],
//       listProductB: orderDatae['expand']['listproductb'] != null
//           ? (orderDatae['expand']['listproductb'] as List).map((productBData) {
//               return ProductBtwo(
//                 id: productBData['id'],
//                 title: productBData['title'],
//                 purchasePrice: productBData['purchaseprice'],
//                 supplier: productBData['supplier'],
//                 days: productBData['days'],
//                 dateCreated: productBData['datecreated'],
//                 dateClearing: productBData['dataclearing'],
//                 number: productBData['number'],
//                 description: productBData['description'],
//                 dateAd: productBData['datead'],
//                 okBuy: productBData['okbuy'],
//                 hurry: productBData['hurry'],
//                 official: productBData['official'],
//               );
//             }).toList()
//           : null,
//     );
//
//     orderstwo.add(order);
//     // }
//   }
//
//
//
//
//
//
//
//
//   //////////
//   List<Product> selectedProductItems = [];
//
//   Future<List<Product>> fetchAllProducts() async {
//     List<Product> allProducts = [];
//     int page = 1;
//     int perPage = 50; // تعداد محصولات در هر صفحه
//
//     while (true) {
//       final resultList = await _pb.collection('product').getList(
//             page: page,
//             perPage: perPage,
//           );
//
//       List<Product> pageItems = resultList.items
//           .map((item) => Product.fromJson(item.toJson()))
//           .toList();
//       if (pageItems.isEmpty) {
//         break; // اگر صفحه خالی باشد، خارج می‌شویم
//       }
//       selectedProductItems.addAll(pageItems);
//       page++;
//     }
//     print('object');
//     update(['product']);
//     return allProducts;
//   }
//
//   /////////////
//   List<Garrantyy> selectedGarrantyItems = [];
//
//   Future<void> fetchSelectedGarrantyItems() async {
//     try {
//       final resultList = await _pb.collection('garrantya').getList();
//       print('dddd' + resultList.items.toString());
//       List<Garrantyy> garrantyItems = [];
//       print(garrantyItems.length);
//       for (var item in resultList.items) {
//         final data = item.toJson();
//         if (data.containsKey('Garrantyname')) {
//           print(item.collectionName.toString());
//           garrantyItems.add(Garrantyy.fromJson(data));
//         }
//       }
//       selectedGarrantyItems = garrantyItems;
//       update(['garrantya']);
//     } catch (error) {
//       print('Error fetching selected garranty items: $error');
//     }
//   }
//
//   Future<List<String>> getProductWarranty(String recordId) async {
//     try {
//       final product =
//           await _pb.collection('listproducta').getOne(recordId, expand: '');
//       List<String> warrantyList =
//           List<String>.from(product.data['garranty'] ?? []);
//       print('Warranty List: $warrantyList');
//       return warrantyList;
//     } catch (error) {
//       print('Error fetching product warranty: $error');
//       return ['NO'];
//     }
//   }
//
//   Future<void> updateProductADiscription(
//       String productId, String discription, bool unavailable) async {
//     try {
//       final body = {
//         'description': discription,
//         'unavailable': unavailable,
//         "name": '${user!.name}',
//         "family": '${user!.family}',
//       };
//       await _pb.collection('listproducta').update(productId, body: body);
//       _fetchAndUpdate();
//       String statusText;
//       Color statusColor;
//
//       if (unavailable) {
//         statusText = 'فعال';
//         statusColor = Colors.green;
//       } else {
//         statusText = 'غیر فعال';
//         statusColor = Colors.orange;
//       }
//
//       Get.snackbar('توضیحات ${discription} ثبت شد ', ' و محصول $statusText',
//           backgroundColor: statusColor);
//     } catch (error) {
//       print('Error updating product A: $error');
//     }
//   }
//
//   Future<void> createorders(OrderTwo order) async {
//     try {
//       final body = <String, dynamic>{
//         "title": order.title,
//         "niyaz": order.niyaz,
//         "phonenumberit": order.phoneNumberIT,
//         "datenow": order.dateNow,
//         "datead": order.dateAd,
//         "winner": '0.25',
//         "callnumber": order.callNumber,
//         "buy": bool.parse(order.buy!) ? 'فروش و اسمبل' : 'فروش',
//         "address": order.address,
//         "type": 'srpipkxuv7v1qrw',
//       };
//
//       final record = await _pb.collection(collectionName).create(body: body);
//       if (record != null) {
//         // add(FetchOrders());
//         //    emit(OrderSuccess('سفارش با موفقیت ثبت شد'));
//       } else {
//         //    emit(OrderError('${record.data.toString()}'));
//       }
//     } catch (e) {
//       //   emit(OrderError(e.toString()));
//     }
//   }
//
//   Future<void> addProductToB(
//       String orderId,
//       String productTitle,
//       String productPrice,
//       String idsupplier,
//       String storedDays,
//       String currentDate,
//       String futureDate,
//       String number,
//       bool okbuy,
//       bool official,
//       bool hurry,
//       String datead,
//       List<ProductBtwo> listProductBb,
//       ProductA productA) async {
//     try {
//       // ایجاد یک محصول جدید و افزودن آن به لیست ورودی
//       // ProductBb newProduct = ProductBb(
//       //   title: productTitle,
//       //   purchaseprice: productPrice,
//       //   supplier: idsupplier,
//       //   days: storedDays,
//       //   datead: currentDate,
//       //   dataclearing: futureDate,
//       //   number: number,
//       //   okbuy: okbuy,
//       //   official: official,
//       //   hurry: hurry,
//       //   datecreated: datead,
//       //   id: '',
//       //   description: '',
//       // );
//       //
//       // // افزودن محصول جدید به لیست محصولات
//       // listProductBb.add(newProduct);
//       //
//       // // پیدا کردن محصولات همنام با productTitle
//       // List<ProductBb> matchingProducts = listProductBb
//       //     .where((product) => product.title == productTitle)
//       //     .toList();
//       //
//       // // محاسبه میانگین قیمت
//       // if (matchingProducts.isNotEmpty) {
//       //   double totalPurchasePrice = 0;
//       //   double totalNumber = 0;
//       //
//       //   for (var product in matchingProducts) {
//       //     double productPrice = double.parse(product.purchaseprice);
//       //     double productNumber = double.parse(product.number);
//       //     totalPurchasePrice += productPrice * productNumber;
//       //     totalNumber += productNumber;
//       //   }
//       //
//       //   double averagePrice = totalPurchasePrice / totalNumber;
//       //   print('Average price of products with title $productTitle: ' +
//       //       averagePrice.toInt().convertToPriceint());
//       //   try {
//       //     final body = {
//       //       'purchaseprice': averagePrice.toInt().convertToPriceint(),
//       //     };
//       //     await _pb.collection('listproducta').update(productA.id, body: body);
//       //   } catch (error) {}
//       // }
//       //
//       // // ایجاد محصول جدید در کلکسیون لیست A در دیتابیس
//       // final productARecord =
//       //     await _pb.collection('listProductBb').create(body: {
//       //   'title': productTitle,
//       //   'purchaseprice': productPrice,
//       //   'supplier': idsupplier,
//       //   'days': storedDays,
//       //   'datecreated': currentDate,
//       //   'dataclearing': futureDate,
//       //   'number': number,
//       //   'okbuy': okbuy,
//       //   'official': official,
//       //   'hurry': hurry,
//       //   'datead': datead,
//       //   "name": '${user!.name}',
//       //   "family": '${user!.family}',
//       // });
//       //
//       // // تبدیل محصول جدید به نقشه برای دسترسی به id
//       // final productAData = productARecord.toJson();
//       //
//       // // دریافت سفارش
//       // final orderRecord = await _pb.collection(collectionName).getOne(orderId);
//       //
//       // // تبدیل سفارش به نقشه برای دسترسی به داده‌ها
//       // final orderData = orderRecord.toJson();
//       //
//       // // اضافه کردن محصول جدید به لیست محصولات A
//       // List<dynamic> listProductAIds = orderData['listProductBb'] ?? [];
//       // listProductAIds.add(productAData['id']);
//       //
//       // // به‌روزرسانی سفارش با لیست محصولات جدید
//       // final body = {
//       //   'listProductBb': listProductAIds,
//       // };
//       //
//       // await _pb.collection(collectionName).update(orderId, body: body);
//       // await _fetchAndUpdate();
//       // notifyListeners();
//     } catch (error) {
//       print('Error adding product to listProductBb: $error');
//     }
//   }
//
//   Future<void> updateProductBb(
//       String productId,
//       String productTitle,
//       String productPrice,
//       String storedDays,
//       String currentDate,
//       String futureDate,
//       String number,
//       bool okbuy,
//       bool hurry,
//       bool official,
//       String futureDateGregorianStringg,
//       List<ProductBb> listb,
//       ProductA proA) async {
//     /////////////
//
//     ////////////
//
//     try {
//       // پیدا کردن محصولات همنام با productTitle
//       List<ProductBb> matchingProducts =
//           listb.where((product) => product.title == productTitle).toList();
//
//       // محاسبه میانگین قیمت
//       if (matchingProducts.isNotEmpty) {
//         double totalPurchasePrice = 0;
//         double totalNumber = 0;
//
//         for (var product in matchingProducts) {
//           double productPrice = double.parse(product.purchaseprice);
//           double productNumber = double.parse(product.number);
//           totalPurchasePrice += productPrice * productNumber;
//           totalNumber += productNumber;
//         }
//
//         double averagePrice = totalPurchasePrice / totalNumber;
//         print('Average price of products with title $productTitle: ' +
//             averagePrice.toInt().convertToPriceint());
//         try {
//           final body = {
//             'purchaseprice': averagePrice.toInt().convertToPriceint(),
//           };
//           await _pb.collection('listproducta').update(proA.id, body: body);
//         } catch (error) {}
//       }
//
//       final body = {
//         'title': productTitle,
//         'purchaseprice': productPrice,
//         'days': storedDays,
//         'datecreated': currentDate,
//         'dataclearing': futureDate,
//         'number': number,
//         'okbuy': okbuy,
//         'hurry': hurry,
//         'official': official,
//         'datead': futureDateGregorianStringg,
//         "name": '${user!.name}',
//         "family": '${user!.family}',
//       };
//       await _pb.collection('listProductBb').update(productId, body: body);
//       await _fetchAndUpdate();
//     } catch (error) {
//       print('Error updating product B: $error');
//     }
//   }
//
//   Future<void> deleteProductBb(String recordId, List<ProductBb> listb,
//       String productTitle, ProductA proA) async {
//     try {
//       ///////////
//       listb.removeWhere((product) => product.id == recordId);
//
//       // پیدا کردن محصولات همنام با productTitle
//       List<ProductBb> matchingProducts =
//           listb.where((product) => product.title == productTitle).toList();
//
//       // محاسبه میانگین قیمت
//       if (matchingProducts.isNotEmpty) {
//         double totalPurchasePrice = 0;
//         double totalNumber = 0;
//
//         for (var product in matchingProducts) {
//           double productPrice = double.parse(product.purchaseprice);
//           double productNumber = double.parse(product.number);
//           totalPurchasePrice += productPrice * productNumber;
//           totalNumber += productNumber;
//         }
//
//         double averagePrice = totalPurchasePrice / totalNumber;
//         print('Average price of products with title $productTitle: ' +
//             averagePrice.toInt().convertToPriceint());
//         try {
//           final body = {
//             'purchaseprice': averagePrice.toInt().convertToPriceint(),
//           };
//           await _pb.collection('listproducta').update(proA.id, body: body);
//         } catch (error) {}
//       }
//
//       //////////
//
//       await _pb.collection('listProductBb').delete(recordId);
//       // fetchAllOrders(); // Refresh the list after deletion
//       _fetchAndUpdate();
//     } catch (error) {
//       print('Error deleting product B: $error');
//     }
//   }
//
//   Future<void> updateProductBbPricepurch(
//     String productId,
//     String productTitle,
//   ) async {
//     try {
//       final body = {
//         'purchaseprice': productTitle,
//         "name": '${user!.name}',
//         "family": '${user!.family}',
//       };
//       await _pb.collection('listproducta').update(productId, body: body);
//       //  await fetchAllOrders();
//       //notifyListeners();
//       _fetchAndUpdate();
//     } catch (error) {
//       print('Error updating product B: $error');
//     }
//   }
//
//   List<Map<String, String>> suppliers = [];
//
//   Future<void> fetchAllSuppliers() async {
//     try {
//       final records = await _pb.collection('suppliers').getFullList();
//       print(records);
//       suppliers = records.map((item) {
//         return {
//           'companyname': item.data['companyname']?.toString() ?? '',
//           'phonenumber': item.data['phonenumber']?.toString() ?? '',
//           'mobilenumber': item.data['mobilenumber']?.toString() ?? '',
//           'address': item.data['address']?.toString() ?? '',
//           'location': item.data['location']?.toString() ?? '',
//           'id': item.id ?? '',
//         };
//       }).toList();
//       print('_suppliers');
//       print(suppliers);
//     } catch (error) {
//       print('Error fetching suppliers: $error');
//     }
//   }
//
//   Supplierr? _supplier;
//   bool _isDataLoading = false;
//
//   Supplierr? get supplierProduct => _supplier;
//
//   bool get isDataLoading => _isDataLoading;
//
//   Future<void> fetchSupplierById(String id) async {
//     _isDataLoading = true;
//     //  notifyListeners();
//
//     try {
//       final record = await _pb.collection('suppliers').getOne(id);
//       _supplier = Supplierr.fromJson(
//           record.toJson()); // تبدیل RecordModel به Map<String, dynamic>
//     } catch (error) {
//       print('Error fetching supplier: $error');
//       _supplier = null;
//     }
//
//     _isDataLoading = false;
//     //   notifyListeners();
//   }
//
//   Future<void> updateProductBbhurry(String productId, bool hurry) async {
//     try {
//       final body = {
//         'hurry': hurry,
//         "name": '${user!.name}',
//         "family": '${user!.family}',
//       };
//       await _pb.collection('listProductBb').update(productId, body: body);
//       await _fetchAndUpdate();
//       // notifyListeners();
//     } catch (error) {
//       print('Error updating product B: $error');
//     }
//   }
//
//   Future<void> updateProductBbokbuy(String productId, bool okbuy) async {
//     try {
//       final body = {
//         'okbuy': okbuy,
//         "name": '${user!.name}',
//         "family": '${user!.family}',
//       };
//       await _pb.collection('listProductBb').update(productId, body: body);
//       await _fetchAndUpdate();
//       //notifyListeners();
//     } catch (error) {
//       print('Error updating product B: $error');
//     }
//   }
// }

/////////////////////////////////////////////////

//0
// class Order {
//   final String id;
//   final String title;
//   final String callnumber;
//   final List<ProductA> listProductA;
//   final List<ProductBb> listProductBb;
//   final String datenow;
//   final String datead;
//   final String address;
//   final String niyaz;
//   final String phonenumberit;
//   final String buy;
//   final String winner;
//   final String created;
//
//   Order({
//     required this.id,
//     required this.title,
//     required this.callnumber,
//     required this.listProductA,
//     required this.listProductBb,
//     required this.datenow,
//     required this.datead,
//     required this.address,
//     required this.niyaz,
//     required this.phonenumberit,
//     required this.buy,
//     required this.winner,
//     required this.created,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json, List<ProductA> productsA,
//       List<ProductBb> productsB) {
//     return Order(
//       id: json['id'].toString(),
//       title: json['title'].toString(),
//       callnumber: json['callnumber'].toString(),
//       listProductA: productsA,
//       listProductBb: productsB,
//       phonenumberit: json['phonenumberit'].toString(),
//       datenow: json['datenow'].toString(),
//       datead: json['datead'].toString(),
//       address: json['address'].toString(),
//       niyaz: json['niyaz'].toString(),
//       buy: json['buy'].toString(),
//       winner: json['winner'].toString(),
//       created: json['created'].toString(),
//     );
//   }
// }
//1_2

class Product {
  final String nameproduct;

  Product({required this.nameproduct});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(nameproduct: json['nameproduct'].toString());
  }
}


class OrderTwo {
  String? id;
  String? title;
  String? callNumber;
  String? dateNow;
  String? dateAd;
  String? address;
  String? niyaz;
  String? phoneNumberIT;
  String? buy;
  String? winner;
  String? created;
  String? registrationNumber;
  String? nationalCode;
  String? postalCode;
  String? economicCode;
  String? accountingNumber;
  String? purchaseNumber;
  String? type;
  List<String>? windowsType;
  List<ProductAtwo>? listProductA;
  List<ProductBtwo>? listProductB;

  OrderTwo({
    this.id,
    this.title,
    this.callNumber,
    this.dateNow,
    this.dateAd,
    this.address,
    this.niyaz,
    this.phoneNumberIT,
    this.buy,
    this.winner,
    this.created,
    this.registrationNumber,
    this.nationalCode,
    this.postalCode,
    this.economicCode,
    this.accountingNumber,
    this.purchaseNumber,
    this.type,
    this.windowsType,
    this.listProductA,
    this.listProductB,
  });
}

class ProductAtwo {
  String? id;
  String? title;
  String? salePrice;
  String? number;
  String? purchasePrice;
  String? description;
  List<String>? garranty;
  bool? unavailable;
  String? percent;
  SellBuyProducttwo? sellBuyProduct;

  ProductAtwo({
    this.id,
    this.title,
    this.salePrice,
    this.number,
    this.purchasePrice,
    this.description,
    this.garranty,
    this.unavailable,
    this.percent,
    this.sellBuyProduct,
  });
}

class ProductBtwo {
  String? id;
  String? title;
  String? purchasePrice;
  String? supplier;
  String? days;
  String? dateCreated;
  String? dateClearing;
  String? number;
  String? description;
  String? dateAd;
  bool? okBuy;
  bool? hurry;
  bool? official;

  ProductBtwo({
    this.id,
    this.title,
    this.purchasePrice,
    this.supplier,
    this.days,
    this.dateCreated,
    this.dateClearing,
    this.number,
    this.description,
    this.dateAd,
    this.okBuy,
    this.hurry,
    this.official,
  });
}

class SellBuyProducttwo {
  String? title;
  String? purchasePrice;
  String? salePrice;
  String? supplier;
  String? number;
  List<String>? garranty;
  List<SNProducttwo>? snBuyProductLogin;

  SellBuyProducttwo({
    this.title,
    this.purchasePrice,
    this.salePrice,
    this.supplier,
    this.number,
    this.garranty,
    this.snBuyProductLogin,
  });
}

class SNProducttwo {
  String? id;
  String? sn;
  String? title;

  SNProducttwo({
    this.id,
    this.sn,
    this.title,
  });
}

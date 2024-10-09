import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart';
import 'package:get/get.dart';
import 'package:project/Drawer/auth_controller.dart';
import 'package:project/Get_X/Controller/ControllerProduct.dart';
import 'package:project/Get_X/Model/buy_product.dart';
import 'package:project/Get_X/Model/listproducta.dart';
import 'package:project/Get_X/Model/listproductb.dart';
import 'package:project/Get_X/Model/login_buy_product_sn.dart';
import 'package:project/Get_X/Model/order.dart';
import 'package:project/Get_X/Model_Category/Garrantyy.dart';
import 'package:project/Get_X/Model_Category/GeneralCategory.dart';
import 'package:project/Get_X/Model_Category/NameProductCategory.dart';
import 'package:project/Get_X/Model_Category/ProductCategory.dart';
import 'package:project/Get_X/Service/PocketBaseService.dart';

class OrderControllerPage extends GetxController {
  final PocketBaseManager _pocketBaseManager;

  OrderControllerPage()
      : _pocketBaseManager =
            PocketBaseManager(url: 'https://saater.liara.run', lang: 'en-US');

  PocketBase get _pb => _pocketBaseManager.client;

  // PocketBaseService _pb = PocketBaseService.instance;
  RxBool isLoading = false.obs;
  RxList<OrderTwo> orderstwo = <OrderTwo>[].obs;
  var currentFilter = ''; // برای فیلتر
  var currentSort = ''; // برای مرتب‌سازی
  var currentPrivate = ''; // برای نوع جستجو
  var currentSearch = ''; // برای جستجو
  var isSearchByTitle = true.obs; // برای کنترل وضعیت جستجو
  var buyProducts = <SellBuyProducttwo>[];
  late Timer _timer;

  String? selectedSupplierID;
  String? selectedSupplierCompanyName;
  String? selectedSupplierPhoneNumber;
  String? selectedSupplierMobileNumber;
  String? selectedSupplierAddress;
  String? selectedSupplierLocation;
  List<Map<String, String>> suppliers = [];

  void FetchSupplier(String? companyName) {
    final supplier = suppliers
        .firstWhere((element) => element['companyname'] == companyName);

    selectedSupplierCompanyName = supplier['companyname'];
    selectedSupplierPhoneNumber = supplier['phonenumber'];
    selectedSupplierMobileNumber = supplier['mobilenumber'];
    selectedSupplierAddress = supplier['address'];
    selectedSupplierLocation = supplier['location'];
    selectedSupplierID = supplier['id'];

    update(); // به‌روزرسانی ویو
  }

  Future<void> updateOrderrating(String id, int rating) async {
    final body = <String, dynamic>{
      "rating": rating,
    };

    print('id: $id, winner: $rating');

    try {
      final RecordModel record =
          await _pb.collection('order').update(id, body: body);
      print('API Response: $record');
      fetchAllOrders();
      // if (record != null) {
      //   // دریافت مقدار winner از پاسخ با استفاده از toJson()
      //   Map<String, dynamic> recordMap = record.toJson();
      //   String updatedWinner = recordMap['winner'] ?? '';
      //
      //   if (updatedWinner == winner) {
      //     print('Winner updated successfully and matches the input value.');
      //     emit(OrderSuccessIndetator('سفارش به روز شد در صورتی که با خطا مواجه نشود'));
      //   } else {
      //     print('Winner updated successfully but does not match the input value.');
      //     emit(OrderSuccessIndetator('سفارش به روز شد در صورتی که با خطا مواجه نشود'));
      //   }
      //
      //   print('OrderSuccessIndetator emitted');
      //   add(FetchOrders());
      // } else {
      //   emit(OrderFailureIndetator('با خطا مواجه شد'));
      //   print('OrderFailureIndetator error emitted');
      // }
    } catch (error) {
      // emit(OrderFailureIndetator('اینترنت را بررسی کنید => عدم دسترسی سرور: $error'));
      print('OrderFailureIndetator catch error emitted: $error');
    }
  }

  Future<void> updateOrderIndecator(String id, String winner) async {
    final body = <String, dynamic>{
      "winner": winner,
    };

    print('id: $id, winner: $winner');

    try {
      final RecordModel record =
          await _pb.collection('order').update(id, body: body);
      print('API Response: $record');
      fetchAllOrders();
      // if (record != null) {
      //   // دریافت مقدار winner از پاسخ با استفاده از toJson()
      //   Map<String, dynamic> recordMap = record.toJson();
      //   String updatedWinner = recordMap['winner'] ?? '';
      //
      //   if (updatedWinner == winner) {
      //     print('Winner updated successfully and matches the input value.');
      //     emit(OrderSuccessIndetator('سفارش به روز شد در صورتی که با خطا مواجه نشود'));
      //   } else {
      //     print('Winner updated successfully but does not match the input value.');
      //     emit(OrderSuccessIndetator('سفارش به روز شد در صورتی که با خطا مواجه نشود'));
      //   }
      //
      //   print('OrderSuccessIndetator emitted');
      //   add(FetchOrders());
      // } else {
      //   emit(OrderFailureIndetator('با خطا مواجه شد'));
      //   print('OrderFailureIndetator error emitted');
      // }
    } catch (error) {
      // emit(OrderFailureIndetator('اینترنت را بررسی کنید => عدم دسترسی سرور: $error'));
      print('OrderFailureIndetator catch error emitted: $error');
    }
  }

  Future<void> addProductToBuyProductByGaranty({
    required String title,
    required String supplierId,
    required String days,
    required String dateCreated,
    required String dataClearing,
    required String number,
    required String dateAd,
    required bool hurry,
    required bool official,
    required String purchasePrice,
    required String orderID,
    required String idproduct,
    required String idupdate,
    required String percent,
    required String saleprice,
    required bool valuable,
    required String titlecategory,
    required List<String> garanty,
  }) async {
    try {
//check koneh bebeneh
      final productRecordcheck =
          await _pb.collection('name_product_category').getOne(idproduct);

      String currentNumberStrche =
          productRecordcheck.data['number'].toString() ?? "0"; // تبدیل به رشته
      int currentNumberchek = int.tryParse(currentNumberStrche) ?? 0;
      // if (currentNumberchek > int.parse(number) ||
      //     currentNumberchek == int.parse(number)) {
      // ساخت یک رکورد جدید در جدول buy_product
      final record = await _pb.collection('buy_product').create(
        body: {
          "title": title,
          "name_product_category": titlecategory,
          // "supplier": supplierId,
          "days": days,
          "datecreated": dateCreated,
          "dataclearing": dataClearing,
          "type_order": 'فروش',
          "number": number,
          "datead": dateAd,
          "hurry": hurry,
          "official": official,
          "purchaseprice": purchasePrice,
          "percent": percent,
          "saleprice": saleprice,
          "valuable": valuable,
          "name": '${user!.name}',
          "family": '${user!.family}',
          'garranty': garanty,
        },
      );
      print('inmanm');
      //   print(orderID);
      //   print(idproduct);
      //   print(idupdate);
      // دریافت رکوردهای فعلی order_buy_product
      final body = <String, dynamic>{
        "sell_buy_product": record.id,
      };
      await _pb.collection('listproducta').update(orderID, body: body);

      // دریافت رکوردهای فعلی name_product_category
      final productRecord =
          await _pb.collection('name_product_category').getOne(idproduct);
      List<dynamic> existingBuyProductCategory =
          productRecord.data['buy_product'] ?? [];
      existingBuyProductCategory.add(record.id);

      // به‌روزرسانی رکورد order_buy_product با لیست به‌روز شده

      // به‌روزرسانی رکورد name_product_category با لیست به‌روز شده
      // استخراج مقدار فعلی number از رکورد name_product_category
      String currentNumberStr =
          productRecord.data['number'].toString() ?? "0"; // تبدیل به رشته
      int currentNumber = int.tryParse(currentNumberStr) ?? 0;
      //   print('Current number in name_product_category: $currentNumber');

      // تبدیل number ورودی به عدد و جمع با مقدار فعلی
      int newNumber = int.tryParse(number) ?? 0;
      int updatedNumber = currentNumber - newNumber;
      final bodyproduct = <String, dynamic>{
        //  "number": updatedNumber.toString(), // تبدیل عدد به رشته
        "buy_product": existingBuyProductCategory,
      };
      await _pb
          .collection('name_product_category')
          .update(idproduct, body: bodyproduct);
      // final bodyproductbuy = <String, dynamic>{
      //   "inventory": currentNumberStr, // تبدیل عدد به رشته
      //   "Number_of_inventory": newNumber, // تبدیل عدد به رشته
      //   "number_now": updatedNumber.toString(), // تبدیل عدد به رشته
      //   // "number": updatedNumber.toString(), // تبدیل عدد به رشته
      //   // "buy_product": existingBuyProductCategory,
      // };
      // await _pb
      //     .collection('buy_product')
      //     .update(record.id, body: bodyproductbuy);

      print(record.id);
      print(idupdate);
      print(idproduct);
      print(orderID);
      fetchGeneralCategories();
      fetchNameProductCategory(idproduct);
      fetchBuyProductsById(idproduct);
      // } else {
      //   String statusText = 'عدم هماهنگی موجودی';
      //   Color statusColor;
      //
      //   //statusText = 'تذکر';
      //
      //   statusColor = Colors.orange;
      //   Get.snackbar('توضیحات ${statusText}  ', ' و محصول $statusText',
      //       backgroundColor: statusColor);
      // }
    } catch (error) {
      print('Error adding product: $error');
    }
  }

  Future<void> addProductToBuyProduct({
    required String title,
    required String supplierId,
    required String days,
    required String dateCreated,
    required String dataClearing,
    required String number,
    required String dateAd,
    required bool hurry,
    required bool official,
    required String purchasePrice,
    required String orderID,
    required String idproduct,
    required String idupdate,
    required String percent,
    required String saleprice,
    required bool valuable,
    required String titlecategory,
  }) async {
    try {
      //check koneh bebeneh
      final productRecordcheck =
          await _pb.collection('name_product_category').getOne(idproduct);

      String currentNumberStrche =
          productRecordcheck.data['number'].toString() ?? "0"; // تبدیل به رشته
      int currentNumberchek = int.tryParse(currentNumberStrche) ?? 0;
      // if (currentNumberchek > int.parse(number) ||
      //     currentNumberchek == int.parse(number)) {
      // ساخت یک رکورد جدید در جدول buy_product
      final record = await _pb.collection('buy_product').create(
        body: {
          "title": title,
          "name_product_category": titlecategory,
          //  "supplier": supplierId,
          "days": days,
          "datecreated": dateCreated,
          "type_order": 'فروش',
          "dataclearing": dataClearing,
          "number": number,
          "datead": dateAd,
          "hurry": hurry,
          "official": official,
          "purchaseprice": purchasePrice,
          "percent": percent,
          "saleprice": saleprice,
          "valuable": valuable,
          "name": '${user!.name}',
          "family": '${user!.family}',
        },
      );
      print('inmanm');
      //  print(orderID);
      // دریافت رکوردهای فعلی order_buy_product
      // final orderRecord =
      //     await _pb.collection('listproducta').getOne(orderID);
      // List<dynamic> existingBuyProductOrder =
      //     orderRecord.data['sell_buy_product'] ?? [];
      // existingBuyProductOrder.add(record.id);
      final body = <String, dynamic>{
        "sell_buy_product": record.id,
      };
      await _pb.collection('listproducta').update(orderID, body: body);

      // دریافت رکوردهای فعلی name_product_category
      final productRecord =
          await _pb.collection('name_product_category').getOne(idproduct);
      List<dynamic> existingBuyProductCategory =
          productRecord.data['buy_product'] ?? [];
      existingBuyProductCategory.add(record.id);

      // به‌روزرسانی رکورد order_buy_product با لیست به‌روز شده

      // به‌روزرسانی رکورد name_product_category با لیست به‌روز شده
      // استخراج مقدار فعلی number از رکورد name_product_category
      String currentNumberStr =
          productRecord.data['number'].toString() ?? "0"; // تبدیل به رشته
      int currentNumber = int.tryParse(currentNumberStr) ?? 0;
      //  print('Current number in name_product_category: $currentNumber');

      // تبدیل number ورودی به عدد و جمع با مقدار فعلی
      int newNumber = int.tryParse(number) ?? 0;
      int updatedNumber = currentNumber - newNumber;
      final bodyproduct = <String, dynamic>{
        //   "number": updatedNumber.toString(), // تبدیل عدد به رشته
        "buy_product": existingBuyProductCategory,
      };
      await _pb
          .collection('name_product_category')
          .update(idproduct, body: bodyproduct);
      // final bodyproductbuy = <String, dynamic>{
      //   "inventory": currentNumberStr, // تبدیل عدد به رشته
      //   "Number_of_inventory": newNumber, // تبدیل عدد به رشته
      //   "number_now": updatedNumber.toString(), // تبدیل عدد به رشته
      //   // "number": updatedNumber.toString(), // تبدیل عدد به رشته
      //   // "buy_product": existingBuyProductCategory,
      // };
      // await _pb
      //     .collection('buy_product')
      //     .update(record.id, body: bodyproductbuy);

      print(record.id);
      print(idupdate);
      print(idproduct);
      print(orderID);
      fetchGeneralCategories();
      fetchNameProductCategory(idproduct);
      fetchBuyProductsById(idproduct);
      // } else {
      //   String statusText = 'عدم هماهنگی موجودی';
      //   Color statusColor;
      //
      //   //statusText = 'تذکر';
      //
      //   statusColor = Colors.orange;
      //   Get.snackbar('توضیحات ${statusText}  ', ' و محصول $statusText',
      //       backgroundColor: statusColor);
      // }

      //  print('Product added successfully: ${record.id}');
    } catch (error) {
      print('Error adding product: $error');
    }
  }

  @override
  void onInit() {
    super.onInit();

    insializ();
    startAutoRefresh();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  void insializ() async {
    user = await authController.getUser();
    isLoading.value = true;
    await fetchAllOrders();
    await fetchGeneralCategories();

    isLoading.value = false;
  }

  void startAutoRefresh() {
    _timer = Timer.periodic(Duration(seconds: 6), (timer) {
      fetchAndUpdate();
    });
  }

  Future<void> fetchAllOrders() async {
    await fetchAndUpdate();
  }

  String _buildFilterQuery() {
    List<String> filters = [];
    if (currentPrivate.isNotEmpty)
      filters.add('type_order = "${currentPrivate}"');

    if (currentSearch.isNotEmpty) {
      if (isSearchByTitle.value) {
        filters.add('title ~ "${currentSearch}"');
      } else {
        filters.add('niyaz ~ "${currentSearch}"');
      }
    }

    if (currentFilter.isNotEmpty) filters.add(currentFilter);
    return filters.join(' && ');
  }

  Future<void> fetchAllOrdersRefresh() async => await fetchAndUpdate();

  Future<void> fetchAllOrdersSearch(String search) async {
    currentSearch = search;

    // اگر رشته جستجو خالی است، کل لیست موجود را نمایش بده
    if (search.isEmpty) {
      // نمایش کل اطلاعات موجود بدون درخواست به سرور
      orderstwo.refresh(); // بازآوری لیست فعلی به کاربر
    } else {
      // جستجو در اطلاعات موجود
      var filteredOrders = orderstwo.where((order) {
        if (isSearchByTitle.value) {
          return order.title!.contains(search);
        } else {
          return order.niyaz!.contains(search);
        }
      }).toList();

      // نمایش نتیجه جستجو به کاربر
      orderstwo.assignAll(filteredOrders);
    }

    // درخواست جدید برای به‌روزرسانی داده‌ها از سرور
    await fetchAllOrdersRefresh();
  }

  Future<void> fetchAllOrdersFilter(String filter) async {
    currentFilter = filter;
    await fetchAllOrdersRefresh();
  }

  Future<void> fetchAllOrdersSort(String sort) async {
    currentSort = sort;
    await fetchAllOrdersRefresh();
  }

  Future<void> fetchAllOrdersPrivate(String private) async {
    currentPrivate = private;
    await fetchAllOrdersRefresh();
  }

  Future<void> fetchAndUpdate() async {
    try {
      int page = 1;
      int pageSize = 50;
      isLoading.value = true;

      // ساخت پرس و جوی فیلتر شده
      String filterQuery = _buildFilterQuery();

      List<OrderTwo> fetchedOrders = [];

      while (true) {
        final ordersRecord = await _pb.collection('order').getList(
              page: page,
              perPage: pageSize,
              filter: filterQuery.isNotEmpty ? filterQuery : null,
              sort: currentSort.isNotEmpty ? currentSort : '-created',
              expand:
                  'listproducta,listproductb,listproducta.sell_buy_product,listproducta.sell_buy_product.sn_buy_product_login',
            );

        if (ordersRecord.items.isEmpty) break;

        for (var ordera in ordersRecord.items) {
          await Future.delayed(
              Duration(milliseconds: 3)); // برای جلوگیری از لود بیش از حد
          Map<String, dynamic> orderDatae = ordera.toJson();

          // ساخت یک OrderTwo جدید از داده‌های برگشتی
          OrderTwo order = OrderTwo(
            id: orderDatae['id'],
            title: orderDatae['title'],
            callNumber: orderDatae['callnumber'],
            dateNow: orderDatae['datenow'],
            dateAd: orderDatae['datead'],
            address: orderDatae['address'],
            niyaz: orderDatae['niyaz'],
            phoneNumberIT: orderDatae['phonenumberit'],
            buy: orderDatae['buy'],
            winner: orderDatae['winner'],
            name: orderDatae['name'],
            family: orderDatae['family'],
            created: orderDatae['created'],
            type_order: orderDatae['type_order'],
            registrationNumber: orderDatae['registration_number'],
            nationalCode: orderDatae['national_code'],
            postalCode: orderDatae['postal_code'],
            economicCode: orderDatae['economic_code'],
            accountingNumber: orderDatae['accounting_number'],
            purchaseNumber: orderDatae['purchase_number'],
            rating: orderDatae['rating'],
            type: orderDatae['type'],
            windowsType: orderDatae['windows_type'] != null
                ? List<String>.from(orderDatae['windows_type'])
                : null,
            listProductA: orderDatae['expand']?.containsKey('listproducta') ==
                    true
                ? (orderDatae['expand']['listproducta'] as List)
                    .map((productAData) {
                    return ProductAtwo(
                      id: productAData['id'],
                      title: productAData['title'],
                      salePrice: productAData['saleprice'],
                      number: productAData['number'],
                      purchasePrice: productAData['purchaseprice'],
                      description: productAData['description'],
                      garranty: productAData.containsKey('garranty') &&
                              productAData['garranty'] != null
                          ? List<String>.from(productAData['garranty'])
                          : [],
                      unavailable: productAData['unavailable'],
                      percent: productAData['percent'],
                      sellBuyProduct: productAData['expand']
                                  ?.containsKey('sell_buy_product') ==
                              true
                          ? SellBuyProducttwo(
                              dateClearing: productAData['expand']
                                  ['sell_buy_product']['dataclearing'],
                              dateCreated: productAData['expand']
                                  ['sell_buy_product']['datecreated'],
                              days: productAData['expand']['sell_buy_product']
                                  ['days'],
                              family: productAData['expand']['sell_buy_product']
                                  ['family'],
                              inventory: productAData['expand']
                                  ['sell_buy_product']['inventory'],
                              name: productAData['expand']['sell_buy_product']
                                  ['name'],
                              numberNow: productAData['expand']
                                  ['sell_buy_product']['number_now'],
                              numberOfInventory: productAData['expand']
                                  ['sell_buy_product']['Number_of_inventory'],
                              typeOrder: productAData['expand']
                                  ['sell_buy_product']['type_order'],
                              expectation: productAData['expand']
                                  ['sell_buy_product']['expectation'],
                              hurry: productAData['expand']['sell_buy_product']
                                  ['hurry'],
                              official: productAData['expand']
                                  ['sell_buy_product']['official'],
                              receive: productAData['expand']
                                  ['sell_buy_product']['receive'],
                              id: productAData['expand']['sell_buy_product']
                                  ['id'],
                              title: productAData['expand']['sell_buy_product']
                                  ['title'],
                              purchasePrice: productAData['expand']
                                  ['sell_buy_product']['purchaseprice'],
                              salePrice: productAData['expand']
                                  ['sell_buy_product']['saleprice'],
                              supplier: productAData['expand']
                                  ['sell_buy_product']['supplier'],
                              number: productAData['expand']['sell_buy_product']
                                  ['number'],
                              garranty: productAData['expand']
                                              ['sell_buy_product']
                                          .containsKey('garranty') &&
                                      productAData['expand']['sell_buy_product']
                                              ['garranty'] !=
                                          null
                                  ? List<String>.from(productAData['expand']
                                      ['sell_buy_product']['garranty'])
                                  : [],
                              snBuyProductLogin: productAData['expand']
                                              ['sell_buy_product']['expand']
                                          ?.containsKey(
                                              'sn_buy_product_login') ==
                                      true
                                  ? (productAData['expand']['sell_buy_product']
                                              ['expand']['sn_buy_product_login']
                                          as List)
                                      .map((snProductData) {
                                      return SNProducttwo(
                                        id: snProductData['id'],
                                        sn: snProductData['sn'],
                                        title: snProductData['title'],
                                      );
                                    }).toList()
                                  : [],
                            )
                          : null,
                    );
                  }).toList()
                : [],
            listProductB: orderDatae['expand']['listproductb'] != null
                ? (orderDatae['expand']['listproductb'] as List)
                    .map((productBData) {
                    return ProductBtwo(
                      id: productBData['id'],
                      title: productBData['title'],
                      purchasePrice: productBData['purchaseprice'],
                      supplier: productBData['supplier'],
                      days: productBData['days'],
                      dateCreated: productBData['datecreated'],
                      dateClearing: productBData['dataclearing'],
                      number: productBData['number'],
                      description: productBData['description'],
                      dateAd: productBData['datead'],
                      okBuy: productBData['okbuy'],
                      hurry: productBData['hurry'],
                      official: productBData['official'],
                    );
                  }).toList()
                : null,
          );

          // اضافه کردن سفارش جدید به لیست
          fetchedOrders.add(order);
        }

        page++;
      }
      print('biofpo');
      // جایگزینی لیست قدیمی با لیست جدید
      orderstwo.assignAll(fetchedOrders);
      print('hihi');
      update(['orderssupdate']);
      // for (var s in orderstwo) {
      //   // اطمینان از اینکه listProductA خالی نیست
      //   if (s.listProductA != null) {
      //     for (int e = 0; e < s.listProductA!.length; e++) {
      //       // بررسی اینکه sellBuyProduct وجود دارد
      //       if (s.listProductA![e].sellBuyProduct != null) {
      //         print('${s.listProductA![e].sellBuyProduct!.id}');
      //       } else {
      //         print('SellBuyProduct is null for product at index $e');
      //       }
      //     }
      //   } else {
      //     print('listProductA is null for order: ${s.id}');
      //   }
      // }
    } catch (error) {
      print('Error fetching orders: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBuyProductsById(String id) async {
    try {
      // گرفتن لیست کامل از جدول name_product_category
      final resultList =
          await _pb.collection('name_product_category').getFullList(
                filter: 'id = "$id"',
                expand:
                    'buy_product.sn_buy_product_login', // مشخص کردن جداول مورد نظر در expand
              );

      // print("Result List: ${resultList.map((r) => r.toJson()).toList()}");

      for (var record in resultList) {
        // تبدیل داده‌های رکورد به Map
        var recordData = record.toJson() as Map<String, dynamic>;
        //  print("Record Data: $recordData");

        // پردازش داده‌های SN_BUY_PRODUCT_LOGIN
        var buyProductData = recordData['expand']?['buy_product'] as List?;
        // print("Buy Product Data: $buyProductData");

        List<SellBuyProducttwo> buyProducts = [];

        if (buyProductData != null) {
          for (var buyProductJson in buyProductData) {
            var snBuyProductLoginData =
                buyProductJson['expand']?['sn_buy_product_login'];
            // print(
            //     "SN_BUY_PRODUCT_LOGIN Data for product ${buyProductJson['id']}: $snBuyProductLoginData");

            List<SNProducttwo> snBuyProductLogins = [];

            if (snBuyProductLoginData is List) {
              snBuyProductLogins =
                  snBuyProductLoginData.map((loginBuyProductJson) {
                return SNProducttwo.fromJson(
                    Map<String, dynamic>.from(loginBuyProductJson));
              }).toList();
            }

            // ایجاد یک شیء BuyProduct
            SellBuyProducttwo product = SellBuyProducttwo.fromJson(
              Map<String, dynamic>.from(buyProductJson),
              snBuyProductLogins,
            );

            // لاگ‌گذاری اطلاعات محصول
            // print("Product Title: ${product.title}");
            // print(
            //     "Number of SN_BUY_PRODUCT_LOGIN: ${product.snBuyProductLogin!.length}");

            // اضافه کردن به لیست محصولات
            buyProducts.add(product);
          }
        }

        // ذخیره محصولات در متغیر buyProducts
        this.buyProducts = buyProducts;
        //  print("Total Products: ${this.buyProducts.length}");
        update();
        //  update(['productbuy']);
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  var generalCategories = <GeneralCategory>[];

  Future<void> fetchGeneralCategories() async {
    generalCategories.clear();
    int page = 1;
    try {
      while (true) {
        final resultList = await _pb.collection('general_category').getList(
              page: page,
              perPage: 50,
              expand: 'product_category.name_product_category',
            );

        if (resultList.items.isEmpty) {
          break;
        }

        List<GeneralCategory> fetchedCategories = [];

        for (var record in resultList.items) {
          var recordData = record.toJson() as Map<String, dynamic>;

          // پردازش داده‌های product_category
          var productCategoriesData = recordData['expand']?['product_category'];
          List<ProductCategory> productCategories = [];

          if (productCategoriesData is List) {
            productCategories =
                productCategoriesData.map((productCategoryJson) {
              var nameProductCategoriesData =
                  productCategoryJson['expand']?['name_product_category'];
              List<NameProductCategory> nameProductCategories = [];

              if (nameProductCategoriesData is List) {
                nameProductCategories =
                    nameProductCategoriesData.map((nameProductCategoryJson) {
                  return NameProductCategory.fromJson(
                      Map<String, dynamic>.from(nameProductCategoryJson));
                }).toList();
              }

              return ProductCategory.fromJson(
                Map<String, dynamic>.from(productCategoryJson),
                nameProductCategories,
              );
            }).toList();
          }

          GeneralCategory generalCategory = GeneralCategory.fromJson(
            Map<String, dynamic>.from(recordData),
            productCategories,
          );

          fetchedCategories.add(generalCategory);
        }

        generalCategories.addAll(fetchedCategories);
        update();
        //update(["update"]); // به‌روزرسانی UI پس از بارگذاری داده‌ها
        page++;
      }
    } catch (error) {
      print('Error fetching general categories: $error');
    }
  }

  NameProductCategory? nameProductCategorys;

  // متد برای دریافت داده‌ها
  Future<void> fetchNameProductCategory(String orderId) async {
    try {
      // فراخوانی متد و ذخیره نتیجه در متغیر
      nameProductCategorys = await getnameproductcategory_one(orderId);

      // به‌روزرسانی ویو
      // update(['productD']);
      update();
    } catch (e) {
      print('Error fetching category: $e');
    }
  }

  Future<NameProductCategory?> getnameproductcategory_one(
      String orderId) async {
    try {
      // دریافت رکورد از جدول 'name_product_category'
      final productRecord =
          await _pb.collection('name_product_category').getOne(orderId);

      // تبدیل داده‌های JSON به شیء NameProductCategory
      NameProductCategory nameProductCategory =
          NameProductCategory.fromJsonNotID(productRecord.data, orderId);

      //  print(productRecord.data.toString());

      // دسترسی به خصوصیات شیء
      // print('ID: ${nameProductCategory.id}');
      // print('Title: ${nameProductCategory.title}');
      // print('Number: ${nameProductCategory.number}');

      // تبدیل مقدار number به عدد و چاپ
      int currentNumber = int.tryParse(nameProductCategory.number) ?? 0;
      //print('Current number in name_product_category: $currentNumber');

      // بازگرداندن شیء NameProductCategory
      return nameProductCategory;
    } catch (e) {
      // چاپ خطا در صورت بروز مشکل
      print('Error fetching category: $e');
      // بازگرداندن null در صورت بروز خطا
      return null;
    }
  }

  Timer? _debounce; // متغیر برای ذخیره تایمر

  Future<void> updateProductBPricepurch(
    String productId,
    String productTitle,
  ) async {
    // اگر تایمر قبلاً وجود دارد، آن را لغو کنید
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // ایجاد یک تایمر جدید
    _debounce = Timer(const Duration(milliseconds: 100), () async {
      try {
        final body = {
          'purchaseprice': productTitle,
        };
        await _pb.collection('listproducta').update(productId, body: body);
        fetchAndUpdate();
      } catch (error) {
        print('Error updating product B: $error');
      }
    });
  }

  Future<void> updateProductADiscription(
      String productId, String discription, bool unavailable) async {
    try {
      final body = {
        'description': discription,
        'unavailable': unavailable,
      };
      await _pb.collection('listproducta').update(productId, body: body);
      fetchAndUpdate();
      String statusText;
      Color statusColor;

      if (unavailable) {
        statusText = 'فعال';
        statusColor = Colors.green;
      } else {
        statusText = 'غیر فعال';
        statusColor = Colors.orange;
      }

      Get.snackbar('توضیحات ${discription} ثبت شد ', ' و محصول $statusText',
          backgroundColor: statusColor);
    } catch (error) {
      print('Error updating product A: $error');
    }
  }

  Future<void> deleteBuyId_BuyProdut(String idbuyproduct, String number,
      String idproductnameproductcategory) async {
    try {
      // print(number);
      // print(idbuyproduct);
      // print(idproductnameproductcategory);
      final productRecord = await _pb
          .collection('name_product_category')
          .getOne(idproductnameproductcategory);
      String currentNumberStr =
          productRecord.data['number'].toString() ?? "0"; // تبدیل به رشته
      int currentNumber = int.tryParse(currentNumberStr) ?? 0;
      print('Current number in name_product_category: $currentNumber');
      // تبدیل number ورودی به عدد و جمع با مقدار فعلی
      int newNumber = int.tryParse(number) ?? 0;
      if (currentNumber > int.parse(number) ||
          currentNumber == int.parse(number)) {
        int updatedNumber = currentNumber + newNumber;

        final body = <String, dynamic>{
          "number": updatedNumber,
        };
        await _pb
            .collection('name_product_category')
            .update(idproductnameproductcategory, body: body);

        await _pb.collection('buy_product').delete(idbuyproduct);
        Get.snackbar(' موفق', 'سفارش شما با موفقیت حذف شد.',
            backgroundColor: Colors.green);

        fetchGeneralCategories();
        fetchNameProductCategory(idproductnameproductcategory);
        fetchBuyProductsById(idproductnameproductcategory);
      } else {
        Get.snackbar('ناموفق',
            'تعداد کالا موجود انبار با تعداد کالای مورد حدف شده مطابقت ندارد',
            backgroundColor: Colors.orange);
      }
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  Future<bool> addProductToA(
      String orderId,
      String productTitle,
      String productPrice,
      String number,
      ControllerProduct controllerProduct) async {
    final resultList = await _pb.collection('product').getList(
          filter: 'nameproduct="${productTitle}"',
        );

    if (resultList.items.isEmpty) {
      final productARecord = await _pb.collection('product').create(body: {
        'nameproduct': productTitle,
      });
      try {
        // ایجاد محصول جدید در کلکسیون لیست A
        final productARecord =
            await _pb.collection('listproducta').create(body: {
          'title': productTitle,
          'pricesell': productPrice,
          'number': number,
          'unavailable': true,
          'saleprice': '0',
        });

        // تبدیل محصول جدید به نقشه برای دسترسی به id
        final productAData = productARecord.toJson();

        // دریافت سفارش
        final orderRecord = await _pb.collection('order').getOne(orderId);

        // تبدیل سفارش به نقشه برای دسترسی به داده‌ها
        final orderData = orderRecord.toJson();

        // اضافه کردن محصول جدید به لیست محصولات A
        List<dynamic> listProductAIds = orderData['listproducta'] ?? [];
        listProductAIds.add(productAData['id']);

        // به‌روزرسانی سفارش با لیست محصولات جدید
        final body = {
          'listproducta': listProductAIds,
        };

        await _pb.collection('order').update(orderId, body: body);

        //  _fetchAndUpdate();
        Get.snackbar('محصول با نام ${productTitle}',
            'به تعداد ${number}  با موفقیت ثبت شد .');
        controllerProduct.fetchAllProducts();
        return true;
      } catch (error) {
        print('Error adding product to listProductA: $error');
        return false;
      }
    } else {
      try {
        // ایجاد محصول جدید در کلکسیون لیست A
        final productARecord =
            await _pb.collection('listproducta').create(body: {
          'title': productTitle,
          'pricesell': productPrice,
          'number': number,
          'unavailable': true,
          'saleprice': '0',
        });

        // تبدیل محصول جدید به نقشه برای دسترسی به id
        final productAData = productARecord.toJson();

        // دریافت سفارش
        final orderRecord = await _pb.collection('order').getOne(orderId);

        // تبدیل سفارش به نقشه برای دسترسی به داده‌ها
        final orderData = orderRecord.toJson();

        // اضافه کردن محصول جدید به لیست محصولات A
        List<dynamic> listProductAIds = orderData['listproducta'] ?? [];
        listProductAIds.add(productAData['id']);

        // به‌روزرسانی سفارش با لیست محصولات جدید
        final body = {
          'listproducta': listProductAIds,
        };

        await _pb.collection('order').update(orderId, body: body);
        controllerProduct.fetchAllProducts();
        //   _fetchAndUpdate();
        Get.snackbar('محصول با نام ${productTitle}',
            'به تعداد ${number}  با موفقیت ثبت شد .');
        return true;
      } catch (error) {
        print('Error adding product to listProductA: $error');
        return false;
      }
    }
  }

  Future<bool> addProductToAGranty(
      String orderId,
      String productTitle,
      String productPrice,
      List<String> g,
      String number,
      ControllerProduct controllerProduct) async {
    final resultList = await _pb.collection('product').getList(
          filter: 'nameproduct="${productTitle}"',
        );

    if (resultList.items.isEmpty) {
      final productARecord = await _pb.collection('product').create(body: {
        'nameproduct': productTitle,
      });
      try {
        // ایجاد محصول جدید در کلکسیون لیست A
        final productARecord =
            await _pb.collection('listproducta').create(body: {
          'title': productTitle,
          'garranty': g,
          'number': number,
          'unavailable': true,
          'saleprice': '0',
        });

        // تبدیل محصول جدید به نقشه برای دسترسی به id
        final productAData = productARecord.toJson();

        // دریافت سفارش
        final orderRecord = await _pb.collection('order').getOne(orderId);

        // تبدیل سفارش به نقشه برای دسترسی به داده‌ها
        final orderData = orderRecord.toJson();

        // اضافه کردن محصول جدید به لیست محصولات A
        List<dynamic> listProductAIds = orderData['listproducta'] ?? [];
        listProductAIds.add(productAData['id']);

        // به‌روزرسانی سفارش با لیست محصولات جدید
        final body = {
          'listproducta': listProductAIds,
        };

        await _pb.collection('order').update(orderId, body: body);
        // _fetchAndUpdate();
        controllerProduct.fetchAllProducts();
        Get.snackbar('محصول با نام ${productTitle}',
            'به تعداد ${number}و با این گارانتی ${g}  با موفقیت ثبت شد .');
        return true;
      } catch (error) {
        print('Error adding product to listProductA: $error');
        Get.snackbar('محصول با نام ${productTitle}', 'ثبت نشد',
            backgroundColor: Colors.red[300]);
        return false;
      }
    } else {
      try {
        // ایجاد محصول جدید در کلکسیون لیست A
        final productARecord =
            await _pb.collection('listproducta').create(body: {
          'title': productTitle,
          'garranty': g,
          'number': number,
          'unavailable': true,
          'saleprice': '0',
        });

        // تبدیل محصول جدید به نقشه برای دسترسی به id
        final productAData = productARecord.toJson();

        // دریافت سفارش
        final orderRecord = await _pb.collection('order').getOne(orderId);

        // تبدیل سفارش به نقشه برای دسترسی به داده‌ها
        final orderData = orderRecord.toJson();

        // اضافه کردن محصول جدید به لیست محصولات A
        List<dynamic> listProductAIds = orderData['listproducta'] ?? [];
        listProductAIds.add(productAData['id']);

        // به‌روزرسانی سفارش با لیست محصولات جدید
        final body = {
          'listproducta': listProductAIds,
        };

        await _pb.collection('order').update(orderId, body: body);
        //  _fetchAndUpdate();
        Get.snackbar('محصول با نام ${productTitle}',
            'به تعداد ${number}و با این گارانتی ${g}  با موفقیت ثبت شد .');
        controllerProduct.fetchAllProducts();
        return true;
      } catch (error) {
        print('Error adding product to listProductA: $error');
        Get.snackbar('محصول با نام ${productTitle}', 'ثبت نشد',
            backgroundColor: Colors.red[300]);
        return false;
      }
    }
  }

  Future<void> deleteProductA(String recordId) async {
    try {
      await _pb.collection('listproducta').delete(recordId);
      //
      fetchAndUpdate();
    } catch (error) {
      print('Error deleting product A: $error');
    }
  }

  Future<String> createorders(OrderTwo order, String? selectedValue) async {
    final user = await authController.getUser();

    try {
      final body = <String, dynamic>{
        "title": order.title,
        "niyaz": order.niyaz,
        "phonenumberit": order.phoneNumberIT,
        "datenow": order.dateNow,
        "datead": order.dateAd,
        "type_order": selectedValue,
        "winner": '0.25',
        "callnumber": order.callNumber,
        "buy": bool.parse(order.buy!) ? 'فروش و اسمبل' : 'فروش',
        "address": order.address,
        "type": 'srpipkxuv7v1qrw',
        "name": '${user!.name}',
        "family": '${user!.family}',
      };

      final record = await _pb.collection('order').create(body: body);

      if (record != null) {
        return 'موفق';
      } else {
        return 'خطا در ایجاد رکورد';
      }
    } catch (e) {
      // بررسی ساختار خطای خاص
      if (e.toString().contains('validation_not_unique')) {
        return 'این شماره نیاز تکراری است';
      } else {
        return 'خطا در ایجاد رکورد: ${e.toString()}';
      }
    }
  }

  Future<void> ArchiveOrder(OrderTwo order) async {
    print('hooooo');

    final body = <String, dynamic>{
      "id": order.id,
      "title": order.title,
      "callnumber": order.callNumber,
      "datenow": order.dateNow,
      "datead": order.dateAd,
      "address": order.address,
      "niyaz": order.niyaz,
      "phonenumberit": order.phoneNumberIT,
      "buy": order.buy,
      "winner": order.winner,
      "type_order": order.type,
      //  "created": order.created,
      "registration_number": order.registrationNumber,
      "national_code": order.nationalCode,
      "postal_code": order.postalCode,
      "economic_code": order.economicCode,
      "accounting_number": order.accountingNumber,
      "purchase_number": order.purchaseNumber,
      "rating": order.rating,
      //   "type": order.type,
      "type_order": order.type_order,
      "windows_type": order.windowsType,
      // استخراج آی‌دی‌ها از listProductA
      "listproducta": order.listProductA?.map((product) => product.id).toList(),
      "name": order.name,
      "family": order.family,
      //   "type": 'srpipkxuv7v1qrw',
    };

    final record = await _pb.collection('order_artchive').create(body: body);
    print('${record.id}');
    await _pb.collection('order').delete(order.id!);
    fetchAndUpdate();
  }


  // Future<void> createorders(OrderTwo order) async {
  //   try {
  //     final body = <String, dynamic>{
  //       "title": order.title,
  //       "niyaz": order.niyaz,
  //       "phonenumberit": order.phoneNumberIT,
  //       "datenow": order.dateNow,
  //       "datead": order.dateAd,
  //       "winner": '0.25',
  //       "callnumber": order.callNumber,
  //       "buy": bool.parse(order.buy!) ? 'فروش و اسمبل' : 'فروش',
  //       "address": order.address,
  //       "type": 'srpipkxuv7v1qrw',
  //     };
  //
  //     final record = await _pb.collection('order').create(body: body);
  //     if (record != null) {
  //       fetchAndUpdate();
  //  print(record);
  //     } else {
  //
  //     }
  //   } catch (e) {
  //
  //   }
  // }
  final AuthController authController = Get.find<AuthController>();

  late final user;

  Future<void> updateOrder(OrderTwo order) async {
    final user = await authController.getUser();
    //  emit(OrderLoading());
    try {
      final body = <String, dynamic>{
        "title": order.title,
        "callnumber": order.callNumber,
        "niyaz": order.niyaz,
        "phonenumberit": order.phoneNumberIT,
        "datenow": order.dateNow,
        "datead": order.dateAd,
        "buy": order.buy,
        "address": order.address,
        "winner": order.winner,
        "name": '${user!.name}',
        "family": '${user!.family}',
      };

      final record =
          await _pb.collection('order').update(order.id!, body: body);
      if (record != null) {
        fetchAndUpdate();
        //  add(FetchOrders());
        // emit(OrderSuccess('Order updated successfully'));
      } else {
        //    emit(OrderError('Failed to update order.'));
      }
    } catch (e) {
      // emit(OrderError(e.toString()));
    }
  }

  Future<void> updateConfigOrder(OrderTwo order) async {
    try {
      final body = <String, dynamic>{
        "callnumber": order.callNumber,
        "economic_code": order.economicCode,
        "registration_number": order.registrationNumber,
        "postal_code": order.postalCode,
        "national_code": order.nationalCode,
        "accounting_number": order.accountingNumber,
        "phonenumberit": order.phoneNumberIT,
        "buy": order.buy,
        "address": order.address,
        "purchase_number": order.purchaseNumber,
        "windows_type": order.windowsType,
      };

      final record =
          await _pb.collection('order').update(order.id!, body: body);
      if (record != null) {
        fetchAllOrders();

        // Get.snackbar(
        //     'اطلاعات سفارش برنده' ,  ' با موفقیت وارد شد',backgroundColor: Colors.green,);
        Get.snackbar(
          'اطلاعات سفارش برنده',
          'با موفقیت وارد شد',
          backgroundColor: Colors.green,
          messageText: Text(
            'با موفقیت وارد شد',
            textDirection: TextDirection.rtl,
          ),
          titleText: Text(
            'اطلاعات سفارش برنده',
            textDirection: TextDirection.rtl,
          ),
        );

        // add(FetchOrders());
        // emit(OrderSuccess('Order updated successfully'));
      } else {
        // emit(OrderError('Failed to update order.'));
        Get.snackbar(
          'اطلاعات سفارش برنده',
          'با خطا مواجه شد',
          backgroundColor: Colors.red,
          messageText: Text(
            'با خطا مواجه شد',
            textDirection: TextDirection.rtl,
          ),
          titleText: Text(
            'اطلاعات سفارش برنده',
            textDirection: TextDirection.rtl,
          ),
        );
      }
    } catch (e) {
      // emit(OrderError(e.toString()));
      Get.snackbar(
        'اطلاعات سفارش برنده',
        'با خطا مواجه شد',
        backgroundColor: Colors.red,
        messageText: Text(
          'با خطا مواجه شد',
          textDirection: TextDirection.rtl,
        ),
        titleText: Text(
          'اطلاعات سفارش برنده',
          textDirection: TextDirection.rtl,
        ),
      );
    }
  }

  Future<void> deleteOrder(
    String orderId,
  ) async {
    //  emit(OrderLoading());
    try {
      // final order = await _pb.collection('order').getOne(orderId);
      // Map<String, dynamic> orderData = order.toJson();
      // List<dynamic> listProductAIds = orderData['listproducta'] ?? [];
      // for (var productId in listProductAIds) {
      //   await _pb.collection('listproducta').delete(productId.toString());
      // }

      // List<dynamic> listProductBIds = orderData['listproductb'] ?? [];
      // for (var productId in listProductBIds) {
      //   await _pb.collection('listproductb').delete(productId.toString());
      // }

      await _pb.collection('order').delete(orderId);
      fetchAndUpdate();
      // add(FetchOrders());
      //   emit(OrderSuccess('Order deleted successfully'));
    } catch (e) {
      //   emit(OrderError(e.toString()));
    }
  }

  Future<void> updateProductA(String productId, String productTitle,
      String productPrice, String number) async {
    try {
      final body = {
        'title': productTitle,
        // 'pricesell': productPrice,
        'number': number,
      };
      await _pb.collection('listproducta').update(productId, body: body);
      //
      fetchAndUpdate();
    } catch (error) {
      print('Error updating product A: $error');
    }
  }

  Future<void> updateProductAByeGaranty(String productId, String productTitle,
      String productPrice, List<String> G, String newNumber) async {
    try {
      final body = {
        'title': productTitle,
        // 'pricesell': productPrice,
        'garranty': G,
        'number': newNumber,
      };
      await _pb.collection('listproducta').update(productId, body: body);
      //
      fetchAndUpdate();
    } catch (error) {
      print('Error updating product A: $error');
    }
  }
}

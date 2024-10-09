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

class OrderArchiveControllerPage extends GetxController {
  final PocketBaseManager _pocketBaseManager;

  OrderArchiveControllerPage()
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
    //await fetchGeneralCategories();

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
        final ordersRecord = await _pb.collection('order_artchive').getList(
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

  Timer? _debounce; // متغیر برای ذخیره تایمر


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

    final record = await _pb.collection('order').create(body: body);
    print('${record.id}');
    await _pb.collection('order_artchive').delete(order.id!);
    fetchAndUpdate();
  }



  final AuthController authController = Get.find<AuthController>();

  late final user;


}

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:get/get.dart';
import 'package:project/BUY/1_2/sabte_sefaresh_one_two.dart';
import 'package:project/BUY/4/SupplierDetailsPage.dart';
import 'package:project/Drawer/auth_controller.dart';
import 'package:project/Get_X/Model_Category/Garrantyy.dart';
import 'package:project/Get_X/Service/PocketBaseService.dart';

import '../ModelBuy/model.dart';



class GeneralCategoryController extends GetxController {


  final PocketBaseManager _pocketBaseManager;

  GeneralCategoryController()
      : _pocketBaseManager = PocketBaseManager(url: 'https://saater.liara.run', lang: 'en-US');

  PocketBase get pb => _pocketBaseManager.client;





  List<Map<String, String>> suppliers = [];

  String? selectedSupplierCompanyName;
  String? selectedSupplierPhoneNumber;
  String? selectedSupplierMobileNumber;
  String? selectedSupplierAddress;
  String? selectedSupplierLocation;
  String? selectedSupplierID;
  Future<void> fetchAllSuppliers() async {
    try {
      final records = await pb.collection('suppliers').getFullList();
      print(records);
      suppliers = records.map((item) {
        return {
          'companyname': item.data['companyname']?.toString() ?? '',
          'phonenumber': item.data['phonenumber']?.toString() ?? '',
          'mobilenumber': item.data['mobilenumber']?.toString() ?? '',
          'address': item.data['address']?.toString() ?? '',
          'location': item.data['location']?.toString() ?? '',
          'id': item.id ?? '',
        };
      }).toList();
      print('_suppliers');
      print(suppliers);
      update(['_suppliersall']);
    } catch (error) {
      print('Error fetching suppliers: $error');
    }
  }


  void selectSupplier(String? companyName) {
    final supplier = suppliers
        .firstWhere((element) => element['companyname'] == companyName);

    selectedSupplierCompanyName = supplier['companyname'];
    selectedSupplierPhoneNumber = supplier['phonenumber'];
    selectedSupplierMobileNumber = supplier['mobilenumber'];
    selectedSupplierAddress = supplier['address'];
    selectedSupplierLocation = supplier['location'];
    selectedSupplierID = supplier['id'];
//update();
    update(['_suppliersallview','_suppliersfloatin']); // به‌روزرسانی ویو
  }

  Future<List<String>> fetchSuggestions() async {
    await Future.delayed(const Duration(milliseconds: 750));
    return suppliers.map((supplier) => supplier['companyname']!).toList();
  }






  List<Garrantyy> selectedGarrantyItems = [];

  Future<void> fetchSelectedGarrantyItems() async {
    try {
      final resultList = await pb.collection('garrantya').getList();
      print('dddd' + resultList.items.toString());
      List<Garrantyy> garrantyItems = [];
      print(garrantyItems.length);
      for (var item in resultList.items) {
        final data = item.toJson();
        if (data.containsKey('Garrantyname')) {
          print(item.collectionName.toString());
          garrantyItems.add(Garrantyy.fromJson(data));
        }
      }
      selectedGarrantyItems = garrantyItems;
      update(['garrantya']);
    } catch (error) {
      print('Error fetching selected garranty items: $error');
    }
  }

  final AuthController authController = Get.find<AuthController>();

  late final user;

  Future<void> generatefactororderdelete(String id) async {
    try {
      final record = await pb.collection('order_buy_product').delete(id);
      // OrderBuyProductPage
      await fetch_order_buy_product();
      Get.to(OrderBuyProductPage());
      // Get.offAllNamed('/create_order');
    } catch (e) {
      Get.snackbar(' ناموفق', 'فاکتور شما قابل حذف نیست',
          backgroundColor: Colors.red);
      print('Error updating category: $e');
    }
  }

  Future<void> generatefactororder(String id, double pricefactor) async {
    try {
      final body = <String, dynamic>{"pricefactor": pricefactor};

      final record =
          await pb.collection('order_buy_product').update(id, body: body);
      // OrderBuyProductPage
      await fetch_order_buy_product();
      Get.to(OrderBuyProductPage());
      //Get.offAllNamed('/create_order');
    } catch (e) {
      Get.snackbar(' ناموفق', 'فاکتور شما قابل حذف نیست',
          backgroundColor: Colors.red);
      print('Error updating category: $e');
    }
  }

  Future<void> delet_buy_order(String id) async {
    try {
      print('ssssssssssssssss' + id);
      await pb.collection('order_buy_product').delete(id);
      Get.snackbar(' موفق', 'فاکتور شما با موفقیت حذف شد.',
          backgroundColor: Colors.green);
      await fetchGeneralCategories(); // Refresh the list after update
      await fetch_order_buy_product();
    } catch (e) {
      Get.snackbar(' ناموفق', 'فاکتور شما قابل حذف نیست',
          backgroundColor: Colors.red);
      print('Error updating category: $e');
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
  }) async {
    try {
      // ساخت یک رکورد جدید در جدول buy_product
      final record = await pb.collection('buy_product').create(
        body: {
          "title": title,
          "supplier": supplierId,
          "days": days,
          "datecreated": dateCreated,
          "dataclearing": dataClearing,
          "number": number,
          "datead": dateAd,
          "type_order": 'خرید',
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

      // دریافت رکوردهای فعلی order_buy_product
      final orderRecord =
      await pb.collection('order_buy_product').getOne(orderID);
      List<dynamic> existingBuyProductOrder =
          orderRecord.data['buy_product'] ?? [];
      existingBuyProductOrder.add(record.id);

      // دریافت رکوردهای فعلی name_product_category
      final productRecord =
      await pb.collection('name_product_category').getOne(idproduct);
      List<dynamic> existingBuyProductCategory =
          productRecord.data['buy_product'] ?? [];
      existingBuyProductCategory.add(record.id);

      // به‌روزرسانی رکورد order_buy_product با لیست به‌روز شده
      final body = <String, dynamic>{
        "buy_product": existingBuyProductOrder,
      };
      await pb.collection('order_buy_product').update(orderID, body: body);

      // به‌روزرسانی رکورد name_product_category با لیست به‌روز شده
      // استخراج مقدار فعلی number از رکورد name_product_category
      String currentNumberStr =
          productRecord.data['number'].toString() ?? "0"; // تبدیل به رشته
      int currentNumber = int.tryParse(currentNumberStr) ?? 0;
      print('Current number in name_product_category: $currentNumber');

      // تبدیل number ورودی به عدد و جمع با مقدار فعلی
      int newNumber = int.tryParse(number) ?? 0;
      int updatedNumber = currentNumber + newNumber;
      final bodyproduct = <String, dynamic>{
        "number": updatedNumber.toString(), // تبدیل عدد به رشته
        "buy_product": existingBuyProductCategory,
      };
      await pb
          .collection('name_product_category')
          .update(idproduct, body: bodyproduct);


      final bodyproductbuy = <String, dynamic>{
        "inventory": currentNumberStr, // تبدیل عدد به رشته
        "Number_of_inventory": newNumber, // تبدیل عدد به رشته
        "number_now": updatedNumber.toString(), // تبدیل عدد به رشته
        // "number": updatedNumber.toString(), // تبدیل عدد به رشته
        // "buy_product": existingBuyProductCategory,
      };
      await pb
          .collection('buy_product')
          .update(record.id, body: bodyproductbuy);
      print('bachebala');
      print(orderID);
      print(idproduct);
      print(idupdate);
      print(record.id);

      fetchGeneralCategories();

      fetchNameProductCategory(idupdate);
      fetchBuyProductsById(idupdate);
      print('Product added successfully: ${record.id}');
    } catch (error) {
      print('Error adding product: $error');
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
    required List<String> garanty,
  }) async {
    try {
      // ساخت یک رکورد جدید در جدول buy_product
      final record = await pb.collection('buy_product').create(
        body: {
          "title": title,
          "supplier": supplierId,
          "days": days,
          "datecreated": dateCreated,
          "dataclearing": dataClearing,
          "number": number,
          "datead": dateAd,
          "hurry": hurry,
          "type_order": 'خرید',
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

      // دریافت رکوردهای فعلی order_buy_product
      final orderRecord =
          await pb.collection('order_buy_product').getOne(orderID);
      List<dynamic> existingBuyProductOrder =
          orderRecord.data['buy_product'] ?? [];
      existingBuyProductOrder.add(record.id);

      // دریافت رکوردهای فعلی name_product_category
      final productRecord =
          await pb.collection('name_product_category').getOne(idproduct);
      List<dynamic> existingBuyProductCategory =
          productRecord.data['buy_product'] ?? [];
      existingBuyProductCategory.add(record.id);

      // به‌روزرسانی رکورد order_buy_product با لیست به‌روز شده
      final body = <String, dynamic>{
        "buy_product": existingBuyProductOrder,
      };
      await pb.collection('order_buy_product').update(orderID, body: body);

      // به‌روزرسانی رکورد name_product_category با لیست به‌روز شده
      // استخراج مقدار فعلی number از رکورد name_product_category
      String currentNumberStr =
          productRecord.data['number'].toString() ?? "0"; // تبدیل به رشته
      int currentNumber = int.tryParse(currentNumberStr) ?? 0;
      print('Current number in name_product_category: $currentNumber');

      // تبدیل number ورودی به عدد و جمع با مقدار فعلی
      int newNumber = int.tryParse(number) ?? 0;
      int updatedNumber = currentNumber + newNumber;
      final bodyproduct = <String, dynamic>{
        "number": updatedNumber.toString(), // تبدیل عدد به رشته
        "buy_product": existingBuyProductCategory,
      };
      await pb
          .collection('name_product_category')
          .update(idproduct, body: bodyproduct);
      final bodyproductbuy = <String, dynamic>{
        "inventory": currentNumberStr, // تبدیل عدد به رشته
        "Number_of_inventory": newNumber, // تبدیل عدد به رشته
        "number_now": updatedNumber.toString(), // تبدیل عدد به رشته
        // "number": updatedNumber.toString(), // تبدیل عدد به رشته
        // "buy_product": existingBuyProductCategory,
      };
      await pb
          .collection('buy_product')
          .update(record.id, body: bodyproductbuy);
      print('bachebala');
      print(orderID);
      print(idproduct);
      print(idupdate);
      print(record.id);

      fetchGeneralCategories();

      fetchNameProductCategory(idupdate);
      fetchBuyProductsById(idupdate);


      print('Product added successfully: ${record.id}');
    } catch (error) {
      print('Error adding product: $error');
    }
  }

  List<OrderBuyProduct> orderBuyProducts = [];

  Future<List<OrderBuyProduct>> fetch_order_buy_product() async {
    // چک کردن اینکه داده‌ها قبلاً بارگذاری شده‌اند یا نه
    // if (orderBuyProducts.isNotEmpty) {
    //   return orderBuyProducts;
    // }
    orderBuyProducts.clear();

    print('///////////////////');
    int page = 1;
    try {
      while (true) {
        final resultList = await pb.collection('order_buy_product').getList(
              page: page,
              perPage: 50,
              expand: 'supplier,buy_product,buy_product.sn_buy_product_login',
            );

        if (resultList.items.isEmpty) {
          break;
        }

        List<OrderBuyProduct> fetchedOrderBuyProducts = [];

        for (var record in resultList.items) {
          var recordData = record.toJson() as Map<String, dynamic>;

          // چاپ داده‌های خام
          print('Record Data: $recordData');

          List<BuyProduct> buyProductstoclass = [];
          var buyProductsData = recordData['expand']?['buy_product'];

          if (buyProductsData is List) {
            buyProductstoclass = buyProductsData.map((productJson) {
              List<login_buy_product_SN> snBuyProductLogin = [];
              var snData = productJson['expand']?['sn_buy_product_login'];

              if (snData is List) {
                snBuyProductLogin = snData
                    .map((snJson) => login_buy_product_SN.fromJson(snJson))
                    .toList();
              }

              return BuyProduct.fromJson(
                Map<String, dynamic>.from(productJson),
                snBuyProductLogin,
              );
            }).toList();
          }

          var supplierData = recordData['expand']?['supplier'] ?? {};

          OrderBuyProduct orderBuyProduct = OrderBuyProduct(
            companyname: supplierData['companyname']?.toString() ?? '',
            phonenumber: supplierData['phonenumber']?.toString() ?? '',
            mobilenumber: supplierData['mobilenumber']?.toString() ?? '',
            address: supplierData['address']?.toString() ?? '',
            location: supplierData['location']?.toString() ?? '',
            buy_product: buyProductstoclass,
            id: recordData['id']?.toString() ?? '',
            pricefactor: recordData['pricefactor']?.toString() ?? '',
          );

          fetchedOrderBuyProducts.add(orderBuyProduct);
        }

        orderBuyProducts.addAll(fetchedOrderBuyProducts);
        page++;
      }
      update(['updatebuyproduct']);
    } catch (error) {
      print('Error fetching order buy products: $error');
    }

    return orderBuyProducts;
  }


  var buyProducts = <BuyProduct>[];

  // متدی برای دریافت محصولات خریداری شده بر اساس id
  Future<void> fetchBuyProductsById(String id) async {
    try {
      // گرفتن لیست کامل از جدول name_product_category
      final resultList =
          await pb.collection('name_product_category').getFullList(
                filter: 'id = "$id"',
                expand:
                    'buy_product.sn_buy_product_login', // مشخص کردن جداول مورد نظر در expand
              );

      print("Result List: ${resultList.map((r) => r.toJson()).toList()}");

      for (var record in resultList) {
        // تبدیل داده‌های رکورد به Map
        var recordData = record.toJson() as Map<String, dynamic>;
        print("Record Data: $recordData");

        // پردازش داده‌های SN_BUY_PRODUCT_LOGIN
        var buyProductData = recordData['expand']?['buy_product'] as List?;
        print("Buy Product Data: $buyProductData");

        List<BuyProduct> buyProducts = [];

        if (buyProductData != null) {
          for (var buyProductJson in buyProductData) {
            var snBuyProductLoginData =
                buyProductJson['expand']?['sn_buy_product_login'];
            print(
                "SN_BUY_PRODUCT_LOGIN Data for product ${buyProductJson['id']}: $snBuyProductLoginData");

            List<login_buy_product_SN> snBuyProductLogins = [];

            if (snBuyProductLoginData is List) {
              snBuyProductLogins =
                  snBuyProductLoginData.map((loginBuyProductJson) {
                return login_buy_product_SN
                    .fromJson(Map<String, dynamic>.from(loginBuyProductJson));
              }).toList();
            }

            // ایجاد یک شیء BuyProduct
            BuyProduct product = BuyProduct.fromJson(
              Map<String, dynamic>.from(buyProductJson),
              snBuyProductLogins,
            );

            // لاگ‌گذاری اطلاعات محصول
            print("Product Title: ${product.title}");
            print(
                "Number of SN_BUY_PRODUCT_LOGIN: ${product.snBuyProductLogin.length}");

            // اضافه کردن به لیست محصولات
            buyProducts.add(product);
          }
        }

        // ذخیره محصولات در متغیر buyProducts
        this.buyProducts = buyProducts;
        print("Total Products: ${this.buyProducts.length}");

        update(['productbuy']);
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> deleteBuyId_BuyProdut(
      String id, String number, String orderId) async {
    try {
      final productRecord =
          await pb.collection('name_product_category').getOne(orderId);
      String currentNumberStr =
          productRecord.data['number'].toString() ?? "0"; // تبدیل به رشته
      int currentNumber = int.tryParse(currentNumberStr) ?? 0;
      print('Current number in name_product_category: $currentNumber');
      // تبدیل number ورودی به عدد و جمع با مقدار فعلی
      int newNumber = int.tryParse(number) ?? 0;
      if (newNumber < int.parse(number)) {
        Get.snackbar('ناموفق',
            'تعداد کالا موجود انبار با تعداد کالای حدف شده مطابقت ندارد',
            backgroundColor: Colors.orange);
      }
      int updatedNumber = currentNumber - newNumber;

      final body = <String, dynamic>{
        "number": updatedNumber,
      };
      await pb.collection('name_product_category').update(orderId, body: body);

      await pb.collection('buy_product').delete(id);
      Get.snackbar(' موفق', 'سفارش شما با موفقیت حذف شد.',
          backgroundColor: Colors.green);
      await fetchGeneralCategories(); // Refresh the list after update
      fetchNameProductCategory(orderId);
      fetchBuyProductsById(orderId);
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  Future<void> deleteBuyId_BuyProdut_NameProduct_category(
      String id, String number, String idproduct_buy_product) async {
    try {
      // try {
      // final productRecord =
      // await pb.collection('name_product_category').getOne(id);

////////////////////////////////////////////////
//     List<NameProductCategory> nameProductCategories = [];
//     int page = 1;
//     NameProductCategory? foundProduct; // متغیر برای ذخیره محصول یافت شده
// //Mm09190694410@
//     try {
//       while (true) {
//         final resultList = await pb.collection('name_product_category').getList(
//           page: page,
//           perPage: 50, // تعداد رکوردهای دریافتی در هر صفحه
//           expand: 'buy_product', // گسترش برای دریافت داده‌های مرتبط
//         );
//
//         if (resultList.items.isEmpty) {
//           break; // خروج از حلقه در صورت خالی بودن صفحه
//         }
//
//         // پردازش رکوردهای دریافت شده و تبدیل آن‌ها به مدل NameProductCategory
//         for (var record in resultList.items) {
//           var recordData = record.toJson() as Map<String, dynamic>;
//
//           // پردازش داده‌های buy_product
//           var buyProductsData = recordData['expand']?['buy_product'];
//           List<NameProductCategory> buyProducts = [];
//
//           if (buyProductsData is List) {
//             buyProducts = buyProductsData.map((buyProductJson) {
//               return NameProductCategory.fromJson(
//                   Map<String, dynamic>.from(buyProductJson));
//             }).toList();
//           }
//
//           // چاپ اطلاعات تمامی محصولات موجود در buyProducts
//           print('Products in this category:');
//           for (var product in buyProducts) {
//             print('Title: ${product.title}');
//             print('Number: ${product.number}');
//             print('ID: ${product.id}');
//           }
//
//           // جستجوی محصول با `idproduct_buy_product` مشخص در لیست `buyProducts`
//           var matchedProducts = buyProducts.where(
//                 (product) => product.id == idproduct_buy_product,
//           ).toList();
//
//           if (matchedProducts.isNotEmpty) {
//             foundProduct = matchedProducts.first; // محصول یافت شده را ذخیره کن
//             break; // خروج از حلقه داخلی در صورت یافتن محصول
//           }
//
//           // اضافه کردن دسته‌بندی به لیست کلی
//           nameProductCategories.addAll(buyProducts);
//         }
//
//         if (foundProduct != null) {
//           break; // خروج از حلقه بیرونی در صورت یافتن محصول
//         }
//
//         page++; // افزایش شماره صفحه برای دریافت رکوردهای صفحه بعدی
//       }
// //Mm09190694410@
//       if (foundProduct != null) {
//         // استخراج اطلاعات محصول یافت شده
//         String title = foundProduct.title;
//         String number = foundProduct.number;
//         String id = foundProduct.id;
//
//         print('Product found:');
//         print('Title: $title');
//         print('Number: $number');
//         print('ID: $id');
//       } else {
//         print('Product with id $idproduct_buy_product not found in any category.');
//       }
//
//       // تعداد کل دسته‌بندی‌ها را نمایش دهید
//       print('Total name product categories fetched: ${nameProductCategories.length}');
//     } catch (error) {
//       print('Error fetching name product categories: $error');
//     }
////////////////////////////////////////////////
      print('objectobjectobject');

      // متغیرهای محلی برای ذخیره اطلاعات
      String? recordId;
      int? recordnumber;
      DateTime? recordCreated;
      DateTime? recordUpdated;
      String? productId;
      String? productTitle;
      String? productNumber;

      try {
        int page = 1;

        while (true) {
          // دریافت لیست رکوردها از `name_product_category` با گسترش `buy_product`
          final resultList =
              await pb.collection('name_product_category').getList(
                    page: page,
                    perPage: 50, // تعداد رکوردهای دریافتی در هر صفحه
                    expand: 'buy_product', // گسترش برای دریافت داده‌های مرتبط
                  );

          if (resultList.items.isEmpty) {
            break; // خروج از حلقه در صورت خالی بودن صفحه
          }

          bool found = false;

          // پردازش رکوردهای دریافت شده
          for (var record in resultList.items) {
            var recordData = record.toJson() as Map<String, dynamic>;

            // چاپ اطلاعات رکورد
            print('Processing Record ID: ${recordData['id']}');

            // چاپ اطلاعات مرتبط با `expand`
            var expandedData = recordData['expand'];
            if (expandedData != null) {
              // چاپ اطلاعات `buy_product`
              var buyProductsData = expandedData['buy_product'];
              if (buyProductsData is List) {
                for (var product in buyProductsData) {
                  var productData = product as Map<String, dynamic>;
                  if (productData['id'] == idproduct_buy_product) {
                    // اگر محصول مورد نظر پیدا شد
                    recordId = recordData['id'];
                    recordnumber = recordData['number'];
                    recordCreated = DateTime.parse(recordData['created']);
                    recordUpdated = DateTime.parse(recordData['updated']);
                    productId = productData['id'];
                    productTitle = productData['title'];
                    productNumber = productData['number'];
                    found = true; // علامت‌گذاری اینکه محصول پیدا شده است
                    break;
                  }
                }
              } else {
                print('No expanded products found.');
              }
            } else {
              print('No expanded data found.');
            }

            if (found) {
              // اگر محصول پیدا شد، از حلقه بیرون بروید
              break;
            }

            print('---'); // جداکننده برای هر رکورد
          }

          if (found) {
            break; // خروج از حلقه بیرونی در صورت پیدا شدن محصول
          }

          page++; // افزایش شماره صفحه برای دریافت رکوردهای صفحه بعدی
        }

        if (recordId != null && productId != null) {
          // استفاده از اطلاعات ذخیره‌شده
          print('Found record and product:');
          print('Record ID: $recordId');
          print('Record number: $recordnumber');
          print('Record Created: $recordCreated');
          print('Record Updated: $recordUpdated');
          print('Product ID: $productId');
          print('Product Title: $productTitle');
          print('Product Number: $productNumber');
        } else {
          print('Product with ID $idproduct_buy_product not found.');
        }
      } catch (error) {
        print('Error fetching records: $error');
      }
////////////////////////////////////////////////

      // String currentNumberStr =
      //     productRecord.data['number'].toString() ?? "0"; // تبدیل به رشته
      // int currentNumber = int.tryParse(currentNumberStr) ?? 0;
      // print('Current number in name_product_category: $currentNumber');
      // // تبدیل number ورودی به عدد و جمع با مقدار فعلی
      // int newNumber = int.tryParse(number) ?? 0;
      if (recordnumber! < int.parse(number)) {
        Get.snackbar('ناموفق',
            'تعداد کالا موجود انبار با تعداد کالای حدف شده مطابقت ندارد',
            backgroundColor: Colors.orange);
      } else {
        int updatedNumber = recordnumber - int.parse(productNumber.toString());
        //
        final body = <String, dynamic>{
          "number": updatedNumber,
        };
        await pb
            .collection('name_product_category')
            .update(recordId!, body: body);

        await pb.collection('buy_product').delete(id);
        Get.snackbar(' موفق', 'محصول شما با موفقیت حذف شد.',
            backgroundColor: Colors.green);
        await fetchGeneralCategories(); // Refresh the list after update
        await fetch_order_buy_product();
        await fetchNameProductCategory(recordId);
        await fetchBuyProductsById(recordId);
      }
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  NameProductCategory? nameProductCategorys;

  // متد برای دریافت داده‌ها
  Future<void> fetchNameProductCategory(String orderId) async {
    try {
      // فراخوانی متد و ذخیره نتیجه در متغیر
      nameProductCategorys = await getnameproductcategory_one(orderId);

      // به‌روزرسانی ویو
      update(['productD']);
    } catch (e) {
      print('Error fetching category: $e');
    }
  }

  Future<NameProductCategory?> getnameproductcategory_one(
      String orderId) async {
    try {
      // دریافت رکورد از جدول 'name_product_category'
      final productRecord =
          await pb.collection('name_product_category').getOne(orderId);

      // تبدیل داده‌های JSON به شیء NameProductCategory
      NameProductCategory nameProductCategory =
          NameProductCategory.fromJson(productRecord.data);

      // دسترسی به خصوصیات شیء
      print('ID: ${nameProductCategory.id}');
      print('Title: ${nameProductCategory.title}');
      print('Number: ${nameProductCategory.number}');

      // تبدیل مقدار number به عدد و چاپ
      int currentNumber = int.tryParse(nameProductCategory.number) ?? 0;
      print('Current number in name_product_category: $currentNumber');

      // بازگرداندن شیء NameProductCategory
      return nameProductCategory;
    } catch (e) {
      // چاپ خطا در صورت بروز مشکل
      print('Error fetching category: $e');
      // بازگرداندن null در صورت بروز خطا
      return null;
    }
  }

  Future<void> updateproductSubGeneralCategory(
      String id, Map<String, dynamic> body) async {
    try {
      await pb.collection('name_product_category').update(id, body: body);
      await fetchGeneralCategories(); // Refresh the list after update
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  Future<void> createproductSubGeneralCategory(
      Map<String, dynamic> body, String idGeneral) async {
    try {
      // مرحله ۱: ایجاد رکورد جدید در مجموعه product_category
      var newRecord =
          await pb.collection('name_product_category').create(body: body);

      // چاپ ID رکورد جدید
      print('New product_category created with ID: ${newRecord.id}');

      // مرحله ۲: دریافت اطلاعات رکورد general_category با استفاده از id_general
      var generalCategoryRecord =
          await pb.collection('product_category').getOne(idGeneral);

      // مرحله ۳: استخراج لیست product_category های موجود از رکورد دریافت شده
      var generalCategoryData =
          generalCategoryRecord.toJson() as Map<String, dynamic>;
      List<dynamic> productCategories =
          generalCategoryData['name_product_category'] ?? [];

      // اضافه کردن ID رکورد جدید به لیست product_category های موجود
      productCategories.add(newRecord.id);

      // به‌روزرسانی رکورد با لیست جدید product_category
      generalCategoryData['name_product_category'] = productCategories;

      // مرحله ۴: به‌روزرسانی رکورد general_category با داده‌های جدید
      await pb
          .collection('product_category')
          .update(idGeneral, body: generalCategoryData);

      print('General category with ID $idGeneral updated successfully.');
      fetchGeneralCategories();
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  Future<void> createSubGeneralCategory(
      Map<String, dynamic> body, String idGeneral) async {
    try {
      // مرحله ۱: ایجاد رکورد جدید در مجموعه product_category
      var newRecord =
          await pb.collection('product_category').create(body: body);

      // چاپ ID رکورد جدید
      print('New product_category created with ID: ${newRecord.id}');

      // مرحله ۲: دریافت اطلاعات رکورد general_category با استفاده از id_general
      var generalCategoryRecord =
          await pb.collection('general_category').getOne(idGeneral);

      // مرحله ۳: استخراج لیست product_category های موجود از رکورد دریافت شده
      var generalCategoryData =
          generalCategoryRecord.toJson() as Map<String, dynamic>;
      List<dynamic> productCategories =
          generalCategoryData['product_category'] ?? [];

      // اضافه کردن ID رکورد جدید به لیست product_category های موجود
      productCategories.add(newRecord.id);

      // به‌روزرسانی رکورد با لیست جدید product_category
      generalCategoryData['product_category'] = productCategories;

      // مرحله ۴: به‌روزرسانی رکورد general_category با داده‌های جدید
      await pb
          .collection('general_category')
          .update(idGeneral, body: generalCategoryData);

      print('General category with ID $idGeneral updated successfully.');
      fetchGeneralCategories();
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  Future<void> updateSubGeneralCategory(
      String id, Map<String, dynamic> body) async {
    try {
      await pb.collection('product_category').update(id, body: body);
      await fetchGeneralCategories(); // Refresh the list after update
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  Future<void> createGeneralCategory(Map<String, dynamic> body) async {
    try {
      await pb.collection('general_category').create(body: body);
      await fetchGeneralCategories(); // Refresh the list after update
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  Future<void> updateGeneralCategory(
      String id, Map<String, dynamic> body) async {
    try {
      await pb.collection('general_category').update(id, body: body);
      await fetchGeneralCategories(); // Refresh the list after update
    } catch (e) {
      print('Error updating category: $e');
    }
  }

  Future<void> createOrderBuyProduct(String supplier) async {
    try {
      final body = <String, dynamic>{
        "supplier": supplier, // استفاده از پارامتر تابع به جای متغیر نامشخص
      };

      var record = await pb.collection('order_buy_product').create(body: body);
      Get.to(() => SupplierDetailsPage(record.id));
      Get.snackbar('فاکتور ثبت شد', 'محصولات فاکتور را ثبت کنید',
          backgroundColor: Colors.green);

      print('Order creation successful' + record.id);
    } catch (error) {
      print('Error creating order: $error');
    }
  }

  var generalCategories = <GeneralCategory>[];

  Future<void> fetchGeneralCategories() async {
    generalCategories.clear();
    int page = 1;
    try {
      while (true) {
        final resultList = await pb.collection('general_category').getList(
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
        update(["update"]); // به‌روزرسانی UI پس از بارگذاری داده‌ها
        page++;
      }
    } catch (error) {
      print('Error fetching general categories: $error');
    }
  }

  @override
  Future<void> onInit() async {
    fetchGeneralCategories();
   // fetch_order_buy_product();
    fetchSelectedGarrantyItems();
    user = await authController.getUser();
    super.onInit();
  }

  List<OrderBuyProduct> OrderByIdBuyProducts = [];

  Future<void> fetchOrderById(String id) async {
    print(id + 'lllllllllll');
    try {
      // ارسال درخواست به API برای دریافت رکورد مشخص
      final result = await pb.collection('order_buy_product').getFirstListItem(
            'id="$id"',
            expand: 'supplier,buy_product,buy_product.sn_buy_product_login',
          );

      var recordData = result.toJson() as Map<String, dynamic>;

      // چاپ داده‌های خام برای دیباگ
      print('Record Data: $recordData');

      List<BuyProduct> buyProducts = [];
      var buyProductsData = recordData['expand']?['buy_product'];

      if (buyProductsData is List) {
        buyProducts = buyProductsData.map((productJson) {
          List<login_buy_product_SN> snBuyProductLogin = [];
          var snData = productJson['expand']?['sn_buy_product_login'];

          if (snData is List) {
            snBuyProductLogin = snData
                .map((snJson) => login_buy_product_SN.fromJson(snJson))
                .toList();
          }

          return BuyProduct.fromJson(
            Map<String, dynamic>.from(productJson),
            snBuyProductLogin,
          );
        }).toList();
      }

      var supplierData = recordData['expand']?['supplier'] ?? {};

      OrderBuyProduct orderBuyProduct = OrderBuyProduct(
        companyname: supplierData['companyname']?.toString() ?? '',
        phonenumber: supplierData['phonenumber']?.toString() ?? '',
        mobilenumber: supplierData['mobilenumber']?.toString() ?? '',
        address: supplierData['address']?.toString() ?? '',
        location: supplierData['location']?.toString() ?? '',
        buy_product: buyProducts,
        id: supplierData['id']?.toString() ?? '',
        pricefactor: supplierData['pricefactor']?.toString() ?? '',
      );

      // به‌روزرسانی لیست محصول
      OrderByIdBuyProducts.clear();
      OrderByIdBuyProducts.add(orderBuyProduct);
 //  update();
    } catch (error) {
      print('Error fetching order by id: $error');
    }
  }
}

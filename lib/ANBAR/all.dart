import 'dart:convert';


import 'package:pocketbase/pocketbase.dart';


final pb = PocketBase('https://saater.liara.run');

Future<List<AllModels>> fetchAllModels() async {
  try {
    // Fetch records from the 'general_category' collection with expanded relations
    final resultList = await pb.collection('general_category').getList(
      page: 1,
      perPage: 50,
      expand: 'product_category'
    );

    // Convert the records to a list of AllModels
    List<AllModels> allModels = resultList.items.map((item) {
      final data = item.toJson();
      return AllModels.fromJson(data);
    }).toList();

    return allModels;
  } catch (e) {
    print('An error occurred: $e');
    return [];
  }
}


void main() async {
  try {
    // Fetching all models and printing them
    final allModels = await fetchAllModels();
    print('Fetched Models:');
    print(allModels.toString());
  } catch (e) {
    print('An error occurred: $e');
  }
}


class AllModels {
  GeneralCategory? generalCategory;
  ProductCategory? productCategory;
  NameProductCategory? nameProductCategory;
  BuyProduct? buyProduct;
  LoginBuyProductSN? loginBuyProductSN;

  AllModels({
    this.generalCategory,
    this.productCategory,
    this.nameProductCategory,
    this.buyProduct,
    this.loginBuyProductSN,
  });

  factory AllModels.fromJson(Map<String, dynamic> json) {
    return AllModels(
      generalCategory: json['generalCategory'] != null
          ? GeneralCategory.fromJson(json['generalCategory'])
          : null,
      productCategory: json['productCategory'] != null
          ? ProductCategory.fromJson(json['productCategory'])
          : null,
      nameProductCategory: json['nameProductCategory'] != null
          ? NameProductCategory.fromJson(json['nameProductCategory'])
          : null,
      buyProduct: json['buyProduct'] != null
          ? BuyProduct.fromJson(json['buyProduct'])
          : null,
      loginBuyProductSN: json['loginBuyProductSN'] != null
          ? LoginBuyProductSN.fromJson(json['loginBuyProductSN'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'generalCategory': generalCategory?.toJson(),
      'productCategory': productCategory?.toJson(),
      'nameProductCategory': nameProductCategory?.toJson(),
      'buyProduct': buyProduct?.toJson(),
      'loginBuyProductSN': loginBuyProductSN?.toJson(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}







class GeneralCategory {
  String id;
  String collectionId;
  String collectionName;
  String title;
  List<ProductCategory> productCategories;

  GeneralCategory({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.title,
    required this.productCategories,
  });

  factory GeneralCategory.fromJson(Map<String, dynamic> json) {
    return GeneralCategory(
      id: json['id'] ?? '',
      collectionId: json['collectionId'] ?? '',
      collectionName: json['collectionName'] ?? '',
      title: json['title'] ?? '',
      productCategories: (json['product_category'] as List<dynamic>?)
          ?.map((item) => ProductCategory.fromJson(item as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'title': title,
      'product_category': productCategories.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}



class ProductCategory {
  String id;
  String collectionId;
  String collectionName;
  String title;
  int number;
  List<NameProductCategory> nameProductCategory;

  ProductCategory({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.title,
    required this.number,
    required this.nameProductCategory,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['id'] ?? '',
      collectionId: json['collectionId'] ?? '',
      collectionName: json['collectionName'] ?? '',
      title: json['title'] ?? '',
      number: json['number'] ?? 0,
      nameProductCategory: (json['buy_product'] as List)
          .map((item) => NameProductCategory.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'title': title,
      'number': number,
      'buy_product': nameProductCategory.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}


class NameProductCategory {
  String id;
  String collectionId;
  String collectionName;
  String title;
  int number;
  List<BuyProduct> buyProduct;

  NameProductCategory({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.title,
    required this.number,
    required this.buyProduct,
  });

  factory NameProductCategory.fromJson(Map<String, dynamic> json) {
    return NameProductCategory(
      id: json['id'] ?? '',
      collectionId: json['collectionId'] ?? '',
      collectionName: json['collectionName'] ?? '',
      title: json['title'] ?? '',
      number: json['number'] ?? 0,
      buyProduct: (json['buy_product'] as List<dynamic>)
          .map((item) => BuyProduct.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'title': title,
      'number': number,
      'buy_product': buyProduct.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}



class BuyProduct {
  String id;
  String collectionId;
  String collectionName;
  String title;
  String supplier;
  String days;
  String dateCreated;
  String dateClearing;
  String number;
  String dateAd;
  bool okBuy;
  bool hurry;
  bool official;
  String purchasePrice;
  bool expectation;
  bool receive;
  String name;
  String family;
  List<LoginBuyProductSN> snBuyProductLogin;

  BuyProduct({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.title,
    required this.supplier,
    required this.days,
    required this.dateCreated,
    required this.dateClearing,
    required this.number,
    required this.dateAd,
    required this.okBuy,
    required this.hurry,
    required this.official,
    required this.purchasePrice,
    required this.expectation,
    required this.receive,
    required this.name,
    required this.family,
    required this.snBuyProductLogin,
  });

  factory BuyProduct.fromJson(Map<String, dynamic> json) {
    return BuyProduct(
      id: json['id'] ?? '',
      collectionId: json['collectionId'] ?? '',
      collectionName: json['collectionName'] ?? '',
      title: json['title'] ?? '',
      supplier: json['supplier'] ?? '',
      days: json['days'] ?? '',
      dateCreated: json['datecreated'] ?? '',
      dateClearing: json['dataclearing'] ?? '',
      number: json['number'] ?? '',
      dateAd: json['datead'] ?? '',
      okBuy: json['okbuy'] ?? false,
      hurry: json['hurry'] ?? false,
      official: json['official'] ?? false,
      purchasePrice: json['purchaseprice'] ?? '',
      expectation: json['expectation'] ?? false,
      receive: json['receive'] ?? false,
      name: json['name'] ?? '',
      family: json['family'] ?? '',
      snBuyProductLogin: (json['SN_BUY_PRODUCT_LOGIN'] as List<dynamic>?)
          ?.map((item) => LoginBuyProductSN.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'title': title,
      'supplier': supplier,
      'days': days,
      'datecreated': dateCreated,
      'dataclearing': dateClearing,
      'number': number,
      'datead': dateAd,
      'okbuy': okBuy,
      'hurry': hurry,
      'official': official,
      'purchaseprice': purchasePrice,
      'expectation': expectation,
      'receive': receive,
      'name': name,
      'family': family,
      'SN_BUY_PRODUCT_LOGIN':
      snBuyProductLogin.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}



class LoginBuyProductSN {
  String id;
  String collectionId;
  String collectionName;
  String title;
  String sn; // Assuming "SN" stands for a string value, you can change the type if necessary.
  DateTime created;
  DateTime updated;

  LoginBuyProductSN({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.title,
    required this.sn,
    required this.created,
    required this.updated,
  });

  factory LoginBuyProductSN.fromJson(Map<String, dynamic> json) {
    return LoginBuyProductSN(
      id: json['id'] ?? '',
      collectionId: json['collectionId'] ?? '',
      collectionName: json['collectionName'] ?? '',
      title: json['title'] ?? '',
      sn: json['SN'] ?? '',
      created: DateTime.parse(json['created'] ?? ''),
      updated: DateTime.parse(json['updated'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'title': title,
      'SN': sn,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}


import 'dart:convert';

import 'package:project/ANBAR/LoginBuyProductSN.dart';

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
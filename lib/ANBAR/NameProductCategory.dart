import 'dart:convert';

import 'package:project/ANBAR/buy_product.dart';


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
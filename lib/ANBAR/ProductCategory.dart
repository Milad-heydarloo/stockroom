
import 'dart:convert';

import 'package:project/ANBAR/NameProductCategory.dart';


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
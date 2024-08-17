import 'dart:convert';

import 'package:project/ANBAR/ProductCategory.dart';


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



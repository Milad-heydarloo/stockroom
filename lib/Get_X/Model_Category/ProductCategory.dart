import 'package:project/Get_X/Model_Category/NameProductCategory.dart';

class ProductCategory {
  final String id;
  final String title;
  final List<NameProductCategory> nameProductCategories;

  ProductCategory({
    required this.id,
    required this.title,
    required this.nameProductCategories,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json,
      List<NameProductCategory> nameProductCategories) {
    return ProductCategory(
      id: json['id'].toString(),
      title: json['title'].toString(),
      nameProductCategories: nameProductCategories,
    );
  }

  @override
  String toString() {
    return 'ProductCategory(id: $id, title: $title, nameProductCategories: ${nameProductCategories.length})';
  }
}
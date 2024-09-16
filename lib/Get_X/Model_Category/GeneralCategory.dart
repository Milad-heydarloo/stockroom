
import 'package:project/Get_X/Model_Category/ProductCategory.dart';

class GeneralCategory {
  final String id;
  final String titleFa;
  final String titleen;
  final List<ProductCategory> productCategories;

  GeneralCategory({
    required this.id,
    required this.titleFa,
    required this.titleen,
    required this.productCategories,
  });

  factory GeneralCategory.fromJson(
      Map<String, dynamic> json, List<ProductCategory> productCategories) {
    return GeneralCategory(
      id: json['id'].toString(),
      titleFa: json['titlefa'].toString(), // تغییر نام کلید به titlefa
      titleen: json['titleen'].toString(), // تغییر نام کلید به titlefa
      productCategories: productCategories,
    );
  }

  @override
  String toString() {
    return 'GeneralCategory(id: $id, titleFa: $titleFa, productCategories: ${productCategories.length})';
  }
}
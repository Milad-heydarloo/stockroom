
import 'package:project/Get_X/Model/buy_product.dart';

class ProductAtwo {
  String? id;
  String? title;
  String? salePrice;
  String? number;
  String? purchasePrice;
  String? description;
  List<String>? garranty;
  bool? unavailable;
  String? percent;
  SellBuyProducttwo? sellBuyProduct;


  ProductAtwo({
    this.id,
    this.title,
    this.salePrice,
    this.number,
    this.purchasePrice,
    this.description,
    this.garranty,
    this.unavailable,
    this.percent,

    this.sellBuyProduct,
  });

  factory ProductAtwo.fromJson(Map<String, dynamic> json) {
    return ProductAtwo(
      id: json['id'] as String,
      title: json['title'] as String,
      number: json['number'] as String,
      description: json['description'] as String,
      garranty: (json['garranty'] as List<dynamic>).map((e) => e as String).toList(),
      salePrice: json['saleprice'] as String,
      purchasePrice: json['purchaseprice'] as String,
      unavailable: json['unavailable'],
      percent: json['percent'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'garranty': garranty,
      'saleprice': salePrice,
      'number': number,
      'purchaseprice': purchasePrice,
      'description': description,
      'unavailable': unavailable,
      'percent': percent,
    };
  }
}

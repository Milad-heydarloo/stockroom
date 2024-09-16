
import 'package:project/Get_X/Model/login_buy_product_sn.dart';

class SellBuyProducttwo {

  String? id;
  String? title;
  String? purchasePrice;
  String? salePrice;
  String? supplier;
  String? number;


  String? days;
  String? dateCreated;
  String? dateClearing;
  bool? hurry;
  bool? official;
  bool? expectation;
  bool? receive;
  String? name;
  String? family;
  String? inventory;
  String? numberOfInventory;
  String? numberNow;
  String? typeOrder;
  List<String>? garranty;
  List<SNProducttwo>? snBuyProductLogin;
  SellBuyProducttwo({
    this.id,
    this.title,
    this.purchasePrice,
    this.salePrice,
    this.supplier,
    this.number,


    this.days,
    this.dateCreated,
    this.dateClearing,
    this.hurry,
    this.official,
    this.expectation,
    this.receive,
    this.name,
    this.family,
    this.inventory,
    this.numberOfInventory,
    this.numberNow,
    this.typeOrder,
    this.garranty,
    this.snBuyProductLogin,
  });

  factory SellBuyProducttwo.fromJson(Map<String, dynamic> json,
      List<SNProducttwo> login_buy_product_SN) {
    return SellBuyProducttwo(
      id: json['id'],
      title: json['title'],
      number: json['number'],
      purchasePrice: json['purchaseprice'],
      salePrice: json['saleprice'],
      snBuyProductLogin: login_buy_product_SN,

    );
  }
}
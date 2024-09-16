import 'package:project/Get_X/Model/buy_product.dart';

class OrderBuyProduct {
  final String id;
  final String companyname;
  final String phonenumber;
  final String mobilenumber;
  final String address;
  final String location;
  final String pricefactor;
  final List<SellBuyProducttwo> buy_product;

  OrderBuyProduct({
    required this.companyname,
    required this.id,
    required this.phonenumber,
    required this.mobilenumber,
    required this.address,
    required this.location,
    required this.buy_product,
    required this.pricefactor,
  });

  factory OrderBuyProduct.fromJson(
      Map<String, dynamic> json, List<SellBuyProducttwo> buy_product) {
    return OrderBuyProduct(
      id: json['id'].toString(),
      companyname: json['companyname'].toString(),
      pricefactor: json['pricefactor'].toString(),
      phonenumber: json['phonenumber'].toString(),
      // تغییر نام کلید به titlefa
      mobilenumber: json['mobilenumber'].toString(),
      // تغییر نام کلید به titlefa
      address: json['address'].toString(),
      // تغییر نام کلید به titlefa
      location: json['location'].toString(),
      // تغییر نام کلید به titlefa
      buy_product: buy_product,
    );
  }

  @override
  String toString() {
    return 'GeneralCategory(id: $companyname, titleFa: $phonenumber, productCategories: ${buy_product.length})';
  }
}

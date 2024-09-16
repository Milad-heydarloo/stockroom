
class login_buy_product_SN {
  final String id;
  final String sn;
  final String title;

  login_buy_product_SN({
    required this.id,
    required this.sn,
    required this.title,
  });

  // فرض کنید یک متد برای ایجاد یک شیء از JSON دارید
  factory login_buy_product_SN.fromJson(Map<String, dynamic> json) {
    return login_buy_product_SN(
      id: json['id'],
      sn: json['sn'],
      title: json['title'],
    );
  }
}

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


class BuyProduct {
  final String id;
  final String title;
  final String number;
  final String purchaseprice;
  final String saleprice;
  final List<login_buy_product_SN> snBuyProductLogin; // لیست ساب‌آیتم‌ها
  BuyProduct(
      {required this.id, required this.title, required this.snBuyProductLogin ,required this.number,required this.purchaseprice,required this.saleprice});

  // فرض کنید یک متد برای ایجاد یک شیء از JSON دارید
  factory BuyProduct.fromJson(Map<String, dynamic> json,
      List<login_buy_product_SN> login_buy_product_SN) {
    return BuyProduct(
      id: json['id'],
      title: json['title'],
      number: json['number'],
      purchaseprice: json['purchaseprice'],
      saleprice: json['saleprice'],
      snBuyProductLogin: login_buy_product_SN,

    );
  }
}
class OrderBuyProduct {
  final String id;
  final String companyname;
  final String phonenumber;
  final String mobilenumber;
  final String address;
  final String location;
  final String pricefactor;
  final List<BuyProduct> buy_product;

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
      Map<String, dynamic> json, List<BuyProduct> buy_product) {
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

class NameProductCategory {
  final String id;
  final String title;
  final String number;

  NameProductCategory({
    required this.id,
    required this.title,
    required this.number,
  });

  factory NameProductCategory.fromJson(Map<String, dynamic> json) {
    return NameProductCategory(
      id: json['id'].toString(),
      title: json['title'].toString(),
      number: json['number'].toString(),
    );
  }

  @override
  String toString() {
    return 'NameProductCategory(id: $id, title: $title)';
  }
}

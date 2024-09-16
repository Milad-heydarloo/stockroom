
class OrderNew {
  final String id;
  final String title;
  final String callnumber;
  final List<ProductAa> listProductAa;
  final List<ProductBb> listProductBb;
  final String datenow;
  final String datead;
  final String address;
  final String niyaz;
  final String phonenumberit;
  final String buy;
  final String winner;
  final String created;
  final String registration_number;
  final String national_code;
  final String postal_code;
  final String economic_code;
  final String accounting_number;
  final String purchase_number;
  final String type;
  final List<String> windows_type;

  OrderNew({
    required this.id,
    required this.title,
    required this.callnumber,
    required this.listProductAa,
    required this.listProductBb,
    required this.datenow,
    required this.datead,
    required this.address,
    required this.niyaz,
    required this.phonenumberit,
    required this.buy,
    required this.winner,
    required this.created,
    required this.registration_number,
    required this.national_code,
    required this.postal_code,
    required this.economic_code,
    required this.accounting_number,
    required this.purchase_number,
    required this.type,
    required this.windows_type,
  });

  factory OrderNew.fromJson(
      Map<String, dynamic> json,
      List<ProductAa> productsAa,
      List<ProductBb> productsBb,
      ) {
    return OrderNew(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      callnumber: json['callnumber']?.toString() ?? '',
      listProductAa: productsAa,
      listProductBb: productsBb,
      phonenumberit: json['phonenumberit']?.toString() ?? '',
      datenow: json['datenow']?.toString() ?? '',
      datead: json['datead']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      niyaz: json['niyaz']?.toString() ?? '',
      buy: json['buy']?.toString() ?? '',
      winner: json['winner']?.toString() ?? '',
      created: json['created']?.toString() ?? '',
      registration_number: json['registration_number']?.toString() ?? '',
      national_code: json['national_code']?.toString() ?? '',
      postal_code: json['postal_code']?.toString() ?? '',
      economic_code: json['economic_code']?.toString() ?? '',
      accounting_number: json['accounting_number']?.toString() ?? '',
      purchase_number: json['purchase_number']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      windows_type: List<String>.from(json['windows_type'] ?? []),
    );
  }
}

class ProductAa {
  final String id;
  final String title;
  final List<Garrantyy> garranty;
  final String saleprice;
  final String number;
  final String purchaseprice;
  final String description;
  final bool unavailable;
  final String percent;
  final BuyProductt listbuyProduct;

  ProductAa({
    required this.id,
    required this.title,
    required this.garranty,
    required this.saleprice,
    required this.number,
    required this.purchaseprice,
    required this.description,
    required this.unavailable,
    required this.percent,
    required this.listbuyProduct,
  });

  factory ProductAa.fromJson(Map<String, dynamic> json, BuyProductt buy, List<Garrantyy> gara) {
    return ProductAa(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      garranty: gara,
      saleprice: json['saleprice']?.toString() ?? '',
      number: json['number']?.toString() ?? '',
      purchaseprice: json['purchaseprice']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      unavailable: json['unavailable'] ?? false,
      percent: json['percent']?.toString() ?? '',
      listbuyProduct: buy,
    );
  }
}
class ProductA {
  final String id;
  final String title;
  final List<String> garranty;
  late final String saleprice;
  final String number;
  final String purchaseprice;
  final String description;
  late final bool unavailable;
  late final String percent;

  ProductA({
    required this.id,
    required this.title,
    required this.garranty,
    required this.saleprice,
    required this.number,
    required this.purchaseprice,
    required this.description,
    required this.unavailable,
    required this.percent,
  });

  factory ProductA.fromJson(Map<String, dynamic> json) {
    return ProductA(
      id: json['id'] as String,
      title: json['title'] as String,
      garranty:
      (json['garranty'] as List<dynamic>).map((e) => e as String).toList(),
      saleprice: json['saleprice'] as String,
      // تبدیل مقدار به String
      number: json['number'] as String,
      purchaseprice: json['purchaseprice'] as String,
      description: json['description'] as String,

      unavailable: json['unavailable'],
      percent: json['percent'] as String,
    );
  }
}
class Supplierr {
  final String id;
  final String companyname;
  final String phonenumber;
  final String mobilenumber;
  final String address;
  final String location;

  Supplierr({
    required this.id,
    required this.companyname,
    required this.phonenumber,
    required this.mobilenumber,
    required this.address,
    required this.location,
  });

  factory Supplierr.fromJson(Map<String, dynamic> json) {
    return Supplierr(
      id: json['id']?.toString() ?? '',
      companyname: json['companyname']?.toString() ?? '',
      phonenumber: json['phonenumber']?.toString() ?? '',
      mobilenumber: json['mobilenumber']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      location: json['location']?.toString() ?? '',
    );
  }

  @override
  String toString() =>
      'ID: $id, Company: $companyname, Phone: $phonenumber, Mobile: $mobilenumber, Address: $address, Location: $location';
}

class BuyProductt {
  final String id;
  final String title;
  final String number;
  final String purchaseprice;
  final String saleprice;
  final List<login_buy_product_SNn> snBuyProductLogin;
  final List<Garrantyy> garranty;
  final Supplierr supplier;

  BuyProductt({
    required this.id,
    required this.title,
    required this.number,
    required this.purchaseprice,
    required this.saleprice,
    required this.snBuyProductLogin,
    required this.garranty,
    required this.supplier,
  });

  factory BuyProductt.fromJson(
      Map<String, dynamic> json,
      List<login_buy_product_SNn> snBuyProductLogin,
      List<Garrantyy> garranty,
      Supplierr supplier,
      ) {
    return BuyProductt(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      number: json['number']?.toString() ?? '',
      purchaseprice: json['purchaseprice']?.toString() ?? '',
      saleprice: json['saleprice']?.toString() ?? '',
      snBuyProductLogin: snBuyProductLogin,
      garranty: garranty,
      supplier: supplier,
    );
  }

  @override
  String toString() =>
      'ID: $id, Title: $title, Number: $number, Purchase Price: $purchaseprice, Sale Price: $saleprice, SN List: $snBuyProductLogin, Garranty List: $garranty, Supplier: $supplier';
}

class login_buy_product_SNn {
  final String id;
  final String sn;
  final String title;

  login_buy_product_SNn({
    required this.id,
    required this.sn,
    required this.title,
  });

  factory login_buy_product_SNn.fromJson(Map<String, dynamic> json) {
    return login_buy_product_SNn(
      id: json['id']?.toString() ?? '',
      sn: json['sn']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
    );
  }
}

class Garrantyy {
  final String garranty;

  Garrantyy({required this.garranty});

  factory Garrantyy.fromJson(Map<String, dynamic> json) {
    return Garrantyy(
      garranty: json['Garrantyname']?.toString() ?? '',
    );
  }
}


class ProductBb {
  final String id;
  final String title;
  final String purchaseprice;
  final String supplier;
  final String days;
  final String datecreated;
  final String dataclearing;
  final String number;
  final String description;
  final String datead;
  final bool okbuy;
  final bool hurry;
  final bool official;

  ProductBb({
    required this.title,
    required this.purchaseprice,
    required this.id,
    required this.supplier,
    required this.days,
    required this.datecreated,
    required this.dataclearing,
    required this.number,
    required this.description,
    required this.datead,
    required this.okbuy,
    required this.hurry,
    required this.official,
  });

  factory ProductBb.fromJson(Map<String, dynamic> json) {
    return ProductBb(
      title: json['title']?.toString() ?? '',
      purchaseprice: json['purchaseprice']?.toString() ?? '',
      id: json['id']?.toString() ?? '',
      supplier: json['supplier']?.toString() ?? '',
      days: json['days']?.toString() ?? '',
      datecreated: json['datecreated']?.toString() ?? '',
      dataclearing: json['dataclearing']?.toString() ?? '',
      number: json['number']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      datead: json['datead']?.toString() ?? '',
      okbuy: json['okbuy'] ?? false,
      hurry: json['hurry'] ?? false,
      official: json['official'] ?? false,
    );
  }
}

class Productoneb {
  final String id;
  final String title;
  final String purchaseprice;
  final String supplier;
  final String days;
  final String datecreated;
  final String dataclearing;
  final String number;
  final String description;
  final String datead;
  final bool okbuy;
  final bool hurry;
  final bool official;

  Productoneb({
    required this.title,
    required this.purchaseprice,
    required this.id,
    required this.supplier,
    required this.days,
    required this.datecreated,
    required this.dataclearing,
    required this.number,
    required this.description,
    required this.datead,
    required this.okbuy,
    required this.hurry,
    required this.official,
  });

  factory Productoneb.fromJson(Map<String, dynamic> json) {
    return Productoneb(
      title: json['title']?.toString() ?? '',
      purchaseprice: json['purchaseprice']?.toString() ?? '',
      id: json['id']?.toString() ?? '',
      supplier: json['supplier']?.toString() ?? '',
      days: json['days']?.toString() ?? '',
      datecreated: json['datecreated']?.toString() ?? '',
      dataclearing: json['dataclearing']?.toString() ?? '',
      number: json['number']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      datead: json['datead']?.toString() ?? '',
      okbuy: json['okbuy'] ?? false,
      hurry: json['hurry'] ?? false,
      official: json['official'] ?? false,
    );
  }
}

class Productonea {
  final String id;
  final String title;
  final List<Garrantyy> garranty;
  final String saleprice;
  final String number;
  final String purchaseprice;
  final String description;
  final bool unavailable;
  final String percent;
  final List<String> listbuyProduct;

  Productonea({
    required this.id,
    required this.title,
    required this.garranty,
    required this.saleprice,
    required this.number,
    required this.purchaseprice,
    required this.description,
    required this.unavailable,
    required this.percent,
    required this.listbuyProduct,
  });

  factory Productonea.fromJson(Map<String, dynamic> json, List<String> buy, List<Garrantyy> gara) {
    return Productonea(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      garranty: gara,
      saleprice: json['saleprice']?.toString() ?? '',
      number: json['number']?.toString() ?? '',
      purchaseprice: json['purchaseprice']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      unavailable: json['unavailable'] ?? false,
      percent: json['percent']?.toString() ?? '',
      listbuyProduct: buy,
    );
  }
}


// class OrderNew {
//   final String id;
//   final String title;
//   final String callnumber;
//   final List<ProductA> listProductA;
//   final List<ProductB> listProductB;
//   final String datenow;
//   final String datead;
//   final String address;
//   final String niyaz;
//   final String phonenumberit;
//   final String buy;
//   final String winner;
//   final String created;
//   final String registration_number;
//   final String national_code;
//   final String postal_code;
//   final String economic_code;
//   final String accounting_number;
//   final String purchase_number;
//   final String type;
//   final List<String> windows_type;
//
//   OrderNew({
//     required this.id,
//     required this.title,
//     required this.callnumber,
//     required this.listProductA,
//     required this.listProductB,
//     required this.datenow,
//     required this.datead,
//     required this.address,
//     required this.niyaz,
//     required this.phonenumberit,
//     required this.buy,
//     required this.winner,
//     required this.created,
//     required this.registration_number,
//     required this.national_code,
//     required this.postal_code,
//     required this.economic_code,
//     required this.accounting_number,
//     required this.purchase_number,
//     required this.type,
//     required this.windows_type,
//   });
//
//   factory OrderNew.fromJson(Map<String, dynamic> json, List<ProductA> productsA,
//       List<ProductB> productsB) {
//     return OrderNew(
//       id: json['id'].toString(),
//       title: json['title'] ?? '',
//       callnumber: json['callnumber'] ?? '',
//       listProductA: productsA,
//       listProductB: productsB,
//       phonenumberit: json['phonenumberit'] ?? '',
//       datenow: json['datenow'] ?? '',
//       datead: json['datead'] ?? '',
//       address: json['address'] ?? '',
//       niyaz: json['niyaz'] ?? '',
//       buy: json['buy'] ?? '',
//       winner: json['winner'] ?? '',
//       created: json['created'] ?? '',
//       registration_number: json['registration_number'] ?? '',
//       national_code: json['national_code'] ?? '',
//       postal_code: json['postal_code'] ?? '',
//       economic_code: json['economic_code'] ?? '',
//       accounting_number: json['accounting_number'] ?? '',
//       purchase_number: json['purchase_number'] ?? '',
//       type: json['type'] ?? '',
//       windows_type: List<String>.from(json['windows_type'] ?? []),
//     );
//   }
// }
//
// class ProductA {
//   final String id;
//   final String title;
//   final List<String> garranty;
//   final String saleprice;
//   final String number;
//   final String purchaseprice;
//   final String description;
//   final bool unavailable;
//   final String percent;
//   final List<BuyProduct> listbuyProduct;
//
//   ProductA({
//     required this.id,
//     required this.title,
//     required this.garranty,
//     required this.saleprice,
//     required this.number,
//     required this.purchaseprice,
//     required this.description,
//     required this.unavailable,
//     required this.percent,
//     required this.listbuyProduct,
//   });
//
//   factory ProductA.fromJson(Map<String, dynamic> json, List<BuyProduct> buy) {
//     return ProductA(
//       id: json['id'] ?? '',
//       title: json['title'] ?? '',
//       garranty: List<String>.from(json['garranty'] ?? []),
//       saleprice: json['saleprice'] ?? '',
//       number: json['number'] ?? '',
//       purchaseprice: json['purchaseprice'] ?? '',
//       description: json['description'] ?? '',
//       unavailable: json['unavailable'] ?? false,
//       percent: json['percent'] ?? '',
//       listbuyProduct: buy,
//     );
//   }
// }
//
// class BuyProduct {
//   final String id;
//   final String title;
//   final String number;
//   final String purchaseprice;
//   final String saleprice;
//   final List<login_buy_product_SN> snBuyProductLogin;
//   final List<String> garranty;
//
//   BuyProduct({
//     required this.id,
//     required this.title,
//     required this.snBuyProductLogin,
//     required this.number,
//     required this.purchaseprice,
//     required this.saleprice,
//     required this.garranty,
//   });
//
//   factory BuyProduct.fromJson(
//       Map<String, dynamic> json,
//       List<login_buy_product_SN> login_buy_product_SN,
//       ) {
//     return BuyProduct(
//       id: json['id'] ?? '',
//       title: json['title'] ?? '',
//       number: json['number'] ?? '',
//       purchaseprice: json['purchaseprice'] ?? '',
//       saleprice: json['saleprice'] ?? '',
//       snBuyProductLogin: login_buy_product_SN,
//       garranty: List<String>.from(json['garranty'] ?? []),
//     );
//   }
// }
//
// class login_buy_product_SN {
//   final String id;
//   final String sn;
//   final String title;
//
//   login_buy_product_SN({
//     required this.id,
//     required this.sn,
//     required this.title,
//   });
//
//   factory login_buy_product_SN.fromJson(Map<String, dynamic> json) {
//     return login_buy_product_SN(
//       id: json['id'] ?? '',
//       sn: json['sn'] ?? '',
//       title: json['title'] ?? '',
//     );
//   }
// }
//
// class ProductB {
//   final String id;
//   final String title;
//   final String purchaseprice;
//   final String supplier;
//   final String days;
//   final String datecreated;
//   final String dataclearing;
//   final String number;
//   final String description;
//   final String datead;
//   final bool okbuy;
//   final bool hurry;
//   final bool official;
//
//   ProductB({
//     required this.title,
//     required this.purchaseprice,
//     required this.id,
//     required this.supplier,
//     required this.days,
//     required this.datecreated,
//     required this.dataclearing,
//     required this.number,
//     required this.description,
//     required this.datead,
//     required this.okbuy,
//     required this.hurry,
//     required this.official,
//   });
//
//   factory ProductB.fromJson(Map<String, dynamic> json) {
//     return ProductB(
//       title: json['title'] ?? '',
//       purchaseprice: json['purchaseprice'] ?? '',
//       id: json['id'] ?? '',
//       supplier: json['supplier'] ?? '',
//       days: json['days'] ?? '',
//       datecreated: json['datecreated'] ?? '',
//       dataclearing: json['dataclearing'] ?? '',
//       number: json['number'] ?? '',
//       description: json['description'] ?? '',
//       datead: json['datead'] ?? '',
//       okbuy: json['okbuy'] ?? false,
//       hurry: json['hurry'] ?? false,
//       official: json['official'] ?? false,
//     );
//   }
// }
//
//
// class Supplier {
//   final String id;
//   final String created;
//   final String updated;
//   final String collectionId;
//   final String collectionName;
//   final String address;
//   final String companyName;
//   final String location;
//   final String mobileNumber;
//   final String phoneNumber;
//
//   Supplier({
//     required this.id,
//     required this.created,
//     required this.updated,
//     required this.collectionId,
//     required this.collectionName,
//     required this.address,
//     required this.companyName,
//     required this.location,
//     required this.mobileNumber,
//     required this.phoneNumber,
//   });
//
//   factory Supplier.fromJson(Map<String, dynamic> json) {
//     return Supplier(
//       id: json['id'] ?? '',
//       created: json['created'] ?? '',
//       updated: json['updated'] ?? '',
//       collectionId: json['collectionId'] ?? '',
//       collectionName: json['collectionName'] ?? '',
//       address: json['address'] ?? '',
//       companyName: json['companyname'] ?? '',
//       location: json['location'] ?? '',
//       mobileNumber: json['mobilenumber'] ?? '',
//       phoneNumber: json['phonenumber'] ?? '',
//     );
//   }
// }
//
// class SnBuyProductLogin {
//   final String id;
//   final String created;
//   final String updated;
//   final String collectionId;
//   final String collectionName;
//   final String sn;
//   final String title;
//
//   SnBuyProductLogin({
//     required this.id,
//     required this.created,
//     required this.updated,
//     required this.collectionId,
//     required this.collectionName,
//     required this.sn,
//     required this.title,
//   });
//
//   factory SnBuyProductLogin.fromJson(Map<String, dynamic> json) {
//     return SnBuyProductLogin(
//       id: json['id'] ?? '',
//       created: json['created'] ?? '',
//       updated: json['updated'] ?? '',
//       collectionId: json['collectionId'] ?? '',
//       collectionName: json['collectionName'] ?? '',
//       sn: json['sn'] ?? '',
//       title: json['title'] ?? '',
//     );
//   }
// }
//
// class SellBuyProduct {
//   final String id;
//   final String created;
//   final String updated;
//   final String collectionId;
//   final String collectionName;
//   final List<SnBuyProductLogin> snBuyProductLogin;
//   final Supplier supplier;
//
//   SellBuyProduct({
//     required this.id,
//     required this.created,
//     required this.updated,
//     required this.collectionId,
//     required this.collectionName,
//     required this.snBuyProductLogin,
//     required this.supplier,
//   });
//
//   factory SellBuyProduct.fromJson(Map<String, dynamic> json) {
//     var snList = json['sn_buy_product_login'] as List;
//     List<SnBuyProductLogin> snBuyProductLoginList =
//     snList.map((i) => SnBuyProductLogin.fromJson(i)).toList();
//
//     return SellBuyProduct(
//       id: json['id'] ?? '',
//       created: json['created'] ?? '',
//       updated: json['updated'] ?? '',
//       collectionId: json['collectionId'] ?? '',
//       collectionName: json['collectionName'] ?? '',
//       snBuyProductLogin: snBuyProductLoginList,
//       supplier: Supplier.fromJson(json['supplier'] ?? {}),
//     );
//   }
// }
//
// class ListProductA {
//   final String id;
//   final String created;
//   final String updated;
//   final String collectionId;
//   final String collectionName;
//   final SellBuyProduct sellBuyProduct;
//
//   ListProductA({
//     required this.id,
//     required this.created,
//     required this.updated,
//     required this.collectionId,
//     required this.collectionName,
//     required this.sellBuyProduct,
//   });
//
//   factory ListProductA.fromJson(Map<String, dynamic> json) {
//     return ListProductA(
//       id: json['id'] ?? '',
//       created: json['created'] ?? '',
//       updated: json['updated'] ?? '',
//       collectionId: json['collectionId'] ?? '',
//       collectionName: json['collectionName'] ?? '',
//       sellBuyProduct: SellBuyProduct.fromJson(json['sell_buy_product'] ?? {}),
//     );
//   }
// }
//
// class ProductB {
//   final String id;
//   final String name;
//   final double price;
//
//   ProductB({
//     required this.id,
//     required this.name,
//     required this.price,
//   });
//
//   factory ProductB.fromJson(Map<String, dynamic> json) {
//     return ProductB(
//       id: json['id'] ?? '',
//       name: json['name'] ?? '',
//       price: json['price']?.toDouble() ?? 0.0,
//     );
//   }
// }
//
// class OrderFa {
//   final String id;
//   final String created;
//   final String updated;
//   final String collectionId;
//   final String collectionName;
//   final String accountingNumber;
//   final String address;
//   final String buy;
//   final String callnumber;
//   final String datead;
//   final String datenow;
//   final String economicCode;
//   final String family;
//   final List<ListProductA> listProductA;
//   final List<ProductB> listProductB; // تغییر از String به کلاس ProductB
//   final String name;
//   final String nationalCode;
//   final String niyaz;
//   final String phonenumberIt;
//   final String postalCode;
//   final String purchaseNumber;
//   final String registrationNumber;
//   final String title;
//   final String type;
//   final List<String> windowsType;
//   final double winner;
//
//   OrderFa({
//     required this.id,
//     required this.created,
//     required this.updated,
//     required this.collectionId,
//     required this.collectionName,
//     required this.accountingNumber,
//     required this.address,
//     required this.buy,
//     required this.callnumber,
//     required this.datead,
//     required this.datenow,
//     required this.economicCode,
//     required this.family,
//     required this.listProductA,
//     required this.listProductB,
//     required this.name,
//     required this.nationalCode,
//     required this.niyaz,
//     required this.phonenumberIt,
//     required this.postalCode,
//     required this.purchaseNumber,
//     required this.registrationNumber,
//     required this.title,
//     required this.type,
//     required this.windowsType,
//     required this.winner,
//   });
//
//   factory OrderFa.fromJson(Map<String, dynamic> json) {
//     var listA = json['expand']['listproducta'] as List;
//     List<ListProductA> listProductAList =
//     listA.map((i) => ListProductA.fromJson(i)).toList();
//
//     var listB = json['listproductb'] as List;
//     List<ProductB> listProductBList =
//     listB.map((i) => ProductB.fromJson(i)).toList();
//
//     return OrderFa(
//       id: json['id'] ?? '',
//       created: json['created'] ?? '',
//       updated: json['updated'] ?? '',
//       collectionId: json['collectionId'] ?? '',
//       collectionName: json['collectionName'] ?? '',
//       accountingNumber: json['accounting_number'] ?? '',
//       address: json['address'] ?? '',
//       buy: json['buy'] ?? '',
//       callnumber: json['callnumber'] ?? '',
//       datead: json['datead'] ?? '',
//       datenow: json['datenow'] ?? '',
//       economicCode: json['economic_code'] ?? '',
//       family: json['family'] ?? '',
//       listProductA: listProductAList,
//       listProductB: listProductBList,
//       name: json['name'] ?? '',
//       nationalCode: json['national_code'] ?? '',
//       niyaz: json['niyaz'] ?? '',
//       phonenumberIt: json['phonenumberit'] ?? '',
//       postalCode: json['postal_code'] ?? '',
//       purchaseNumber: json['purchase_number'] ?? '',
//       registrationNumber: json['registration_number'] ?? '',
//       title: json['title'] ?? '',
//       type: json['type'] ?? '',
//       windowsType: List<String>.from(json['windows_type'] ?? []),
//       winner: json['winner']?.toDouble() ?? 0.0,
//     );
//   }
// }

import 'package:project/Get_X/Model/listproducta.dart';
import 'package:project/Get_X/Model/listproductb.dart';

class OrderTwo {
  String? id;
  String? title;
  String? callNumber;
  String? dateNow;
  String? dateAd;
  String? address;
  String? niyaz;
  String? phoneNumberIT;
  String? buy;
  String? winner;
  String? created;
  String? registrationNumber;
  String? nationalCode;
  String? postalCode;
  String? economicCode;
  String? accountingNumber;
  String? purchaseNumber;
  String? rating;
  String? type;
  String? type_order;
  String? name;
  String? family;
  List<String>? windowsType;
  List<ProductAtwo>? listProductA;
  List<ProductBtwo>? listProductB;

  OrderTwo({
    this.id,
    this.title,
    this.callNumber,
    this.dateNow,
    this.dateAd,
    this.address,
    this.niyaz,
    this.phoneNumberIT,
    this.buy,
    this.winner,
    this.created,
    this.registrationNumber,
    this.nationalCode,
    this.postalCode,
    this.economicCode,
    this.accountingNumber,
    this.family,
    this.purchaseNumber,
    this.rating,
    this.type,
    this.name,
    this.type_order,
    this.windowsType,
    this.listProductA,
    this.listProductB,
  });

  factory OrderTwo.fromJson(Map<String, dynamic> json, List<ProductAtwo> productsA, List<ProductBtwo> productsB) {
    return OrderTwo(
      id: json['id']?.toString(),
      title: json['title']?.toString(),
      callNumber: json['callnumber']?.toString(),
      listProductA: productsA,
      listProductB: productsB,
      phoneNumberIT: json['phonenumberit']?.toString(),
      dateNow: json['datenow']?.toString(),
      dateAd: json['datead']?.toString(),
      address: json['address']?.toString(),
      niyaz: json['niyaz']?.toString(),
      buy: json['buy']?.toString(),
      family: json['family']?.toString(),
      rating: json['rating']?.toString(),
      type_order: json['type_order']?.toString(),
      winner: json['winner']?.toString(),
      name: json['name']?.toString(),
      created: json['created']?.toString(),
      registrationNumber: json['registration_number']?.toString(),
      nationalCode: json['national_code']?.toString(),
      postalCode: json['postal_code']?.toString(),
      economicCode: json['economic_code']?.toString(),
      accountingNumber: json['accounting_number']?.toString(),
      purchaseNumber: json['purchase_number']?.toString(),
      windowsType: List<String>.from(json['windows_type'] ?? []), // اگر نیاز به پردازش لیست دارید
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'callnumber': callNumber,
      'listProductA': listProductA?.map((product) => product.toJson()).toList(),
      'listProductB': listProductB?.map((product) => product.toJson()).toList(),
      'datenow': dateNow,
      'datead': dateAd,
      'address': address,
      'niyaz': niyaz,
      'phonenumberit': phoneNumberIT,
      'buy': buy,
      'rating': rating,
      'type_order': type_order,
      'winner': winner,
      'name': name,
      'family': family,
      'created': created,
      'registration_number': registrationNumber,
      'national_code': nationalCode,
      'postal_code': postalCode,
      'economic_code': economicCode,
      'accounting_number': accountingNumber,
      'purchase_number': purchaseNumber,
      'windows_type': windowsType,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    callNumber,
    listProductA,
    listProductB,
    dateNow,
    dateAd,
    address,
    niyaz,
    name,
    phoneNumberIT,
    buy,
    family,
    rating,
    type_order,
    winner,
    created,
    registrationNumber,
    nationalCode,
    postalCode,
    economicCode,
    accountingNumber,
    purchaseNumber,
    windowsType,
  ];
}

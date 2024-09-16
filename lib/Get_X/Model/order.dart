
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
  String? type;
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
    this.purchaseNumber,
    this.type,
    this.windowsType,
    this.listProductA,
    this.listProductB,
  });





  factory OrderTwo.fromJson(Map<String, dynamic> json, List<ProductAtwo> productsA, List<ProductBtwo> productsB) {
    return OrderTwo(
      id: json['id'].toString(),
      title: json['title'].toString(),
      callNumber: json['callnumber'].toString(),
      listProductA: productsA,
      listProductB: productsB,
      phoneNumberIT: json['phonenumberit'].toString() ?? '',
      dateNow: json['datenow'].toString() ?? '',
      dateAd: json['datead'].toString() ?? '',
      address: json['address'].toString() ?? '',
      niyaz: json['niyaz'].toString() ?? '',
      buy: json['buy'].toString() ?? '',
      winner: json['winner'].toString() ?? '',
      created: json['created'].toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'callnumber': callNumber,
      'listProductA': listProductA!.map((product) => product.toJson()).toList(),
      'listProductB': listProductB!.map((product) => product.toJson()).toList(),
      'datenow': dateNow,
      'datead': dateAd,
      'address': address,
      'niyaz': niyaz,
      'phonenumberit': phoneNumberIT,
      'buy': buy,
      'winner': winner,
      'created': created,
    };
  }

  @override
  List<Object> get props => [
    id!,
    title!,
    callNumber!,
    listProductA!,
    listProductB!,
    dateNow!,
    dateAd!,
    address!,
    niyaz!,
    phoneNumberIT!,
    buy!,
    winner!,
    created!,
  ];


}

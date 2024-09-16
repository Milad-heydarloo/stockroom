class ProductBtwo {
  String? id;
  String? title;
  String? purchasePrice;
  String? supplier;
  String? days;
  String? dateCreated;
  String? dateClearing;
  String? number;
  String? description;
  String? dateAd;
  bool? okBuy;
  bool? hurry;
  bool? official;

  ProductBtwo({
    this.id,
    this.title,
    this.purchasePrice,
    this.supplier,
    this.days,
    this.dateCreated,
    this.dateClearing,
    this.number,
    this.description,
    this.dateAd,
    this.okBuy,
    this.hurry,
    this.official,
  });


  factory ProductBtwo.fromJson(Map<String, dynamic> json) {
    return ProductBtwo(
      id: json['id'].toString(),
      title: json['title'].toString(),
      number: json['number'].toString(),
      description: json['description'].toString(),
      purchasePrice: json['purchaseprice'].toString(),
      supplier: json['supplier'].toString(),
      days: json['days'].toString(),
      dateCreated: json['datecreated'].toString(),
      dateClearing: json['dataclearing'].toString(),
      okBuy: json['okbuy'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'purchaseprice': purchasePrice,
      'supplier': supplier,
      'days': days,
      'datecreated': dateCreated,
      'dataclearing': dateClearing,
      'number': number,
      'description': description,
      'okbuy': okBuy,
    };
  }
}

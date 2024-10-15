


class SNProducttwo {
  String? id;
  String? sn;
  String? title;
  String? buy_product;
  String? name_product_category;
  String? inventory;
  String? Number_of_inventory;
  String? number_now;
  String? date_sh;

  SNProducttwo({
    this.id,
    this.sn,
    this.title,
    this.buy_product,
    this.name_product_category,
    this.inventory,
    this.Number_of_inventory,
    this.number_now,
    this.date_sh,
  });

  factory SNProducttwo.fromJson(Map<String, dynamic> json) {
    return SNProducttwo(
      id: json['id'],
      sn: json['sn'],
      title: json['title'],
      buy_product: json['buy_product'],
      name_product_category: json['name_product_category'],
      inventory: json['inventory'],
      Number_of_inventory: json['Number_of_inventory'],
      number_now: json['number_now'],
      date_sh: json['date_sh'],

    );
  }
}

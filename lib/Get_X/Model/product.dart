


class Product {
  final String nameproduct;

  Product({required this.nameproduct});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(nameproduct: json['nameproduct'].toString());
  }
}
class Garrantyy {
  final String garranty;

  Garrantyy({required this.garranty});

  factory Garrantyy.fromJson(Map<String, dynamic> json) {
    return Garrantyy(
      garranty: json['Garrantyname']?.toString() ?? '',
    );
  }
}
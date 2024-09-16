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


  factory NameProductCategory.fromJsonNotID(Map<String, dynamic> json, String id) {
    return NameProductCategory(
      id: id, // استفاده از id ورودی
      title: json['title'].toString(),
      number: json['number'].toString(),
    );
  }


  @override
  String toString() {
    return 'NameProductCategory(id: $id, title: $title)';
  }
}

import 'dart:convert';

class LoginBuyProductSN {
  String id;
  String collectionId;
  String collectionName;
  String title;
  String sn; // Assuming "SN" stands for a string value, you can change the type if necessary.
  DateTime created;
  DateTime updated;

  LoginBuyProductSN({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.title,
    required this.sn,
    required this.created,
    required this.updated,
  });

  factory LoginBuyProductSN.fromJson(Map<String, dynamic> json) {
    return LoginBuyProductSN(
      id: json['id'] ?? '',
      collectionId: json['collectionId'] ?? '',
      collectionName: json['collectionName'] ?? '',
      title: json['title'] ?? '',
      sn: json['SN'] ?? '',
      created: DateTime.parse(json['created'] ?? ''),
      updated: DateTime.parse(json['updated'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'collectionName': collectionName,
      'title': title,
      'SN': sn,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
    };
  }

  @override
  String toString() => jsonEncode(toJson());
}

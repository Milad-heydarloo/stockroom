class Supplier {
  final String id;
  final String collectionId;
  final String collectionName;

  final String companyName;
  final String phoneNumber;
  final String mobileNumber;
  final String address;
  final String location;

  Supplier({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.companyName,
    required this.phoneNumber,
    required this.mobileNumber,
    required this.address,
    required this.location,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'],
      collectionId: json['collectionId'],
      collectionName: json['collectionName'],
      companyName: json['companyname'],
      phoneNumber: json['phonenumber'],
      mobileNumber: json['mobilenumber'],
      address: json['address'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'collectionId': collectionId,
      'companyname': companyName,
      'phonenumber': phoneNumber,
      'mobilenumber': mobileNumber,
      'address': address,
      'location': location,
    };
  }
}

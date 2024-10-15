import 'package:get/get.dart';
import 'package:project/Get_X/Service/PocketBaseService.dart';
import 'supplier_model.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:geolocator/geolocator.dart';

class SupplierController extends GetxController {
  final PocketBaseManager _pocketBaseManager;

  SupplierController()
      : _pocketBaseManager =   PocketBaseManager(url: 'http://192.168.10.126:9000', lang: 'en-US');

  PocketBase get pb => _pocketBaseManager.client;



  List<Supplier> suppliers = [];
  String currentLocation = ''; // برای ذخیره موقعیت فعلی

  @override
  void onInit() {
    super.onInit();
  //  fetchSuppliers();
  }

  Future<void> fetchSuppliers() async {
    try {
      final resultList = await pb.collection('suppliers').getFullList(sort: '-created');
      suppliers = resultList.map((item) {
        final data = item.data;
        final location = data['location'] as String? ?? '';
        return Supplier(
          id: data['id'] as String? ?? '',
          collectionId: data['collectionId'] as String? ?? '',
          collectionName: data['collectionName'] as String? ?? '',
          companyName: data['companyname'] as String? ?? '',
          phoneNumber: data['phonenumber'] as String? ?? '',
          mobileNumber: data['mobilenumber'] as String? ?? '',
          address: data['address'] as String? ?? '',
          location: location,
        );
      }).toList();
      update(); // Notify listeners
    } catch (e) {
      print('Error fetching suppliers: $e');
    }
  }

  Future<void> addSupplier(Supplier supplier) async {
    try {
      final data = {
        'companyname': supplier.companyName,
        'phonenumber': supplier.phoneNumber,
        'mobilenumber': supplier.mobileNumber,
        'address': supplier.address,
        'location': supplier.location,
      };
      await pb.collection('suppliers').create(body: data);

    await  fetchSuppliers(); // Refresh the list

    } catch (e) {
      print('Error adding supplier: $e');
    }
  }



  Future<void> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition();
      currentLocation = '${position.latitude},${position.longitude}';
    } catch (e) {
      print('Error getting location: $e');
    }
  }

}

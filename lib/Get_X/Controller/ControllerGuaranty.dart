



import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:project/Get_X/Model_Category/Garrantyy.dart';

import 'package:project/Get_X/Service/PocketBaseService.dart';

class ControllerGuaranty extends GetxController{

  final PocketBaseManager _pocketBaseManager;

  ControllerGuaranty()
      : _pocketBaseManager = PocketBaseManager(url: 'http://192.168.10.126:9000', lang: 'en-US');

  PocketBase get _pb => _pocketBaseManager.client;


  @override
  void onInit() async {
    // TODO: implement onInit
   await FetchGuarantyProduct();
    super.onInit();
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  List<Garrantyy> fetchGuarantyProductItems = [];
  Future<void> FetchGuarantyProduct() async {
    try {
      final resultList = await _pb.collection('garrantya').getList();
      //  print('dddd' + resultList.items.toString());
      List<Garrantyy> garrantyItems = [];
      print(garrantyItems.length);
      for (var item in resultList.items) {
        final data = item.toJson();
        if (data.containsKey('Garrantyname')) {
          //    print(item.collectionName.toString());
          garrantyItems.add(Garrantyy.fromJson(data));
        }
      }
      fetchGuarantyProductItems = garrantyItems;
      update(['garrantya']);
    } catch (error) {
      print('Error fetching selected garranty items: $error');
    }
  }

}
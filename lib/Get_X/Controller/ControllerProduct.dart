import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:project/Get_X/Model/product.dart';
import 'package:project/Get_X/Service/PocketBaseService.dart';

class ControllerProduct extends GetxController {
  final PocketBaseManager _pocketBaseManager;

  ControllerProduct()
      : _pocketBaseManager =
  PocketBaseManager(url: 'http://192.168.10.126:9000', lang: 'en-US');

  PocketBase get _pb => _pocketBaseManager.client;

  @override
  void onInit() async {
    // TODO: implement onInit
    await fetchAllProducts();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  List<Product> selectedProductItems = [];

  Future<List<Product>> fetchAllProducts() async {
    List<Product> allProducts = [];
    int page = 1;
    int perPage = 50; // تعداد محصولات در هر صفحه

    while (true) {
      final resultList = await _pb.collection('product').getList(
            page: page,
            perPage: perPage,
          );

      List<Product> pageItems = resultList.items
          .map((item) => Product.fromJson(item.toJson()))
          .toList();
      if (pageItems.isEmpty) {
        break; // اگر صفحه خالی باشد، خارج می‌شویم
      }
      selectedProductItems.addAll(pageItems);
      page++;
    }
    print('object');
    update(['product']);
    return allProducts;
  }
}

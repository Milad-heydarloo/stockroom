import 'package:get/get.dart';
import 'package:project/BUY/ControllerBuy/GeneralCategoryController.dart';
import 'package:project/BUY/4/SupplierDetailsPage.dart';
import 'package:project/Drawer/DrawerController.dart';
import 'package:project/Drawer/auth_controller.dart';
import 'package:project/Get_X/Controller/ControllerGuaranty.dart';
import 'package:project/Get_X/Controller/ControllerOrder.dart';
import 'package:project/Get_X/Controller/ControllerProduct.dart';
import 'package:project/archivecontroler.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.put(AuthController(),
        permanent: true); // Ensure AuthController is always in memory
    Get.put(OrderControllerPage());
    Get.put(ControllerGuaranty());
    Get.put(ControllerProduct());
    Get.put(GeneralCategoryController()); // ثبت کنترلر
    Get.put(MyDrawerController());
    Get.put(SupplierDetailsController()); // ثبت کنترلر
    Get.put(OrderArchiveControllerPage()); // ثبت کنترلر
  }
}

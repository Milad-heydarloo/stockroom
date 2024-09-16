
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project/BUY/ControllerBuy/GeneralCategoryController.dart';
import 'package:project/BUY/ModelBuy/model.dart';
import 'package:project/Drawer/MyDrawer.dart';






class general_category_page_static extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // دستیابی به کنترلر
    final GeneralCategoryController controller = Get.find();
    controller.fetch_order_buy_product();
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text('دسته بندی محصولات'),
      ),
      body: GetBuilder<GeneralCategoryController>(
        id: "update",
        builder: (controller) {
          if (controller.generalCategories.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: controller.generalCategories.length,
            itemBuilder: (context, index) {
              final generalCategory = controller.generalCategories[index];

              return ExpansionTile(
                backgroundColor: Colors.grey[200],
                title: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              create_sub_CategoryDialog(
                                  context, controller, generalCategory.id);
                              //  showEditCategoryDialog(context, controller, generalCategory);
                            },
                            icon: Icon(Icons.add)),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(generalCategory.titleen),
                              Text(generalCategory.titleFa)
                            ]),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              showEditCategoryDialog(
                                  context, controller, generalCategory);
                            },
                            icon: Icon(Icons.edit)),
                      ],
                    ),
                  ),
                ),
                children:
                generalCategory.productCategories.map((productCategory) {
                  return ExpansionTile(
                    backgroundColor: Colors.grey[300],
                    title: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Container(
                          alignment: Alignment.bottomRight,
                          child: Row(children: [
                            IconButton(
                                onPressed: () {
                                  create_product_to_sub_CategoryDialog(
                                      context, controller, productCategory.id);
                                },
                                icon: Icon(Icons.add)),
                            Text(productCategory.title),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  edit_sub_CategoryDialog(
                                      context,
                                      controller,
                                      productCategory.title,
                                      productCategory.id);
                                },
                                icon: Icon(Icons.edit)),
                          ]),
                        )),
                    children: productCategory.nameProductCategories.isNotEmpty
                        ? productCategory.nameProductCategories
                        .map((nameProductCategory) {
                      return Container(
                          color: Colors.grey[350],
                          child: ListTile(
                            title: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  alignment: Alignment.bottomRight,
                                  child: Row(children: [
                                    // IconButton(
                                    //   onPressed: () {
                                    //     Get.to(() => Details(
                                    //       title: nameProductCategory
                                    //           .title,
                                    //       number: nameProductCategory
                                    //           .number,
                                    //       id: nameProductCategory.id,
                                    //
                                    //       idproduct:
                                    //       nameProductCategory.id,
                                    //     ));
                                    //   },
                                    //   icon: Icon(Icons.arrow_back),
                                    // ),
                                    Text(nameProductCategory.title),
                                    Text(' تعداد موجود :  '),
                                    Text(nameProductCategory.number),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () {

                                          //ffffff
                                          edit_name_product_sub_CategoryDialog(context, controller, nameProductCategory.title, nameProductCategory.id);
                                        },
                                        icon: Icon(Icons.edit)),
                                  ]),
                                )),
                          ));
                    }).toList()
                        : [
                      ListTile(
                          title: Text('No name categories available'))
                    ],
                  );
                }).toList(),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // controller.createOrderBuyProduct(
            //     controller.selectedSupplierID.toString());
            createCategoryDialog(context, controller);
          },
          child: Icon(Icons.add)),
    );
  }



  void edit_name_product_sub_CategoryDialog(BuildContext context,
      GeneralCategoryController controller, String title, String id) {
    final TextEditingController titleEnController =
    TextEditingController(text: title);
    //  final TextEditingController titleFaController = TextEditingController();

    Get.defaultDialog(
      title: 'ویرایش محصول زیر دسته بندی',
      content: Column(
        children: [
          TextField(
            controller: titleEnController,
            decoration: InputDecoration(labelText: 'Title (EN)'),
          ),
          // TextField(
          //   controller: titleFaController,
          //   decoration: InputDecoration(labelText: 'Title (FA)'),
          // ),
          // TextField(
          //   controller: productCategoryController,
          //   decoration: InputDecoration(labelText: 'Product Category (IDs)'),
          // ),
        ],
      ),
      textCancel: 'لغو',
      textConfirm: 'ذخیره',
      onConfirm: () {
        final body = <String, dynamic>{
          'title': titleEnController.text,
          // 'titlefa': titleFaController.text,
          // 'product_category': productCategoryController.text.split(',').map((e) => e.trim()).toList(),
// 'name_product_category':['${id}']
        };

        controller.updateproductSubGeneralCategory(id, body);
        Get.back(); // Close the dialog
      },
    );
  }


  void create_product_to_sub_CategoryDialog(
      BuildContext context, GeneralCategoryController controller, String id) {
    final TextEditingController titleEnController = TextEditingController();
    //  final TextEditingController titleFaController = TextEditingController();

    Get.defaultDialog(
      title: 'اضافه کردن محصول زیر دسته بندی',
      content: Column(
        children: [
          TextField(
            controller: titleEnController,
            decoration: InputDecoration(labelText: 'Title (EN)'),
          ),
          // TextField(
          //   controller: titleFaController,
          //   decoration: InputDecoration(labelText: 'Title (FA)'),
          // ),
          // TextField(
          //   controller: productCategoryController,
          //   decoration: InputDecoration(labelText: 'Product Category (IDs)'),
          // ),
        ],
      ),
      textCancel: 'لغو',
      textConfirm: 'ذخیره',
      onConfirm: () {
        final body = <String, dynamic>{
          'title': titleEnController.text,
          'number': 0
          // 'titlefa': titleFaController.text,
          // 'product_category': productCategoryController.text.split(',').map((e) => e.trim()).toList(),
// 'name_product_category':['${id}']
        };

        controller.createproductSubGeneralCategory(body, id);
        Get.back(); // Close the dialog
      },
    );
  }

  void create_sub_CategoryDialog(
      BuildContext context, GeneralCategoryController controller, String id) {
    final TextEditingController titleEnController = TextEditingController();
    //  final TextEditingController titleFaController = TextEditingController();

    Get.defaultDialog(
      title: 'اضافه کردن زیر دسته بندی',
      content: Column(
        children: [
          TextField(
            controller: titleEnController,
            decoration: InputDecoration(labelText: 'Title (EN)'),
          ),
          // TextField(
          //   controller: titleFaController,
          //   decoration: InputDecoration(labelText: 'Title (FA)'),
          // ),
          // TextField(
          //   controller: productCategoryController,
          //   decoration: InputDecoration(labelText: 'Product Category (IDs)'),
          // ),
        ],
      ),
      textCancel: 'لغو',
      textConfirm: 'ذخیره',
      onConfirm: () {
        final body = <String, dynamic>{
          'title': titleEnController.text,
          // 'titlefa': titleFaController.text,
          // 'product_category': productCategoryController.text.split(',').map((e) => e.trim()).toList(),
// 'name_product_category':['${id}']
        };

        controller.createSubGeneralCategory(body, id);
        Get.back(); // Close the dialog
      },
    );
  }

  void edit_sub_CategoryDialog(BuildContext context,
      GeneralCategoryController controller, String title, String id) {
    final TextEditingController titleEnController =
    TextEditingController(text: title);
    //  final TextEditingController titleFaController = TextEditingController();

    Get.defaultDialog(
      title: 'اضافه کردن زیر دسته بندی',
      content: Column(
        children: [
          TextField(
            controller: titleEnController,
            decoration: InputDecoration(labelText: 'Title (EN)'),
          ),
          // TextField(
          //   controller: titleFaController,
          //   decoration: InputDecoration(labelText: 'Title (FA)'),
          // ),
          // TextField(
          //   controller: productCategoryController,
          //   decoration: InputDecoration(labelText: 'Product Category (IDs)'),
          // ),
        ],
      ),
      textCancel: 'لغو',
      textConfirm: 'ذخیره',
      onConfirm: () {
        final body = <String, dynamic>{
          'title': titleEnController.text,
          // 'titlefa': titleFaController.text,
          // 'product_category': productCategoryController.text.split(',').map((e) => e.trim()).toList(),
// 'name_product_category':['${id}']
        };

        controller.updateSubGeneralCategory(id, body);
        Get.back(); // Close the dialog
      },
    );
  }

  void createCategoryDialog(
      BuildContext context, GeneralCategoryController controller) {
    final TextEditingController titleEnController = TextEditingController();
    final TextEditingController titleFaController = TextEditingController();

    Get.defaultDialog(
      title: 'اضافه کردن دسته بندی',
      content: Column(
        children: [
          TextField(
            controller: titleEnController,
            decoration: InputDecoration(labelText: 'Title (EN)'),
          ),
          TextField(
            controller: titleFaController,
            decoration: InputDecoration(labelText: 'Title (FA)'),
          ),
          // TextField(
          //   controller: productCategoryController,
          //   decoration: InputDecoration(labelText: 'Product Category (IDs)'),
          // ),
        ],
      ),
      textCancel: 'لغو',
      textConfirm: 'ذخیره',
      onConfirm: () {
        final body = <String, dynamic>{
          'titleen': titleEnController.text,
          'titlefa': titleFaController.text,
          // 'product_category': productCategoryController.text.split(',').map((e) => e.trim()).toList(),
        };

        controller.createGeneralCategory(body);
        Get.back(); // Close the dialog
      },
    );
  }

  void showEditCategoryDialog(BuildContext context,
      GeneralCategoryController controller, GeneralCategory generalCategory) {
    final TextEditingController titleEnController =
    TextEditingController(text: generalCategory.titleen);
    final TextEditingController titleFaController =
    TextEditingController(text: generalCategory.titleFa);
    final TextEditingController productCategoryController =
    TextEditingController(
        text: generalCategory.productCategories?.join(', ') ?? '');

    Get.defaultDialog(
      title: 'ویرایش دسته بندی',
      content: Column(
        children: [
          TextField(
            controller: titleEnController,
            decoration: InputDecoration(labelText: 'Title (EN)'),
          ),
          TextField(
            controller: titleFaController,
            decoration: InputDecoration(labelText: 'Title (FA)'),
          ),
          // TextField(
          //   controller: productCategoryController,
          //   decoration: InputDecoration(labelText: 'Product Category (IDs)'),
          // ),
        ],
      ),
      textCancel: 'لغو',
      textConfirm: 'ذخیره',
      onConfirm: () {
        final body = <String, dynamic>{
          'titleen': titleEnController.text,
          'titlefa': titleFaController.text,
          // 'product_category': productCategoryController.text.split(',').map((e) => e.trim()).toList(),
        };

        controller.updateGeneralCategory(generalCategory.id, body);
        Get.back(); // Close the dialog
      },
    );
  }
}

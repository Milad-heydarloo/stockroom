


import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

import 'package:get/get.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:project/Drawer/auth_controller.dart';
import 'package:project/Drawer/routes.dart';

import 'package:project/Get_X/Controller/ControllerGuaranty.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'package:project/Get_X/Controller/ControllerOrder.dart';
import 'package:project/Drawer/MyDrawer.dart';
import 'package:project/Get_X/Controller/ControllerProduct.dart';
import 'package:project/Get_X/Controller/MyBinding.dart';

import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:project/Get_X/Model/buy_product.dart';
import 'package:project/modir_site/DarsadDehi/darsade.dart';
import 'package:project/modir_site/Block/tech_bloc.dart';
import 'package:searchfield/searchfield.dart';
import 'package:flutter/services.dart';

import 'package:flutter/cupertino.dart';
import 'package:project/Get_X/Model/listproducta.dart';
import 'package:project/Get_X/Model/order.dart';
import 'package:project/Get_X/Model/product.dart';
import 'package:project/Get_X/Model_Category/NameProductCategory.dart';
import 'package:project/utiliti/double_extenstions.dart';

import 'package:slide_countdown/slide_countdown.dart';

void main() {
  // راه‌اندازی کنترلر و اتصال آن به GetX

  runApp(MyAppRun());
}

class MyAppRun extends StatelessWidget {
  final PocketBase pb = PocketBase(
    const String.fromEnvironment('order',
        defaultValue: 'https://saater.liara.run'),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(pb),
      child: GetMaterialApp(
        initialRoute: Routes.splash,
        getPages: Routes.getPages,
        initialBinding: MyBinding(),
        title: 'کارشناسان خرید و فروش',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
          hintColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Colors.blue,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          ),
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blue, // رنگ دکمه‌ها
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
// primary: Colors.blue, // رنگ دکمه‌های برجسته
// onPrimary: Colors.white,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
// primary: Colors.blue, // رنگ دکمه‌های متنی
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
//   primary: Colors.blue, // رنگ دکمه‌های مرزی
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blue,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.blue,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: Colors.blueAccent,
              ),
            ),
          ),
          textTheme: TextTheme(
            headlineSmall: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            titleMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          cardTheme: CardTheme(
            color: Colors.white,
            shadowColor: Colors.blueAccent,
            margin: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        home: SplashPages(),
      ),
    );
  }
}

class SplashPages extends StatefulWidget {
  @override
  _SplashPagesState createState() => _SplashPagesState();
}

class _SplashPagesState extends State<SplashPages> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 800,
          width: 800,
          child: FlutterSplashScreen.scale(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.white],
            ),
            childWidget: Image.asset("assets/satter.png"),
            duration: Duration(milliseconds: 2000),
            animationDuration: Duration(milliseconds: 1000),
            onEnd: () async {
              await Future.delayed(Duration(seconds: 2));
              await authController.checkAndLogin();
            },
          ),
        ),
      ),
    );
  }
}

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage>
    with AutomaticKeepAliveClientMixin {
  final OrderControllerPage orderController = Get.find<OrderControllerPage>();
  final ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0.0; // ذخیره موقعیت اسکرول
  String selectedJalaliDate = '';
  String selectedGregorianDate = '';

  final TextEditingController titleController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController NiyazNumberController = TextEditingController();
  final TextEditingController phonenumberitController = TextEditingController();
  final TextEditingController callnumberController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Listener برای ذخیره موقعیت اسکرول
    _scrollController.addListener(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  bool _isSwitchOn = false;

  @override
  void dispose() {
    titleController.dispose();
    addressController.dispose();
    NiyazNumberController.dispose();
    phonenumberitController.dispose();
    callnumberController.dispose();
    _scrollController.dispose(); // آزادسازی کنترلر اسکرول
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true; // برای حفظ وضعیت صفحه

  late double _progressValue;

  @override
  Widget build(BuildContext context) {
    super.build(context); // برای حفظ وضعیت صفحه
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Center(
          child: _buildAppBar(orderController),
        ),
      ),
      body: GetBuilder<OrderControllerPage>(
        id: 'orderssupdate',
        builder: (controller) {
          if (orderController.orderstwo.isEmpty) {
            return Center(
              child: Text(
                'محتوایی برای نمایش وجود ندارد',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          if (orderController.isLoading.value) {
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.blue), // رنگ آبی
                ),
              ),
            );
          }
          return Directionality(
              textDirection: TextDirection.rtl,
              child: Stack(
                children: [
                  ListView.builder(
                    controller: _scrollController, // اضافه کردن کنترلر
                    itemCount: orderController.orderstwo.length,
                    itemBuilder: (context, index) {
                      final order = orderController.orderstwo[index];
                      _progressValue = double.parse(order.winner!);
                      DateTime endDate = DateTime.parse(order.dateAd!);
                      Duration timeRemaining =
                      endDate.difference(DateTime.now());
                      String gregorianDateString = order.created!;

                      // تبدیل رشته به DateTime
                      DateTime gregorianDate =
                      DateTime.parse(gregorianDateString);

                      // تبدیل تاریخ میلادی به تاریخ شمسی
                      Jalali jalaliDate = Jalali.fromDateTime(gregorianDate);

                      // نمایش تاریخ شمسی به صورت رشته
                      String persianDateString = jalaliDate.formatFullDate();
                      bool isExpired = timeRemaining.isNegative;

                      // نمایش اطلاعات در لیس
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _showEditOrderDialog(
                                          context, order, orderController);
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'شماره سفارش ${index + 1}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        _showEditConfigOrder(
                                            context, order, orderController);
                                      },
                                      icon: Icon(Icons.upload_file)),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: isExpired
                                        ? Text(
                                      'اعتبار سفارش به اتمام رسید',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red),
                                    )
                                        : SlideCountdownSeparated(
                                      duration: timeRemaining,
                                      slideDirection: SlideDirection.down,
                                      durationTitle:
                                      DurationTitle.arShort(),
                                      separator: "<>",
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text('نام ارگان : '),
                                      Text(
                                        order.title!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  // const SizedBox(height: 3),
                                  // Row(
                                  //   children: [
                                  //     Text('شماره نیاز : '),
                                  //     Row(
                                  //       children: [
                                  //         Text(
                                  //           widget.order.niyaz,
                                  //           style: const TextStyle(
                                  //             fontSize: 18,
                                  //             fontWeight: FontWeight.bold,
                                  //           ),
                                  //         ),
                                  //         IconButton(
                                  //           icon: const Icon(Icons.copy),
                                  //           onPressed: () {
                                  //             Clipboard.setData(
                                  //                 ClipboardData(text: widget.order.niyaz));
                                  //             ScaffoldMessenger.of(context).showSnackBar(
                                  //               const SnackBar(
                                  //                   content: Text('شماره نیاز شما ' + 'کپی شد ')),
                                  //             );
                                  //           },
                                  //         ),
                                  //       ],
                                  //     )
                                  //   ],
                                  // ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Text('شماره تماس ثابت  : '),
                                      Text(
                                        order.callNumber!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Text('شماره تماس همراه IT  : '),
                                      Text(
                                        order.phoneNumberIT!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Text('آدرس  : '),
                                      Text(
                                        order.address!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Text(' نوع سفارش : '),
                                      Text(
                                        order.buy!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Text(' تاریخ ثبت سفارش : '),
                                      Text(
                                        persianDateString,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Text(' تاریخ اعتبار سفارش : '),
                                      Text(
                                        order.dateNow!,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const SizedBox(height: 3),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          buildStepIndicator(
                                              0.25,
                                              'استعلام اول',
                                              order.winner!,
                                              order.id!),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          buildStepIndicator(
                                              0.50,
                                              'ارسال پیش فاکتور',
                                              order.winner!,
                                              order.id!),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          buildStepIndicator(0.75, 'برنده شد',
                                              order.winner!, order.id!),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          buildStepIndicator(1.0, 'استعلام دوم',
                                              order.winner!, order.id!),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      LinearProgressIndicator(
                                        value: _progressValue,
                                        minHeight: 20,
                                        backgroundColor: Colors.grey[300],
                                        valueColor:
                                        AlwaysStoppedAnimation<Color>(
                                            Colors.blue),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          buildStepLabel(0.25, 'استعلام اول'),
                                          buildStepLabel(
                                              0.50, 'ارسال پیش فاکتور'),
                                          buildStepLabel(0.75, 'برنده شد'),
                                          buildStepLabel(1.0, 'استعلام دوم'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                              Row(
                                children: [
                                  Card(
                                      child: Column(children: [
                                        Text('   افزودن محصول رزرو  '),
                                        IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () {
                                            _showAddProductDialogA(context,
                                                orderController, order, 'استعلام');

                                            // Get.defaultDialog(
                                            //     content: Column(
                                            //   children: [
                                            //
                                            //     GetBuilder<OrderController>(
                                            // id:'product',
                                            //       builder: (controller) {
                                            //         return Text(orderController.selectedProductItems
                                            //             .toString());
                                            //       },
                                            //     ),
                                            //   ],
                                            // ));
                                          },
                                        ),
                                      ])),
                                  Spacer(),
                                  Card(
                                      child: Column(children: [
                                        Text('   پرینت فاکتور و درصد  '),
                                        IconButton(
                                          icon: const Icon(Icons.print),
                                          onPressed: () {
                                            if (order.listProductA!.isEmpty) {
                                              Get.snackbar('ناموفق',
                                                  'برای صدور فاکتور باید به سفارش محصول بی افزاید',
                                                  backgroundColor: Colors.orange);
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyStatefulPage(
                                                        listProductA:
                                                        order.listProductA!,
                                                        order: order,
                                                      ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ])),
                                ],
                              ),
                              ExpansionTileItem(
                                textColor: Colors.black,
                                border: Border.all(
                                  color: determineCollapsedBorderColor(
                                      order.listProductA!),
                                  // رنگ بوردر بر اساس محاسبات شما
                                  width: 4, // ضخامت بوردر
                                ),
                                title: Column(
                                  children: [
                                    Text('محصولات'),
                                  ],
                                ),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: ExpansionTileItem(
                                        title: Column(
                                          children: [
                                            ...order.listProductA!
                                                .map(
                                                    (product) =>
                                                    ExpansionTileItem(
                                                      textColor:
                                                      Colors.black,
                                                      collapsedBackgroundColor:
                                                      product.unavailable!
                                                          ? Colors.green[
                                                      200]
                                                          : Colors.orange[
                                                      200],
                                                      backgroundColor: product
                                                          .unavailable!
                                                          ? Colors
                                                          .green[200]
                                                          : Colors
                                                          .orange[200],
                                                      title: Card(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                                  children: [
                                                                    Card(
                                                                      child:
                                                                      Column(children: [
                                                                        IconButton(
                                                                          icon: const Icon(Icons.edit),
                                                                          onPressed: () async {
                                                                            //   print(productA.garranty);
                                                                            //      List<String> listGproduct = await pocketBaseProvider.getProductWarranty(product.id);
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (context) => ProductDetailsDialogA(
                                                                                productType: 'ویرایش محصول',
                                                                                productTitle: product.title!,
                                                                                productId: product.id!,
                                                                                productPrice: product.salePrice!,
                                                                                orderController: orderController,
                                                                                listG: product.garranty!,
                                                                                number: product.number!,
                                                                                buyproduct: product.sellBuyProduct?.title?.isNotEmpty == true ? product.sellBuyProduct!.title! : '+',
                                                                              ),
                                                                            );
                                                                            //   ProductDetailsDialogA(productId:  productA.id, productType: 'ویرایش محصول', productTitle: productA.title, productPrice: productA.saleprice, number: productA.number, listG: productA.garranty,    provider: widget.provider,);
                                                                          },
                                                                        ),
                                                                        IconButton(
                                                                          icon: const Icon(Icons.add),
                                                                          onPressed: () {
                                                                            showGeneralCategoryDialog(context, order, product.id!);

// print(.toString());
// print('mnammnam');

                                                                            // orderController.fetchAllSuppliers();
                                                                            bool rezerv = false;
                                                                          },
                                                                        ),
                                                                      ]),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(product
                                                                    .title!),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                    ' گارانتی :  '),
                                                                MultiSelectContainer(
                                                                  prefix:
                                                                  MultiSelectPrefix(
                                                                    selectedPrefix:
                                                                    const Padding(
                                                                      padding:
                                                                      EdgeInsets.only(right: 5),
                                                                      child:
                                                                      Icon(
                                                                        Icons.check,
                                                                        color:
                                                                        Colors.blue,
                                                                        size:
                                                                        14,
                                                                      ),
                                                                    ),
                                                                    disabledPrefix:
                                                                    const Padding(
                                                                      padding:
                                                                      EdgeInsets.only(right: 5),
                                                                      child:
                                                                      Icon(
                                                                        Icons.do_disturb_alt_sharp,
                                                                        size:
                                                                        14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  items: product
                                                                      .garranty!
                                                                      .map(
                                                                          (item) {
                                                                        return MultiSelectCard(
                                                                          value:
                                                                          item,
                                                                          label:
                                                                          item,
                                                                        );
                                                                      }).toList(),
                                                                  onChange:
                                                                      (allSelectedItems,
                                                                      selectedItem) {
// handleSelectionChange(allSelectedItems, selectedItem);
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                const Text(
                                                                    'تعداد: '),
                                                                Text(product
                                                                    .number!),
                                                                Spacer(),
                                                                Text(
                                                                    'عدم موجودی'),
                                                                Switch(
                                                                  value: product
                                                                      .unavailable!,
                                                                  onChanged:
                                                                      (bool
                                                                  value) {
                                                                    if (value ==
                                                                        true) {
                                                                      bool
                                                                      un =
                                                                          value;
                                                                      orderController.updateProductADiscription(
                                                                          product.id!,
                                                                          product.description!,
                                                                          un);
                                                                    } else {
                                                                      showDialog(
                                                                        context:
                                                                        context,
                                                                        builder:
                                                                            (BuildContext context) {
                                                                          bool un = value;
                                                                          TextEditingController noteController = TextEditingController(text: product.description);
                                                                          return AlertDialog(
                                                                            title: const Text('توضیح محصول'),
                                                                            content: TextField(
                                                                              controller: noteController,
                                                                              maxLines: 5,
                                                                              decoration: const InputDecoration(
                                                                                border: OutlineInputBorder(),
                                                                                labelText: 'توضیحات',
                                                                              ),
                                                                            ),
                                                                            actions: [
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: const Text('کنسل'),
                                                                              ),
                                                                              TextButton(
                                                                                onPressed: () {
                                                                                  orderController.updateProductADiscription(product.id!, noteController.text, un);
                                                                                  //       Navigator.of(context).pop();
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                                child: const Text('تایید'),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        },
                                                                      );
                                                                    }
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                            Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                  TextField(
                                                                    controller:
                                                                    TextEditingController(text: product.purchasePrice!.convertToPrice()),
                                                                    decoration:
                                                                    const InputDecoration(labelText: 'قیمت خرید'),
                                                                    keyboardType:
                                                                    TextInputType.number,
                                                                    inputFormatters: [
                                                                      FilteringTextInputFormatter.allow(
                                                                          RegExp(r'[0-9۰-۹]')),
                                                                      TextInputFormatter
                                                                          .withFunction(
                                                                            (oldValue,
                                                                            newValue) {
                                                                          String newText = convertToEnglishNumbers(newValue.text);
                                                                          return TextEditingValue(
                                                                            text: newText,
                                                                            selection: TextSelection.collapsed(offset: newText.length),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                    onTap:
                                                                        () {
                                                                      showDialog(
                                                                        context:
                                                                        context,
                                                                        builder:
                                                                            (BuildContext context) {
                                                                          return Directionality(
                                                                              textDirection: TextDirection.rtl,
                                                                              child: AlertDialog(
                                                                                title: const Text('قیمت محصول استعلام'),
                                                                                content: Container(
                                                                                    child: TextField(
                                                                                      controller: TextEditingController(text: product.purchasePrice!.convertToPrice()),
                                                                                      decoration: const InputDecoration(labelText: 'قیمت خرید'),
                                                                                      keyboardType: TextInputType.number,
                                                                                      inputFormatters: [
                                                                                        FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]')),
                                                                                        TextInputFormatter.withFunction(
                                                                                              (oldValue, newValue) {
                                                                                            String newText = convertToEnglishNumbers(newValue.text.convertToPrice());
                                                                                            return TextEditingValue(
                                                                                              text: newText,
                                                                                              selection: TextSelection.collapsed(offset: newText.length),
                                                                                            );
                                                                                          },
                                                                                        ),
                                                                                      ],
                                                                                      onChanged: (value) {
                                                                                        orderController.updateProductBPricepurch(product.id!, value);
                                                                                      },
                                                                                    ),
                                                                                    width: 200),
                                                                              ));
                                                                        },
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                    20),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text('قیمت به حروف : ' +
                                                                '${product.purchasePrice!.toWord()} ' +
                                                                ' ریال'),
                                                            const SizedBox(
                                                                height: 10),
                                                            Text('توضیحات محصول: ' +
                                                                '${product.description}'),
                                                          ],
                                                        ),
                                                      ),
                                                      children: [
                                                        if (product
                                                            .sellBuyProduct !=
                                                            null)
                                                          ExpansionTile(
                                                            title: Card(
                                                                elevation:
                                                                4,
                                                                margin: EdgeInsets
                                                                    .all(
                                                                    16),
                                                                shape:
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      15),
                                                                ),
                                                                child:
                                                                Center(
                                                                  child:
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                    children: [
                                                                      IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          // نمایش دیالوگ تاییدیه قبل از حذف
                                                                          showDialog(
                                                                            context: context,
                                                                            builder: (context) {
                                                                              return AlertDialog(
                                                                                title: Text('حذف محصول'),
                                                                                content: Text('آیا از حذف این محصول مطمئن هستید؟'),
                                                                                actions: [
                                                                                  TextButton(
                                                                                    onPressed: () {
                                                                                      Navigator.of(context).pop();
                                                                                    },
                                                                                    child: Text('خیر'),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                          );
                                                                        },
                                                                        icon:
                                                                        Icon(Icons.delete),
                                                                      ),
                                                                      Text(
                                                                        product.sellBuyProduct?.title ??
                                                                            "عنوان محصول",
                                                                        style:
                                                                        TextStyle(
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.bold,
                                                                          color: Colors.blueAccent,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                          height: 10),
                                                                      SizedBox(
                                                                          height: 8),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            child: Text('تعداد موجود انبار: ${product.sellBuyProduct?.numberNow ?? "ندارد"}'),
                                                                          ),
                                                                          Expanded(
                                                                            child: Text('تعداد کسر از انبار: ${product.sellBuyProduct?.inventory ?? "ندارد"}'),
                                                                          ),
                                                                          Expanded(
                                                                            child: Text('تعداد سفارش: ${product.sellBuyProduct?.numberOfInventory ?? "ندارد"}'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            child: Text('وضعیت دریافت جنس جمع کن: ${product.sellBuyProduct?.receive == true ? "دریافت شده" : "دریافت نشده"}'),
                                                                          ),
                                                                          Expanded(
                                                                            child: Text('وضعیت دریافت انبار: ${product.sellBuyProduct?.receive == true ? "دریافت شده" : "دریافت نشده"}'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            child: Text('تاریخ ایجاد: ${product.sellBuyProduct?.dateCreated ?? "ندارد"}'),
                                                                          ),
                                                                          Expanded(
                                                                            child: Text('روزها: ${product.sellBuyProduct?.days ?? "ندارد"}'),
                                                                          ),
                                                                          Expanded(
                                                                            child: Text('تاریخ تسویه: ${product.sellBuyProduct?.dateClearing ?? "ندارد"}'),
                                                                          ),
                                                                          Expanded(
                                                                            child: Text('نوع سفارش: ${product.sellBuyProduct?.typeOrder ?? "ندارد"}'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            child: Text('نام: ${product.sellBuyProduct?.name ?? "ندارد"}'),
                                                                          ),
                                                                          Expanded(
                                                                            child: Text('خانواده: ${product.sellBuyProduct?.family ?? "ندارد"}'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            child: Text('قیمت خرید: ${product.sellBuyProduct?.purchasePrice ?? "ندارد"}'),
                                                                          ),
                                                                          Expanded(
                                                                            child: Text('قیمت فروش: ${product.sellBuyProduct?.salePrice ?? "ندارد"}'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                          height: 10),
                                                                      Divider(),
                                                                      SizedBox(
                                                                          height: 10),
                                                                      Text(
                                                                          'تنظیمات:',
                                                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                                                      SwitchListTile(
                                                                        title:
                                                                        Text('وضعیت فوری'),
                                                                        value:
                                                                        product.sellBuyProduct?.hurry ?? false,
                                                                        onChanged:
                                                                            (bool value) {
                                                                          // Handle the switch change
                                                                        },
                                                                      ),
                                                                      SwitchListTile(
                                                                        title:
                                                                        Text('وضعیت رسمی'),
                                                                        value:
                                                                        product.sellBuyProduct?.official ?? false,
                                                                        onChanged:
                                                                            (bool value) {
                                                                          // Handle the switch change
                                                                        },
                                                                      ),
                                                                      SwitchListTile(
                                                                        title:
                                                                        Text('انتظار'),
                                                                        value:
                                                                        product.sellBuyProduct?.expectation ?? false,
                                                                        onChanged:
                                                                            (bool value) {
                                                                          // Handle the switch change
                                                                        },
                                                                      ),
                                                                      SwitchListTile(
                                                                        title:
                                                                        Text('گارانتی: ${product.sellBuyProduct?.garranty != null ? product.sellBuyProduct!.garranty!.join(", ") : "ندارد"}'),
                                                                        value:
                                                                        product.sellBuyProduct?.garranty != null,
                                                                        onChanged:
                                                                            (bool value) {
                                                                          // Handle the switch change
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  ...product
                                                                      .sellBuyProduct!
                                                                      .snBuyProductLogin!
                                                                      .map(
                                                                        (snProduct) =>
                                                                        Card(
                                                                          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                                                                          child: Container(
                                                                            decoration: BoxDecoration(
// color: product.sellBuyProduct.okbuy
// ? Colors.green[100]
//     : Colors.yellow[200],
// تغییر رنگ پس‌زمینه بر اساس productB.okbuy
                                                                              border: Border.all(
// color: product.sellBuyProduct.hurry
// ? Colors.blue
//     : Colors.grey,
// تغییر رنگ بوردر بر اساس productB.hurry
                                                                                width: 4, // ضخامت بوردر
                                                                              ),
                                                                              borderRadius: BorderRadius.circular(8.0), // شکل گرد بوردر
                                                                            ),
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.all(8.0),
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                children: [
                                                                                  Row(
                                                                                    children: [
                                                                                      Card(
                                                                                        child: Column(children: [
                                                                                          IconButton(
                                                                                            icon: const Icon(Icons.mode_edit),
                                                                                            onPressed: () async {
// نمایش پروگرس بار به مدت 1 ثانیه

                                                                                              showDialog(
                                                                                                context: context,
                                                                                                barrierDismissible: false,
                                                                                                builder: (context) {
                                                                                                  return Center(
                                                                                                    child: CircularProgressIndicator(),
                                                                                                  );
                                                                                                },
                                                                                              );
                                                                                            },
                                                                                          ),
                                                                                        ]),
                                                                                      ),
                                                                                      Text('${product.sellBuyProduct!.title!} '),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                  )
                                                                      .toList(),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                      ],
                                                    ))
                                                .toList(),
                                          ],
                                        ),
                                        children: [],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  if (orderController.isLoading.value)
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue), // رنگ آبی
                        ),
                      ),
                    ),
                ],
              ));
        },
      ),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            context: context,
            builder: (conte) {
              return StatefulBuilder(
                builder: (conte, StateSetter setState) {
                  return _buildOrderCreationSheet(
                      conte, setState, orderController);
                },
              );
            },
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  String? _selectedValue;

  //سامانه, همکار, اسنپ, دی جی کالا, تپ سی, سایت
  Widget _buildOrderCreationSheet(BuildContext context,
      StateSetter setModalState, OrderControllerPage controler) {
    final List<String> _options = [
      'سامانه',
      'همکار',
      'اسنپ',
      'دیجی‌کالا',
      'تپ‌سی',
      'سایت',
      'موضوع آزاد',
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // متن توضیحات
                Text(
                  _selectedValue == null
                      ? 'لطفاً نوع سفارش خود را انتخاب کنید'
                      : 'سفارش از نوع $_selectedValue ثبت شد',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                SizedBox(width: 20), // فاصله بین متن و دکمه
                // DropdownButton
                DropdownButton<String>(
                  hint: Text('انتخاب کنید'),
                  value: _selectedValue,
                  onChanged: (String? newValue) {
                    setModalState(() {
                      _selectedValue = newValue;
                    });
                  },
                  items: _options.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            const Text(
              'ثبت سفارش',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'نام ارگان یا مشتری',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: NiyazNumberController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                focusColor: Colors.blue,
                isDense: true,
                labelText: 'شماره نیاز',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]')),
                TextInputFormatter.withFunction(
                      (oldValue, newValue) {
                    String newText = convertToEnglishNumbers(newValue.text);
                    return TextEditingValue(
                      text: newText,
                      selection:
                      TextSelection.collapsed(offset: newText.length),
                    );
                  },
                ),
              ],
              onChanged: (value) {
                NiyazNumberController.value = TextEditingValue(
                  text: convertToEnglishNumbers(value),
                  selection: NiyazNumberController.selection,
                );
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: phonenumberitController,
              decoration: const InputDecoration(
                labelText: 'شماره تماس IT',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]')),
                TextInputFormatter.withFunction(
                      (oldValue, newValue) {
                    String newText = convertToEnglishNumbers(newValue.text);
                    return TextEditingValue(
                      text: newText,
                      selection:
                      TextSelection.collapsed(offset: newText.length),
                    );
                  },
                ),
              ],
              onChanged: (value) {
                phonenumberitController.value = TextEditingValue(
                  text: convertToEnglishNumbers(value),
                  selection: phonenumberitController.selection,
                );
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: callnumberController,
              decoration: const InputDecoration(
                labelText: 'شماره تماس ثابت',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]')),
                TextInputFormatter.withFunction(
                      (oldValue, newValue) {
                    String newText = convertToEnglishNumbers(newValue.text);
                    return TextEditingValue(
                      text: newText,
                      selection:
                      TextSelection.collapsed(offset: newText.length),
                    );
                  },
                ),
              ],
              onChanged: (value) {
                callnumberController.value = TextEditingValue(
                  text: convertToEnglishNumbers(value),
                  selection: callnumberController.selection,
                );
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: addressController,
              decoration: const InputDecoration(
                labelText: 'آدرس',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Switch(
                  activeColor: Colors.blue,
                  value: _isSwitchOn,
                  onChanged: (value) {
                    setModalState(() => _isSwitchOn = value);
                  },
                ),
                const Spacer(),
                Text(
                  _isSwitchOn ? 'فروش و اسمبل' : 'فروش',
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                SizedBox(
                  height: 50,
                ),
                IconButton(
                  onPressed: () async {
                    Jalali? picked = await showPersianDatePicker(
                      context: context,
                      initialDate: Jalali.now(),
                      firstDate: Jalali(1403, 1),
                      lastDate: Jalali(1407, 12),
                      initialEntryMode: PDatePickerEntryMode.calendarOnly,
                      initialDatePickerMode: PDatePickerMode.year,
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Colors.blue,
                              onPrimary: Colors.black,
                              surface: Colors.lightBlueAccent,
                              onSurface: Colors.black,
                            ),
                            dialogTheme: const DialogTheme(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (picked != null) {
                      // انتخاب ساعت
                      TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              timePickerTheme: TimePickerThemeData(
                                dayPeriodBorderSide:
                                BorderSide(color: Colors.white),
                                // Border color for AM/PM
                                dialHandColor: Colors.white,
                                // Color of the hour hand
                                dialTextColor: Colors.black,
                                // Text color on the clock dial
                                dialBackgroundColor: Colors.blue,
                                dayPeriodColor: Colors.blue,
                                hourMinuteColor: Colors.blue,
                                //    entryModeIconColor: blueStanOut,
                                helpTextStyle: const TextStyle(
                                  //     color: blueStanOut, // Set the text color for "Enter time"
                                ),
                                cancelButtonStyle: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white)),
                                confirmButtonStyle: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white)),
                                hourMinuteTextStyle: TextStyle(
                                    fontSize:
                                    30), // Text style for hours and minutes
                              ),
                              textTheme: const TextTheme(
                                bodySmall: TextStyle(color: Colors.blue),
                              ),
                              colorScheme: ColorScheme(
                                primary: Colors.white70,
                                secondary: Colors.brown.shade300,
                                background: Colors.amberAccent,
                                surface: Colors.lightBlueAccent,
                                onBackground: Colors.white,
                                onSurface: Colors.white,
                                onError: Colors.white,
                                onPrimary: Colors.white,
                                onSecondary: Colors.black,
                                brightness: Brightness.dark,
                                error: Colors.red,
                              ),
                              textSelectionTheme: TextSelectionThemeData(
                                //     cursorColor: lighterLimeGreen,
                                //     selectionColor: lighterLimeGreen,
                                //    selectionHandleColor: lighterLimeGreen,
                              ),
                              cupertinoOverrideTheme: CupertinoThemeData(
                                primaryColor: Colors.orange,
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (time != null) {
                        // تاریخ شمسی انتخاب شده
                        String jalaliDate = picked.formatFullDate();

                        // تبدیل تاریخ شمسی به تاریخ میلادی
                        DateTime gregorianDate = picked.toDateTime();

                        // ترکیب تاریخ میلادی و زمان انتخاب شده
                        gregorianDate = DateTime(
                          gregorianDate.year,
                          gregorianDate.month,
                          gregorianDate.day,
                          time.hour,
                          time.minute,
                        );

                        // تاریخ میلادی به صورت رشته
                        String gregorianDateString =
                        gregorianDate.toIso8601String();

                        // به روز رسانی متغیرهای مورد نظر
                        setModalState(() {
                          selectedJalaliDate = jalaliDate;
                          selectedGregorianDate = gregorianDateString;
                        });

                        print("Selected Jalali Date: $selectedJalaliDate");
                        print("Selected Gregorian Date: $gregorianDateString");
                      }
                    }
                  },
                  icon: Icon(
                    Icons.date_range,
                    color: Colors.blue,
                  ),
                ),
                Text('تاریخ تسویه : '),
                Text(
                  selectedJalaliDate,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    if (titleController.text.isNotEmpty &&
                        NiyazNumberController.text.isNotEmpty &&
                        selectedJalaliDate.isNotEmpty &&
                        _selectedValue != null) {
                      // ارسال اطلاعات به متد ثبت سفارش
                      OrderTwo s = OrderTwo(
                        id: '',
                        title: titleController.text,
                        callNumber: callnumberController.text,
                        dateNow: selectedJalaliDate,
                        dateAd: selectedGregorianDate,
                        address: addressController.text,
                        niyaz: NiyazNumberController.text,
                        phoneNumberIT: phonenumberitController.text,
                        buy: _isSwitchOn.toString(),
                        winner: '0.25',
                        created: 'created',
                      );
                      String or =
                      await controler.createorders(s, _selectedValue);
                      print(or);
                      String description = 'نتیجه';
                      String statusText;
                      Color statusColor;

                      if (or == 'موفق') {
                        statusText = 'محصول با موفقیت ثبت شد';
                        statusColor = Colors.green[300]!;
                        titleController.clear();
                        addressController.clear();
                        NiyazNumberController.clear();
                        phonenumberitController.clear();
                        callnumberController.clear();
                        setModalState(() {
                          selectedJalaliDate = '';
                          selectedGregorianDate = '';
                          _isSwitchOn = false;
                        });
                        orderController.fetchAndUpdate();
                        Navigator.of(context).pop();
                      } else if (or == 'این شماره نیاز تکراری است') {
                        statusText = 'این شماره نیاز تکراری است';
                        statusColor = Colors.red[300]!;
                      } else {
                        statusText = 'خطا در ایجاد رکورد: $or';
                        statusColor = Colors.red[300]!;
                      }

                      Get.snackbar(
                        description,
                        statusText,
                        backgroundColor: statusColor,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('لطفا تمام فیلد ها رو پر کنید'),
                      ));
                    }
                  },
                  child: const Text('ثبت سفارش'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Color determineCollapsedBorderColor(List<ProductAtwo> listProductA) {
    // بررسی خالی بودن لیست
    if (listProductA.isEmpty) {
      return Colors.grey;
    }

    // بررسی محصولات برای داشتن قیمت خرید معتبر
    for (var productA in listProductA) {
      if (productA.purchasePrice == null ||
          productA.purchasePrice!.isEmpty ||
          productA.purchasePrice == '0' ||
          productA.purchasePrice == ' ' ||
          productA.purchasePrice == 'N/A') {
        return Colors.orange;
      }
    }

    // اگر همه محصولات قیمت خرید معتبر داشتند، رنگ سبز برگردان
    return Colors.green;
  }

  Widget _buildAppBar(OrderControllerPage controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Text(
        //   'کارشناسان خرید و فروش',
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontSize: 18,
        //   ),
        // ),
        Builder(
          builder: (context) {
            return Center(
              child: GestureDetector(
                onTap: () {
                  // باز کردن دراور به صورت دستی
                  Scaffold.of(context).openDrawer();
                },
                child: ClipRRect(
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcATop,
                    ),
                    child: SizedBox(
                      width: 80,
                      height: 45,
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 0.10, vertical: 1),
                        child: Image.network(
                          'https://saater.liara.run/api/files/_pb_users_auth_/m3l4fw1tv15rq9w/satereha_b064xBcpJa.png?token=',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextFormField(
              onChanged: (value) {
                orderController.fetchAllOrdersSearch(value);
              },
              keyboardType: TextInputType.text,
              inputFormatters: [
                //       FilteringTextInputFormatter.allow(RegExp(r'-?[0-9۰-۹.]*')),
                TextInputFormatter.withFunction((oldValue, newValue) {
                  String newText = convertToEnglishNumbers(newValue.text);
                  return TextEditingValue(
                    text: newText,
                    selection: TextSelection.collapsed(offset: newText.length),
                  );
                }),
              ],
              decoration: InputDecoration(
                hintText: 'جستجو...',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 16,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.teal.shade100, width: 1.0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Obx(
              () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 1, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    controller.isSearchByTitle.value ? 'نام' : 'نیاز',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    child: Switch(
                      value: controller.isSearchByTitle.value,
                      onChanged: (value) {
                        controller.isSearchByTitle.value = value!;
                      },
                      activeColor: Colors.white70,
                      // رنگ سوئیچ در حالت فعال
                      inactiveThumbColor: Colors.blue,
                      // رنگ سوئیچ در حالت غیرفعال
                      inactiveTrackColor:
                      Colors.blue, // رنگ پس‌زمینه سوئیچ در حالت غیرفعال
                    ),
                  ),
                ],
              )),
        ),
        Row(
          children: [
            // IconButton(
            //   tooltip: 'تامین کننده',
            //   onPressed: () {
            //     Get.to(SupplierListScreens());
            //   },
            //   icon: Icon(Icons.supervisor_account, color: Colors.white),
            // ),

            PopupMenuButton<String>(
              tooltip: 'مرتب سازی بر اثاث نوع سفارش',
              onSelected: (private) {
                orderController.fetchAllOrdersPrivate(private);
              },
              itemBuilder: (context) => [
                // 'سامانه',
                // 'همکار',
                // 'اسنپ',
                // 'دیجی‌کالا',
                // 'تپ‌سی',
                // 'سایت',

                PopupMenuItem(
                  value: 'سامانه',
                  child: Text('سفارشات سامانه'),
                ),
                PopupMenuItem(
                  value: 'همکار',
                  child: Text('سفارشات همکار'),
                ),
                PopupMenuItem(
                  value: 'اسنپ',
                  child: Text('سفارشات اسنپ'),
                ),
                PopupMenuItem(
                  value: 'دیجی‌کالا',
                  child: Text('سفارشات دیجی‌کالا'),
                ),
                PopupMenuItem(
                  value: 'تپ‌سی',
                  child: Text('سفارشات تپ‌سی'),
                ),
                PopupMenuItem(
                  value: 'سایت',
                  child: Text('سفارشات سایت'),
                ),
                PopupMenuItem(
                  value: 'موضوع آزاد',
                  child: Text('سفارشات موضوع آزاد'),
                ),
                // PopupMenuItem(
                //   value: 'srpipkxuv7v1qrw',
                //   child: Text('سفارشات همکار'),
                // ),
                // PopupMenuItem(
                //   value: 'kpdz5k8fkpp0c2q',
                //   child: Text('سفارشات سایت'),
                // ),
              ],
              icon: Icon(Icons.account_tree_outlined, color: Colors.white),
            ),
            PopupMenuButton<String>(
              tooltip: 'مرتب سازی بر اثاث روند سفارش',
              onSelected: (filter) {
                orderController.fetchAllOrdersFilter(filter);
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'winner="0.25"',
                  child: Text('استعلام اول'),
                ),
                PopupMenuItem(
                  value: 'winner="0.5"',
                  child: Text('ارسال پیش فاکتور'),
                ),
                PopupMenuItem(
                  value: 'winner="0.75"',
                  child: Text('سفارشات برنده'),
                ),
                PopupMenuItem(
                  value: 'winner="1.2"',
                  child: Text('استعلام دوم'),
                ),
                PopupMenuItem(
                  value: '',
                  child: Text('تمام سفارشات'),
                ),
              ],
              icon: Icon(Icons.alt_route_sharp, color: Colors.white),
            ),
            PopupMenuButton<String>(
              tooltip: 'مرتب سازی بر اثاث تاریخ اعتبار',
              onSelected: (sort) {
                orderController.fetchAllOrdersSort(sort);
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: '-datead',
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('صعودی به نزولی'),
                  ),
                ),
                PopupMenuItem(
                  value: '+datead',
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('نزولی به صعودی'),
                  ),
                ),
                PopupMenuItem(
                  value: '',
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('حذف مرتب سازی'),
                  ),
                ),
              ],
              icon: Icon(Icons.sort, color: Colors.white),
            ),
            IconButton(
              tooltip: 'به روز رسانی',
              onPressed: () {
                orderController.fetchAllOrdersRefresh();
                //  showGeneralCategoryDialog(context);
              },
              icon: Icon(Icons.refresh, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStepIndicator(
      double value, String text, String winner, String id) {
    return Column(
      children: [],
    );
  }

  Widget buildStepLabel(double value, String text) {
    return Column(
      children: [
        Icon(
          Icons.circle_notifications,
          color: _progressValue >= value ? Colors.green : Colors.grey,
          size: 20,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  void _showEditOrderDialog(BuildContext context, OrderTwo order,
      OrderControllerPage orderController) {
    final TextEditingController titleController =
    TextEditingController(text: order.title);
    final TextEditingController callnumberController =
    TextEditingController(text: order.callNumber);
    final TextEditingController NiyazNumberController =
    TextEditingController(text: order.niyaz);
    final TextEditingController phonenumberitController =
    TextEditingController(text: order.phoneNumberIT);
    final TextEditingController addressController =
    TextEditingController(text: order.address);
    String selectedJalaliDate = order.dateNow!;
    String selectedGregorianDate = order.dateAd!;
    String orderType = order.buy!; // یا 'فروش و اسمبل'
    bool _isSwitchOn = orderType != 'فروش';

    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Text('ویرایش سفارش'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'نام ارگان'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: callnumberController,
                      decoration:
                      const InputDecoration(labelText: 'شماره تماس ثابت'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]')),
                        TextInputFormatter.withFunction(
                              (oldValue, newValue) {
                            String newText =
                            convertToEnglishNumbers(newValue.text);
                            return TextEditingValue(
                              text: newText,
                              selection: TextSelection.collapsed(
                                  offset: newText.length),
                            );
                          },
                        ),
                      ],
                      onChanged: (value) {
                        callnumberController.value = TextEditingValue(
                          text: convertToEnglishNumbers(value),
                          selection: callnumberController.selection,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: NiyazNumberController,
                      decoration:
                      const InputDecoration(labelText: 'شماره نیاز'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]')),
                        TextInputFormatter.withFunction(
                              (oldValue, newValue) {
                            String newText =
                            convertToEnglishNumbers(newValue.text);
                            return TextEditingValue(
                              text: newText,
                              selection: TextSelection.collapsed(
                                  offset: newText.length),
                            );
                          },
                        ),
                      ],
                      onChanged: (value) {
                        NiyazNumberController.value = TextEditingValue(
                          text: convertToEnglishNumbers(value),
                          selection: NiyazNumberController.selection,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: phonenumberitController,
                      decoration:
                      const InputDecoration(labelText: 'شماره تماس IT'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]')),
                        TextInputFormatter.withFunction(
                              (oldValue, newValue) {
                            String newText =
                            convertToEnglishNumbers(newValue.text);
                            return TextEditingValue(
                              text: newText,
                              selection: TextSelection.collapsed(
                                  offset: newText.length),
                            );
                          },
                        ),
                      ],
                      onChanged: (value) {
                        phonenumberitController.value = TextEditingValue(
                          text: convertToEnglishNumbers(value),
                          selection: phonenumberitController.selection,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: addressController,
                      decoration: const InputDecoration(labelText: 'آدرس'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Switch(
                          activeColor: Colors.blue,
                          value: _isSwitchOn,
                          onChanged: (value) {
                            setModalState(() => _isSwitchOn = value);
                          },
                        ),
                        const Spacer(),
                        Text(
                          _isSwitchOn ? 'فروش و اسمبل' : 'فروش',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          child: IconButton(
                            onPressed: () async {
                              Jalali? picked = await showPersianDatePicker(
                                context: context,
                                initialDate: Jalali.now(),
                                firstDate: Jalali(1403, 1),
                                lastDate: Jalali(1407, 12),
                                initialEntryMode:
                                PDatePickerEntryMode.calendarOnly,
                                initialDatePickerMode: PDatePickerMode.year,
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Colors.blue,
                                        onPrimary: Colors.black,
                                        surface: Colors.lightBlueAccent,
                                        onSurface: Colors.black,
                                      ),
                                      dialogTheme: const DialogTheme(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (picked != null) {
                                // انتخاب ساعت
                                TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        timePickerTheme: TimePickerThemeData(
                                          dayPeriodBorderSide:
                                          BorderSide(color: Colors.white),
                                          // Border color for AM/PM
                                          dialHandColor: Colors.white,
                                          // Color of the hour hand
                                          dialTextColor: Colors.black,
                                          // Text color on the clock dial
                                          dialBackgroundColor: Colors.blue,
                                          dayPeriodColor: Colors.blue,
                                          hourMinuteColor: Colors.blue,
                                          //    entryModeIconColor: blueStanOut,
                                          helpTextStyle: const TextStyle(
                                            //     color: blueStanOut, // Set the text color for "Enter time"
                                          ),
                                          cancelButtonStyle: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(Colors.blue),
                                              foregroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(Colors.white)),
                                          confirmButtonStyle: ButtonStyle(
                                              backgroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(Colors.blue),
                                              foregroundColor:
                                              MaterialStateProperty.all<
                                                  Color>(Colors.white)),
                                          hourMinuteTextStyle: TextStyle(
                                              fontSize:
                                              30), // Text style for hours and minutes
                                        ),
                                        textTheme: const TextTheme(
                                          bodySmall:
                                          TextStyle(color: Colors.blue),
                                        ),
                                        colorScheme: ColorScheme(
                                          primary: Colors.white70,
                                          secondary: Colors.brown.shade300,
                                          background: Colors.amberAccent,
                                          surface: Colors.lightBlueAccent,
                                          onBackground: Colors.white,
                                          onSurface: Colors.white,
                                          onError: Colors.white,
                                          onPrimary: Colors.white,
                                          onSecondary: Colors.black,
                                          brightness: Brightness.dark,
                                          error: Colors.red,
                                        ),
                                        textSelectionTheme: TextSelectionThemeData(
                                          //     cursorColor: lighterLimeGreen,
                                          //     selectionColor: lighterLimeGreen,
                                          //    selectionHandleColor: lighterLimeGreen,
                                        ),
                                        cupertinoOverrideTheme:
                                        CupertinoThemeData(
                                          primaryColor: Colors.orange,
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (time != null) {
                                  // تاریخ شمسی انتخاب شده
                                  String jalaliDate = picked.formatFullDate();

                                  // تبدیل تاریخ شمسی به تاریخ میلادی
                                  DateTime gregorianDate = picked.toDateTime();

                                  // ترکیب تاریخ میلادی و زمان انتخاب شده
                                  gregorianDate = DateTime(
                                    gregorianDate.year,
                                    gregorianDate.month,
                                    gregorianDate.day,
                                    time.hour,
                                    time.minute,
                                  );

                                  // تاریخ میلادی به صورت رشته
                                  String gregorianDateString =
                                  gregorianDate.toIso8601String();

                                  // به روز رسانی متغیرهای مورد نظر
                                  setModalState(() {
                                    selectedJalaliDate = jalaliDate;
                                    selectedGregorianDate = gregorianDateString;
                                  });
// UserS df=UserS('name', 'family');
// SaveToDataBase().saveNF(df);
// SaveToLocal().SaveNF(df);
//
// User fi=User('Name', 'family');
// fi.SaveToLocal();
// fi.SaveToDataBase();
//
//
//                                 aria bop=circel(1);
//                                 bop.mohasebat(2);
//                               print(  bop.toString());
                                  print(
                                      "Selected Jalali Date: $selectedJalaliDate");
                                  print(
                                      "Selected Gregorian Date: $gregorianDateString");
                                }
                              }
                            },
                            icon: Icon(
                              Icons.date_range,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Text('تاریخ تسویه : '),
                        Text(
                          selectedJalaliDate,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('کنسل'),
            ),
            TextButton(
              onPressed: () async {
                // context.read<OrderBloc>().add(DeleteOrder(order.id));
                orderController.deleteOrder(order.id!);
                Navigator.of(context).pop(); // Close the dialog

                // Notify user about the deletion
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('سفارش و محصولات حذف شد'),
                ));
              },
              child: const Text('حذف', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    addressController.text.isNotEmpty &&
                    NiyazNumberController.text.isNotEmpty &&
                    selectedJalaliDate.isNotEmpty &&
                    phonenumberitController.text.isNotEmpty &&
                    callnumberController.text.isNotEmpty) {
                  // ایجاد سفارش جدید
                  OrderTwo updatedOrder = OrderTwo(
                    id: order.id,
                    title: titleController.text,
                    callNumber: callnumberController.text,
                    listProductA: order.listProductA,
                    listProductB: order.listProductB,
                    dateNow: selectedJalaliDate,
                    dateAd: selectedGregorianDate,
                    address: addressController.text,
                    niyaz: NiyazNumberController.text,
                    phoneNumberIT: phonenumberitController.text,
                    buy: _isSwitchOn ? 'فروش و اسمبل' : 'فروش',
                    winner: order.winner,
                    created: order.created,
                  );

                  // ارسال به‌روزرسانی سفارش
                  //   context.read<OrderBloc>().add(UpdateOrder(updatedOrder));
                  orderController.updateOrder(updatedOrder);
                  titleController.clear();
                  addressController.clear();
                  NiyazNumberController.clear();
                  phonenumberitController.clear();
                  callnumberController.clear();

                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('لطفا تمام فیلد ها را پر کنید'),
                  ));
                }
              },
              child: const Text('به روز رسانی'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditConfigOrder(BuildContext context, OrderTwo order,
      OrderControllerPage orderController) {
    final TextEditingController registrationNumberController =
    TextEditingController(text: order.registrationNumber!);
    final TextEditingController nationalCodeController =
    TextEditingController(text: order.nationalCode);
    final TextEditingController postalCodeController =
    TextEditingController(text: order.postalCode);
    final TextEditingController economicCodeController =
    TextEditingController(text: order.economicCode);
    final TextEditingController accountingNumberController =
    TextEditingController(text: order.accountingNumber);
    final TextEditingController phoneNumberITController =
    TextEditingController(text: order.phoneNumberIT);
    final TextEditingController purchaseNumberController =
    TextEditingController(text: order.purchaseNumber);
    final TextEditingController addressController =
    TextEditingController(text: order.address);

    String orderType = order.buy!;
    bool isSwitchOn = orderType != 'فروش';
    Set<String> selectedWindowsTypes =
    order.windowsType!.toSet(); // Use a set to handle selected types

    void updateOrder() {
      if (registrationNumberController.text.isNotEmpty &&
          nationalCodeController.text.isNotEmpty &&
          postalCodeController.text.isNotEmpty &&
          economicCodeController.text.isNotEmpty &&
          accountingNumberController.text.isNotEmpty &&
          phoneNumberITController.text.isNotEmpty &&
          purchaseNumberController.text.isNotEmpty &&
          addressController.text.isNotEmpty) {
        OrderTwo updatedOrder = OrderTwo(
          id: order.id,
          address: addressController.text,
          phoneNumberIT: phoneNumberITController.text,
          buy: isSwitchOn ? 'فروش و اسمبل' : 'فروش',
          winner: order.winner,
          created: order.created,
          registrationNumber: registrationNumberController.text,
          nationalCode: nationalCodeController.text,
          postalCode: postalCodeController.text,
          economicCode: economicCodeController.text,
          accountingNumber: accountingNumberController.text,
          purchaseNumber: purchaseNumberController.text,
          title: '',
          callNumber: order.callNumber!,
          listProductB: [],
          listProductA: [],
          dateNow: '',
          dateAd: '',
          niyaz: '',
          type: '',
          windowsType: selectedWindowsTypes.toList(), // Convert set to list
        );

        orderController.updateConfigOrder(updatedOrder);
        Navigator.of(context).pop(); // Close the dialog
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('لطفا تمام فیلد ها را پر کنید'),
        ));
      }
    }

    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: const Center(child: Text('ثبت اطلاعات شرکت برنده شده')),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return SingleChildScrollView(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16),
                        _buildTextField(registrationNumberController, 'شماره ثبت'),
                        SizedBox(height: 16),
                        _buildTextField(nationalCodeController, 'کد ملی'),
                        SizedBox(height: 16),
                        _buildTextField(postalCodeController, 'کد پستی'),
                        SizedBox(height: 16),
                        _buildTextField(economicCodeController, 'کد اقتصادی'),
                        SizedBox(height: 16),
                        _buildPhoneNumberFields(
                          accountingNumberController,
                          phoneNumberITController,
                          purchaseNumberController,
                        ),
                        SizedBox(height: 16),
                        _buildTextField(addressController, 'آدرس'),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Switch(
                              activeColor: Colors.blue,
                              value: isSwitchOn,
                              onChanged: (value) {
                                setModalState(() {
                                  isSwitchOn = value;
                                });
                              },
                            ),
                            const Spacer(),
                            Text(
                              isSwitchOn ? 'فروش و اسمبل' : 'فروش',
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        _buildRadioButtons(setModalState, selectedWindowsTypes)
                      ],
                    ),
                  ));
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('کنسل'),
            ),
            TextButton(
              onPressed: () async {
                orderController.deleteOrder(order.id!);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('سفارش و محصولات حذف شد'),
                ));
              },
              child: const Text('حذف', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: updateOrder,
              child: const Text('به روز رسانی'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneNumberFields(
      TextEditingController accountingController,
      TextEditingController itController,
      TextEditingController purchaseController,
      ) {
    return Row(
      children: [
        Expanded(
            child:
            _buildTextField(accountingController, 'شماره تماس حسابداری')),
        SizedBox(width: 8),
        Expanded(child: _buildTextField(itController, 'شماره تماس IT')),
        SizedBox(width: 8),
        Expanded(
            child: _buildTextField(purchaseController, 'شماره تماس مسئول')),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: labelText),
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹]')),
        TextInputFormatter.withFunction((oldValue, newValue) {
          String newText = convertToEnglishNumbers(newValue.text);
          return TextEditingValue(
            text: newText,
            selection: TextSelection.collapsed(offset: newText.length),
          );
        }),
      ],
      onChanged: (value) {
        controller.value = TextEditingValue(
          text: convertToEnglishNumbers(value),
          selection: controller.selection,
        );
      },
    );
  }

  Widget _buildRadioButtons(
      StateSetter setModalState, Set<String> selectedWindowsTypes) {
    const List<String> allWindowsTypes = [
      '11',
      '10',
      '7',
      '8',
      'vista',
      'xp',
      'mac',
      'linux'
    ];

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text('نوع ویندوز',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 8),
              Center(
                child: Wrap(
                  spacing: 8,
                  children: allWindowsTypes.map((type) {
                    return _buildRadio(
                        setModalState, selectedWindowsTypes, type);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRadio(StateSetter setModalState,
      Set<String> selectedWindowsTypes, String type) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: selectedWindowsTypes.contains(type),
          onChanged: (bool? value) {
            setModalState(() {
              if (value == true) {
                selectedWindowsTypes.add(type);
              } else {
                selectedWindowsTypes.remove(type);
              }
            });
          },
        ),
        Text(type),
      ],
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void showGeneralCategoryDialog(
      BuildContext context, OrderTwo order, String? id) {
    final OrderControllerPage controller = Get.find<OrderControllerPage>();
    //final ControllerCategory controllerCategory = Get.find<ControllerCategory>();

    // اطمینان از لود شدن داده‌ها
    if (controller.generalCategories.isEmpty) {
      //  controller.fetch_order_buy_product();
    }
    RxBool isInDetailPage = false.obs;

    late String npi = '';
    if (controller.generalCategories.isNotEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              final PageController pageController =
              PageController(initialPage: 0);

              return AlertDialog(
                title: Text('دسته‌بندی محصولات'),
                content: Container(
                  width: double.maxFinite,
                  height: 900,
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: PageView(
                            controller: pageController,
                            physics: NeverScrollableScrollPhysics(),
                            onPageChanged: (index) {
                              setState(() {
                                isInDetailPage.value = index == 1;
                              });
                            },
                            children: [
                              // صفحه اصلی
                              Column(
                                children: [
                                  Expanded(
                                    child: GetBuilder<OrderControllerPage>(
                                      initState: (state) async {
                                        await controller
                                            .fetchGeneralCategories();
                                      },
                                      // id: 'update',
                                      builder: (controller) {
                                        return ListView.builder(
                                          itemCount: controller
                                              .generalCategories.length,
                                          itemBuilder: (context, index) {
                                            final generalCategory = controller
                                                .generalCategories[index];

                                            return ExpansionTile(
                                              backgroundColor: Colors.grey[200],
                                              title: Directionality(
                                                textDirection:
                                                TextDirection.rtl,
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(generalCategory
                                                        .titleen),
                                                    Text(generalCategory
                                                        .titleFa),
                                                  ],
                                                ),
                                              ),
                                              children: generalCategory
                                                  .productCategories
                                                  .map((productCategory) {
                                                return ExpansionTile(
                                                  backgroundColor:
                                                  Colors.grey[300],
                                                  title: Directionality(
                                                    textDirection:
                                                    TextDirection.rtl,
                                                    child: Text(
                                                        productCategory.title),
                                                  ),
                                                  children: productCategory
                                                      .nameProductCategories
                                                      .isNotEmpty
                                                      ? productCategory
                                                      .nameProductCategories
                                                      .map(
                                                          (nameProductCategory) {
                                                        return Container(
                                                          color: Colors
                                                              .grey[350],
                                                          child: ListTile(
                                                            title:
                                                            Directionality(
                                                              textDirection:
                                                              TextDirection
                                                                  .rtl,
                                                              child:
                                                              Container(
                                                                alignment:
                                                                Alignment
                                                                    .bottomRight,
                                                                child: Row(
                                                                  children: [
                                                                    IconButton(
                                                                      onPressed:
                                                                          () {
                                                                        setState(
                                                                                () {
                                                                              npi =
                                                                                  nameProductCategory.id; // تغییر به id نام محصول
                                                                              print('General Category Index: $index');
                                                                              print('Product Category Index: ${controller.generalCategories[index].productCategories.indexOf(productCategory)}');
                                                                              print('Name Product Category Index: ${productCategory.nameProductCategories.indexOf(nameProductCategory)}');
                                                                              print('Product Title: ${nameProductCategory.title}');
                                                                              print('Available Quantity: ${nameProductCategory.number}');
                                                                              isInDetailPage.value =
                                                                              true;
                                                                              controller.fetchNameProductCategory(npi);
                                                                            });
                                                                        pageController
                                                                            .nextPage(
                                                                          duration:
                                                                          Duration(milliseconds: 300),
                                                                          curve:
                                                                          Curves.easeInOut,
                                                                        );
                                                                      },
                                                                      icon: Icon(
                                                                          Icons.arrow_forward),
                                                                    ),
                                                                    Text(nameProductCategory
                                                                        .title),
                                                                    Spacer(),
                                                                    Text(
                                                                        'تعداد موجود: '),
                                                                    Text(nameProductCategory
                                                                        .number),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList()
                                                      : [
                                                    ListTile(
                                                      title: Text(
                                                          'No name categories available'),
                                                    ),
                                                  ],
                                                );
                                              }).toList(),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              //  صفحه جزئیات
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FutureBuilder(
                                    future:
                                    controller.fetchBuyProductsById(npi),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Center(
                                            child: Text(
                                                'Error: ${snapshot.error}'));
                                      }

                                      return Center(
                                          child: SizedBox(
                                            height: 520,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                //       نمایش دسته‌بندی محصولات
                                                Center(
                                                  child: GetBuilder<
                                                      OrderControllerPage>(
                                                    //           id: 'productD',
                                                    builder: (controllercat) {
                                                      if (controllercat
                                                          .nameProductCategorys ==
                                                          null) {
                                                        return CircularProgressIndicator();
                                                      }

                                                      NameProductCategory
                                                      categorysa = controllercat
                                                          .nameProductCategorys!;
                                                      return Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Text(' ${categorysa.id}',
                                                              style: TextStyle(
                                                                  fontSize: 10)),
                                                          Text(
                                                              ' ${categorysa.title}',
                                                              style: TextStyle(
                                                                  fontSize: 20)),
                                                          Text(
                                                              ' ${categorysa.number}',
                                                              style: TextStyle(
                                                                  fontSize: 20)),
                                                          Container(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: IconButton(
                                                              onPressed: () {
                                                                _showAddProductDialogB(
                                                                    context,
                                                                    categorysa
                                                                        .title,
                                                                    controller,
                                                                    id!,
                                                                    categorysa.id);
                                                              },
                                                              icon: Icon(Icons
                                                                  .exposure_minus_1),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),

                                                SizedBox(height: 20),
                                                Expanded(
                                                  child: GetBuilder<
                                                      OrderControllerPage>(
                                                    //      id: 'productbuy',
                                                    builder: (controller) {
                                                      NameProductCategory
                                                      categorysa = controller
                                                          .nameProductCategorys!;
                                                      return ListView.builder(
                                                        itemCount: controller
                                                            .buyProducts.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final buyProduct =
                                                          controller
                                                              .buyProducts[
                                                          index];
                                                          return Column(
                                                            children: [
                                                              // نمایش اطلاعات محصول خریداری شده
                                                              Card(
                                                                margin:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                    4.0,
                                                                    horizontal:
                                                                    16.0),
                                                                child: Container(
                                                                  decoration:
                                                                  BoxDecoration(
                                                                    border:
                                                                    Border.all(
                                                                        width:
                                                                        4),
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        8.0),
                                                                  ),
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        8.0),
                                                                    child: Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .stretch,
                                                                      children: [
                                                                        IconButton(
                                                                          icon: Icon(
                                                                              Icons
                                                                                  .delete),
                                                                          onPressed:
                                                                              () {
                                                                            if (orderController
                                                                                .buyProducts[index]
                                                                                .snBuyProductLogin!
                                                                                .isEmpty) {
                                                                              orderController
                                                                                  .deleteBuyId_BuyProdut(
                                                                                '${buyProduct.id}',
                                                                                '${buyProduct.number}',
                                                                                categorysa.id,
                                                                              );
                                                                            } else {
                                                                              Get.snackbar(
                                                                                'خطا',
                                                                                'شما مجاز به حذف سفارش محصول نیستید این کالا ورود به انبار دارد',
                                                                                backgroundColor:
                                                                                Colors.red,
                                                                              );
                                                                            }
                                                                            Navigator.of(context)
                                                                                .pop();
                                                                          },
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Card(
                                                                              child:
                                                                              //     IconButton(
                                                                              //   icon:
                                                                              //       const Icon(Icons.mode_edit),
                                                                              //   onPressed:
                                                                              //       () {
                                                                              //     // نمایش دیالوگ و پروگرس بار
                                                                              //     showDialog(
                                                                              //       context: context,
                                                                              //       barrierDismissible: false,
                                                                              //       builder: (context) {
                                                                              //         return Center(
                                                                              //           child: CircularProgressIndicator(),
                                                                              //         );
                                                                              //       },
                                                                              //     );
                                                                              //     // تاخیر برای نشان دادن پیشرفت
                                                                              //     Future.delayed(Duration(seconds: 1), () {
                                                                              //       Navigator.of(context).pop();
                                                                              //     });
                                                                              //   },
                                                                              // ),

                                                                              Text('${buyProduct.title} '),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            const Text(
                                                                                'تعداد: '),
                                                                            Text(buyProduct
                                                                                .number!),
                                                                            Spacer(),
                                                                          ],
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                const SizedBox(width: 20),
                                                                                Expanded(
                                                                                  child: Text('قیمت خرید: ${buyProduct.purchasePrice!.convertToPrice()}'),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text('\n' + ' جمع مبلغ کل به حروف: ' + buyProduct.purchasePrice!.toWord() + ' ریال'),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Spacer(),
                                                                                Row(
                                                                                  children: [
                                                                                    Text('نوع سفارش: '),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Text(' گارانتی:  '),
                                                                              ],
                                                                            ),
                                                                            ExpansionTile(
                                                                              title:
                                                                              Text('SN ورود و خروج به انبار'),
                                                                              children: [
                                                                                ...buyProduct.snBuyProductLogin!.map((sn) =>
                                                                                    ListTile(
                                                                                      title: Text('${sn.title} (${sn.sn})'),
                                                                                    )),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // دکمه بازگشت به صفحه اصلی یا بستن
                          TextButton(
                            onPressed: () {
                              if (isInDetailPage.value) {
                                setState(() {
                                  isInDetailPage.value = false;
                                });
                                pageController.previousPage(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(isInDetailPage.value
                                ? 'بازگشت به صفحه اصلی'
                                : 'بستن'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }

  void _showAddProductDialogB(
      BuildContext context,
      String title,
      OrderControllerPage controllersa,
      String orderId,
      String idproduct,
      ) {
    late String futureDateGregorianString;

    bool official = false;
    bool hurry = false;
    bool isValuable = false;

    int storedDays = 0;
    late String daysa;
    Jalali currentDate = Jalali.now();
    Jalali futureDate = currentDate.addDays(storedDays);

    final TextEditingController productTitleController =
    TextEditingController(text: title);
    final TextEditingController productPriceController =
    TextEditingController();
    final TextEditingController productNumberController =
    TextEditingController();
    final TextEditingController controller =
    TextEditingController(text: storedDays.toString());

    // متغیرهای جدید برای درصد و قیمت تمام شده
    final TextEditingController percentageController = TextEditingController();
    final TextEditingController finalPriceController = TextEditingController();

    // تابع برای محاسبه قیمت تمام شده
    void _calculateFinalPrice() {
      final price =
          double.tryParse(productPriceController.text.replaceAll(',', '')) ?? 0;
      final percentage = double.tryParse(percentageController.text) ?? 0;
      final finalPrice = price + (price * (percentage / 100));
      finalPriceController.text = finalPrice.convertToPricedobelBuyProduct();
    }

    List<String> removeDuplicates(List<String> list) {
      return list.toSet().toList();
    }

    List<String> g = [];
    List<String> uniqueList = [];

    void handleSelectionChange(
        List<dynamic> allSelectedItems, String selectedItem) {
      g.add(selectedItem);
      uniqueList = removeDuplicates(allSelectedItems.cast<String>());
      print(uniqueList);
    }

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Row(children: [
            Text('$title'),
            Text(' خرید محصول '),
          ]),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  readOnly: true,
                  controller: productTitleController,
                  decoration: const InputDecoration(labelText: 'نام محصول'),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: productPriceController,
                  decoration: const InputDecoration(labelText: 'قیمت خرید'),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    PriceInputFormatter(),
                  ],
                  onChanged: (value) {
                    _calculateFinalPrice();
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: productNumberController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'تعداد'),
                ),
                const SizedBox(height: 10),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('امروز: '),
                        Text(currentDate.formatCompactDateCustom()),
                      ],
                    ),
                    TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'چند روز تا تسویه را وارد کنید'),
                      onChanged: (value) {
                        setState(() {
                          int days = int.tryParse(value) ?? storedDays;
                          futureDate = currentDate.addDays(days);

                          Jalali futureDatee = currentDate.addDays(days);

                          // تبدیل تاریخ شمسی به میلادی
                          Gregorian futureDateGregorian =
                          futureDatee.toGregorian();

                          // ساخت DateTime میلادی با ساعت 23:59:59
                          DateTime futureDateTime = DateTime(
                            futureDateGregorian.year,
                            futureDateGregorian.month,
                            futureDateGregorian.day,
                            23,
                            59,
                            59,
                          );

                          // تبدیل به رشته برای نمایش به صورت ISO 8601
                          futureDateGregorianString =
                              futureDateTime.toIso8601String();

                          daysa = days.toString();
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('تاریخ تسویه: '),
                        Text(controller.text.isEmpty
                            ? 'چند روز تا تسویه را وارد کنید'
                            : '${futureDate.year}-${futureDate.month.toString().padLeft(2, '0')}-${futureDate.day.toString().padLeft(2, '0')}'),
                      ],
                    ),
                  ],
                ),
                GetBuilder<ControllerGuaranty>(
                  id: 'garrantya',
                  builder: (controller) {
                    return MultiSelectContainer(
                      prefix: MultiSelectPrefix(
                        selectedPrefix: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                        disabledPrefix: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.do_disturb_alt_sharp,
                            size: 14,
                          ),
                        ),
                      ),
                      items: controller.fetchGuarantyProductItems!.map((item) {
                        return MultiSelectCard(
                          value: item.garranty,
                          label: item.garranty,
                        );
                      }).toList(),
                      onChange: (allSelectedItems, selectedItem) {
                        handleSelectionChange(allSelectedItems, selectedItem);
                      },
                    );
                  },
                ),
                Row(
                  children: [
                    // Text('رسمی و غیر رسمی'),
                    Switch(
                      value: official,
                      onChanged: (value) {
                        setState(() {
                          official = value;
                          if (!official) {
                            percentageController.clear();
                            finalPriceController.clear();
                            isValuable = false;
                          }
                        });
                      },
                    ),
                    Spacer(),
                    Text(official ? 'رسمی' : 'غیر رسمی'),
                  ],
                ),
                if (official) ...[
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: percentageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'درصد اضافه'),
                    onChanged: (value) {
                      _calculateFinalPrice();
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: finalPriceController,
                    readOnly: true,
                    decoration:
                    const InputDecoration(labelText: 'قیمت تمام شده'),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: isValuable,
                        onChanged: (value) {
                          setState(() {
                            isValuable = value ?? false;
                          });
                        },
                      ),
                      const Text('ارزشی'),
                    ],
                  ),
                ],
                const SizedBox(height: 10),
                Row(
                  children: [
                    // Text('عجله ای'),
                    Switch(
                      value: hurry,
                      onChanged: (value) {
                        setState(() {
                          hurry = value;
                        });
                      },
                    ),
                    Spacer(),
                    Text(hurry ? 'عجله دارد' : 'عجله ندارد'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('کنسل'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (g.isEmpty) {
                  String productTitle = productTitleController.text;
                  String productPrice = productPriceController.text
                      .convertToPrice()
                      .replaceAll(',', '');
                  String percentage = percentageController.text
                      .convertToPrice()
                      .replaceAll(',', '');
                  String finalPrice = finalPriceController.text
                      .convertToPrice()
                      .replaceAll(',', '');
                  String productNumber = productNumberController.text;
                  if (productTitle.isNotEmpty &&
                      productPrice.isNotEmpty &&
                      productNumber.isNotEmpty) {
                    // نمایش Progress Indicator
                    showDialog(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );

                    await controllersa.addProductToBuyProduct(
                        title: "${productTitle}",
                        supplierId: '${controllersa.selectedSupplierID}',
                        days: '${daysa}',
                        dateCreated:
                        '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}',
                        dataClearing:
                        '${futureDate.year}-${futureDate.month.toString().padLeft(2, '0')}-${futureDate.day.toString().padLeft(2, '0')}',
                        number: "${productNumber}",
                        dateAd: futureDateGregorianString,
                        hurry: hurry,
                        official: official,
                        purchasePrice: productPrice.split('.').first,
                        orderID: orderId,
                        idproduct: idproduct,
                        idupdate: 'id',
                        //     isValuable: isValuable,
                        percent: percentage,
                        saleprice: finalPrice,
                        valuable: isValuable);

                    // بستن Progress Indicator
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('محصول با موفقیت اضافه شد'),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('لطفا اطلاعات رو کامل کنید'),
                    ));
                  }
                } else {
                  print('rrrrrrrrrrrrrr');
                  print('${uniqueList.length}');

                  String productTitle = productTitleController.text;
                  String productPrice = productPriceController.text
                      .convertToPrice()
                      .replaceAll(',', '');
                  String percentage = percentageController.text
                      .convertToPrice()
                      .replaceAll(',', '');
                  String finalPrice = finalPriceController.text
                      .convertToPrice()
                      .replaceAll(',', '');
                  String productNumber = productNumberController.text;
                  if (productTitle.isNotEmpty &&
                      productPrice.isNotEmpty &&
                      productNumber.isNotEmpty) {
                    // نمایش Progress Indicator
                    showDialog(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );

                    await controllersa.addProductToBuyProductByGaranty(
                        title: "${productTitle}",
                        supplierId: '${controllersa.selectedSupplierID}',
                        days: '${daysa}',
                        dateCreated:
                        '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}',
                        dataClearing:
                        '${futureDate.year}-${futureDate.month.toString().padLeft(2, '0')}-${futureDate.day.toString().padLeft(2, '0')}',
                        number: "${productNumber}",
                        dateAd: futureDateGregorianString,
                        hurry: hurry,
                        official: official,
                        purchasePrice: productPrice.split('.').first,
                        orderID: orderId,
                        idproduct: idproduct,
                        idupdate: 'id',
                        //     isValuable: isValuable,
                        percent: percentage,
                        saleprice: finalPrice,
                        valuable: isValuable,
                        garanty: uniqueList);

                    // بستن Progress Indicator
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('محصول با موفقیت اضافه شد'),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('لطفا اطلاعات رو کامل کنید'),
                    ));
                  }
                }

                // به‌روزرسانی ویجت‌های وابسته
              }

              ///////////////

              ///////////////

              ,
              child: const Text('ثبت سفارش محصول'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddProductDialogA(BuildContext context,
      OrderControllerPage orderController, OrderTwo order, String productType) {
    final ControllerProduct controllerProduct = Get.find<ControllerProduct>();
    final TextEditingController productTitleController =
    TextEditingController();
    final TextEditingController productNumberController =
    TextEditingController();
    List<String> g = [];
    List<String> uniqueList = [];

    List<String> removeDuplicates(List<String> list) {
      return list.toSet().toList();
    }

    void handleSelectionChange(
        List<dynamic> allSelectedItems, String selectedItem) {
      g.add(selectedItem);
      uniqueList = removeDuplicates(allSelectedItems.cast<String>());
      print(uniqueList);
    }

    void handleAddButton() {
      String productTitle = productTitleController.text;
      String productNumber =
      convertToEnglishNumbers(productNumberController.text);
      if (productTitle.isNotEmpty && productNumber.isNotEmpty) {
        if (g.isEmpty) {
          orderController.addProductToA(
              order.id!, productTitle, '0', productNumber, controllerProduct);
        } else {
          orderController.addProductToAGranty(order.id!, productTitle, '0',
              uniqueList, productNumber, controllerProduct);
        }
        Navigator.of(context).pop();
        orderController.update(); // به‌روزرسانی ویجت‌های وابسته
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          dismissDirection: DismissDirection.up,
          content: Directionality(
            textDirection: TextDirection.rtl,
            child: Text('نام محصول و تعداد حتما باید وارد شود'),
          ),
        ));
      }
    }

    Future<List<Product>> _fetchSuggestions(String searchValue) async {
      return controllerProduct.selectedProductItems
          .where((product) => product.nameproduct
          .toLowerCase()
          .contains(searchValue.toLowerCase()))
          .toList();
    }

    showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          title: Center(
            child: Text('اضافه کردن محصول $productType'),
          ),
          content: SingleChildScrollView(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetBuilder<ControllerProduct>(
                    id: 'product',
                    builder: (controller) {
                      return FutureBuilder<List<Product>>(
                        future: _fetchSuggestions(''),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Text('پیدا نشد محصول');
                          }
                          return SearchField(
                            suggestions: snapshot.data!
                                .map((e) =>
                                SearchFieldListItem(e.nameproduct, item: e))
                                .toList(),
                            suggestionState: Suggestion.expand,
                            textInputAction: TextInputAction.next,
                            hint: 'جستجوی محصول',
                            suggestionStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.black.withOpacity(0.8),
                            ),
                            searchInputDecoration: SearchInputDecoration(
                              hintText: 'جستجوی محصول',
                              hintStyle: TextStyle(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                            maxSuggestionsInViewPort: 6,
                            itemHeight: 50,
                            onSuggestionTap: (x) {
                              final selectedProduct = x.item as Product;
                              productTitleController.text =
                                  selectedProduct.nameproduct;
                            },
                            textAlign: TextAlign.right,
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: productTitleController,
                    decoration: const InputDecoration(labelText: 'نام محصول'),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: productNumberController,
                    decoration: const InputDecoration(labelText: 'تعداد'),
                  ),
                  const SizedBox(height: 15),
                  GetBuilder<ControllerGuaranty>(
                    id: 'garrantya',
                    builder: (controller) {
                      return MultiSelectContainer(
                        prefix: MultiSelectPrefix(
                          selectedPrefix: const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                          disabledPrefix: const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(
                              Icons.do_disturb_alt_sharp,
                              size: 14,
                            ),
                          ),
                        ),
                        items: controller.fetchGuarantyProductItems.map((item) {
                          return MultiSelectCard(
                            value: item.garranty,
                            label: item.garranty,
                          );
                        }).toList(),
                        onChange: (allSelectedItems, selectedItem) {
                          handleSelectionChange(allSelectedItems, selectedItem);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('کنسل'),
            ),
            ElevatedButton(
              onPressed: handleAddButton,
              child: const Text('ثبت محصول'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsDialogA extends StatelessWidget {
  final String productId;
  final String productType;
  final String productTitle;
  final String productPrice;
  final OrderControllerPage orderController;
  final List<String> listG;
  final String number;
  final String buyproduct;

  ProductDetailsDialogA({
  super.key,
  required this.productId,
  required this.productType,
  required this.productTitle,
  required this.productPrice,
  required this.orderController,
  required this.listG,
  required this.number,
  required this.buyproduct,
  });

  //////

  List<String> g = [];
  List<String> uniqueList = [];
  final ControllerProduct controllerProduct = Get.find<ControllerProduct>();

  List<String> removeDuplicates(List<String> list) {
    return list.toSet().toList();
  }

  void handleSelectionChange(
      List<dynamic> allSelectedItems, String selectedItem) {
    g.add(selectedItem);
    uniqueList = removeDuplicates(allSelectedItems.cast<String>());
    print(uniqueList);
  }

  ///////

  ////

  Future<List<Product>> _fetchSuggestions(String searchValue) async {
    return controllerProduct.selectedProductItems
        .where((product) => product.nameproduct
        .toLowerCase()
        .contains(searchValue.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
    TextEditingController(text: productTitle);
    // final TextEditingController priceController =
    // TextEditingController(text: productPrice.convertToPrice());
    final TextEditingController numberController =
    TextEditingController(text: number);
    List<String> selectedItems = List.from(listG);

    return AlertDialog(
      title: Center(
        child: Text('$productType استعلام '),
      ),
      content: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<ControllerProduct>(
              id: 'product',
              builder: (controller) {
                return FutureBuilder<List<Product>>(
                  future: _fetchSuggestions(''),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('پیدا نشد محصول');
                    }
                    return SearchField(
                      suggestions: snapshot.data!
                          .map((e) =>
                          SearchFieldListItem(e.nameproduct, item: e))
                          .toList(),
                      suggestionState: Suggestion.expand,
                      textInputAction: TextInputAction.next,
                      hint: 'جستجوی محصول',
                      suggestionStyle: TextStyle(
                        fontSize: 18,
                        color: Colors.black.withOpacity(0.8),
                      ),
                      searchInputDecoration: SearchInputDecoration(
                        hintText: 'جستجوی محصول',
                        hintStyle: TextStyle(),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.8)),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      maxSuggestionsInViewPort: 6,
                      itemHeight: 50,
                      onSuggestionTap: (x) {
                        final selectedProduct = x.item as Product;
                        titleController.text = selectedProduct.nameproduct;
                      },
                      textAlign: TextAlign.right,
                    );
                  },
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'نام محصول'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: numberController,
              decoration: const InputDecoration(labelText: 'تعداد'),
            ),
            SizedBox(
              height: 15,
            ),
            GetBuilder<ControllerGuaranty>(
              id: 'garrantya',
              builder: (controller) {
                return MultiSelectContainer(
                  prefix: MultiSelectPrefix(
                    selectedPrefix: const Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                    disabledPrefix: const Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.do_disturb_alt_sharp,
                        size: 14,
                      ),
                    ),
                  ),
                  items: controller.fetchGuarantyProductItems.map((item) {
                    return MultiSelectCard(
                      value: item.garranty,
                      label: item.garranty,
                      selected: selectedItems.contains(item.garranty),
                    );
                  }).toList(),
                  onChange: (allSelectedItems, selectedItem) {
                    selectedItems =
                        removeDuplicates(allSelectedItems.cast<String>());
                    print(selectedItems);
                  },
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('کنسل'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('حذف', style: TextStyle(color: Colors.red)),
          onPressed: () {
            if (buyproduct == '+') {
              orderController.deleteProductA(productId);
              Navigator.of(context).pop();
            } else {
              Get.snackbar('محصول با نام ${productTitle}',
                  'قابل حذف نیست ممحصول خریداری شده دارد',
                  backgroundColor: Colors.red[300]);
              print(buyproduct);
            }
          },
        ),
        TextButton(
          child: const Text('ویرایش محصول'),
          onPressed: () {
            final newTitle = titleController.text;
            //  final newPrice = parsePrice(priceController.text);
            final newNumber = convertToEnglishNumbers(numberController.text);
            if (newTitle.isNotEmpty &&
                //  newPrice.isNotEmpty &&
                newNumber.isNotEmpty) {
              if (selectedItems.isEmpty) {
                orderController.updateProductA(
                    productId, newTitle, '0', newNumber);
              } else {
                orderController.updateProductAByeGaranty(
                    productId, newTitle, '0', selectedItems, newNumber);
              }
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('نام محصول و تعداد حتما باید وارد شود'),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

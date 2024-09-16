import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:persian_number_utility/persian_number_utility.dart';


import 'package:slide_countdown/slide_countdown.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:searchfield/searchfield.dart';
import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

import 'package:get/get.dart';

import 'package:project/BuySell_GetX/Supiller/Location_GetX/supplier_list_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class OrderListView extends StatelessWidget {
//   final OrderControllerPage orderController = Get.put(OrderControllerPage());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order List'),
//       ),
//       body: Obx(() {
//         if (orderController.orders.isEmpty) {
//           return Center(child: CircularProgressIndicator()); // نمایش بارگذاری
//         }
//
//         if (orderController.orders.isEmpty) {
//           return Center(child: Text('No orders found.')); // نمایش پیام در صورت خالی بودن لیست
//         }
//
//         return ListView.builder(
//           itemCount: orderController.orders.length,
//           itemBuilder: (context, index) {
//             final order = orderController.orders[index];
//             return
//
//               Card(
//
//
//                 margin: const EdgeInsets.all(8),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: ListView(
//
//                     children: [
//
//
//                       Row(
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 'شماره سفارش ${order.title.toString()}',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                           Spacer(),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//
//                           Row(
//                             children: [
//                               Text('نام ارگان : '),
//                               Text(
//                                 order.title,
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//
//                           const SizedBox(height: 3),
//                           Row(
//                             children: [
//                               Text('شماره تماس ثابت  : '),
//                               Text(
//                                 order.callnumber,
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 3),
//                           Row(
//                             children: [
//                               Text('شماره تماس همراه IT  : '),
//                               Text(
//                                 order.phonenumberit,
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 3),
//                           Row(
//                             children: [
//                               Text('آدرس  : '),
//                               Text(
//                                 order.address,
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 3),
//                           Row(
//                             children: [
//                               Text(' نوع سفارش : '),
//                               Text(
//                                 order.buy,
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 3),
//                           Row(
//                             children: [
//                               Text(' تاریخ ثبت سفارش : '),
//                               Text(
//                                 order.created,
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 3),
//                           Row(
//                             children: [
//                               Text(' تاریخ اعتبار سفارش : '),
//                               Text(
//                                 order.datenow,
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               const SizedBox(height: 3),
//
//                               SizedBox(height: 20),
//
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                         ],
//                       ),
//
//
//
//                       SizedBox(height: 20),
//                       Text('Product A List:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//
//
//
//
//
//                       ExpansionTileBorderItem(
//                         textColor: Colors.black,
//                         border: Border.all(
//                          // color: determineCollapsedBorderColor(order.listProductAa),
// // رنگ بوردر بر اساس محاسبات شما
//                           width: 4, // ضخامت بوردر
//                         ),
//                         title: Column(
//                           children: [
//                             Text('محصولات'),
//                           ],
//                         ),
//                         children: [
//                           ExpansionTileGroup(
//                             spaceBetweenItem: 14,
//                             toggleType: ToggleType.expandOnlyCurrent,
//
//                             children: order.listProductAa.map((product) =>
//
//                                 ExpansionTileBorderItem(
//                                   textColor: Colors.black,
//                                   collapsedBackgroundColor: product.unavailable
//                                       ? Colors.green[200]
//                                       : Colors.orange[200],
//                                   backgroundColor: product.unavailable
//                                       ? Colors.green[200]
//                                       : Colors.orange[200],
//
//                                   key: Key(product.id),
//
//                                   title: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Row(
//                                             mainAxisSize: MainAxisSize.max,
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             children: [
//                                               Card(
//                                                 child: Column(children: [
//                                                   IconButton(
//                                                     icon: const Icon(Icons.add),
//                                                     onPressed: () {
//                                                       orderController
//                                                           .fetchAllSuppliers();
//                                                       bool rezerv = false;
//
//                                                     },
//                                                   ),
//                                                 ]),
//                                               ),
//                                             ],
//                                           ),
//                                           Text(product.title),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(' گارانتی :  '),
//                                           MultiSelectContainer(
//                                             prefix: MultiSelectPrefix(
//                                               selectedPrefix: const Padding(
//                                                 padding: EdgeInsets.only(right: 5),
//                                                 child: Icon(
//                                                   Icons.check,
//                                                   color: Colors.blue,
//                                                   size: 14,
//                                                 ),
//                                               ),
//                                               disabledPrefix: const Padding(
//                                                 padding: EdgeInsets.only(right: 5),
//                                                 child: Icon(
//                                                   Icons.do_disturb_alt_sharp,
//                                                   size: 14,
//                                                 ),
//                                               ),
//                                             ),
//                                             items: product.garranty.map((item) {
//                                               return MultiSelectCard(
//                                                 value: item,
//                                                 label: item.garranty,
//                                               );
//                                             }).toList(),
//                                             onChange: (allSelectedItems, selectedItem) {
// // handleSelectionChange(allSelectedItems, selectedItem);
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           const Text('تعداد: '),
//                                           Text(product.number),
//                                           Spacer(),
//                                           Text('عدم موجودی'),
//                                           Switch(
//                                             value: product.unavailable,
//                                             onChanged: (bool value) {
//                                               if (value == true) {
//                                                 bool un = value;
//
//                                               } else {
//                                                 showDialog(
//                                                   context: context,
//                                                   builder: (BuildContext context) {
//                                                     bool un = value;
//                                                     TextEditingController noteController =
//                                                     TextEditingController(
//                                                         text: product.description);
//                                                     return AlertDialog(
//                                                       title: const Text('توضیح محصول'),
//                                                       content: TextField(
//                                                         controller: noteController,
//                                                         maxLines: 5,
//                                                         decoration: const InputDecoration(
//                                                           border: OutlineInputBorder(),
//                                                           labelText: 'توضیحات',
//                                                         ),
//                                                       ),
//                                                       actions: [
//                                                         TextButton(
//                                                           onPressed: () {
//                                                             Navigator.of(context).pop();
//                                                           },
//                                                           child: const Text('کنسل'),
//                                                         ),
//                                                         TextButton(
//                                                           onPressed: () {
//
//                                                             Navigator.of(context).pop();
//                                                           },
//                                                           child: const Text('تایید'),
//                                                         ),
//                                                       ],
//                                                     );
//                                                   },
//                                                 );
//                                               }
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 5),
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Expanded(
//                                             child: TextField(
//                                               controller: TextEditingController(
//                                                   text: product.purchaseprice
//                                                       .convertToPrice()),
//                                               decoration: const InputDecoration(
//                                                   labelText: 'قیمت خرید'),
//                                               keyboardType: TextInputType.number,
//                                               inputFormatters: [
//                                                 FilteringTextInputFormatter.allow(
//                                                     RegExp(r'[0-9۰-۹]')),
//                                                 TextInputFormatter.withFunction(
//                                                       (oldValue, newValue) {
//                                                     String newText =
//                                                     convertToEnglishNumbers(
//                                                         newValue.text);
//                                                     return TextEditingValue(
//                                                       text: newText,
//                                                       selection: TextSelection.collapsed(
//                                                           offset: newText.length),
//                                                     );
//                                                   },
//                                                 ),
//                                               ],
//                                               onTap: () {
//                                                 showDialog(
//                                                   context: context,
//                                                   builder: (BuildContext context) {
//                                                     return Directionality(
//                                                         textDirection: TextDirection.rtl,
//                                                         child: AlertDialog(
//                                                           title: const Text(
//                                                               'قیمت محصول استعلام'),
//                                                           content: Container(
//                                                               child: TextField(
//                                                                 controller:
//                                                                 TextEditingController(
//                                                                     text: product
//                                                                         .purchaseprice
//                                                                         .convertToPrice()),
//                                                                 decoration:
//                                                                 const InputDecoration(
//                                                                     labelText:
//                                                                     'قیمت خرید'),
//                                                                 keyboardType:
//                                                                 TextInputType.number,
//                                                                 inputFormatters: [
//                                                                   FilteringTextInputFormatter
//                                                                       .allow(RegExp(
//                                                                       r'[0-9۰-۹]')),
//                                                                   TextInputFormatter
//                                                                       .withFunction(
//                                                                         (oldValue,
//                                                                         newValue) {
//                                                                       String newText =
//                                                                       convertToEnglishNumbers(
//                                                                           newValue
//                                                                               .text
//                                                                               .convertToPrice());
//                                                                       return TextEditingValue(
//                                                                         text: newText,
//                                                                         selection: TextSelection
//                                                                             .collapsed(
//                                                                             offset: newText
//                                                                                 .length),
//                                                                       );
//                                                                     },
//                                                                   ),
//                                                                 ],
//
//                                                                 onChanged: (value) {
// // widget.orderController
// //     .updateProductBPricepurch(
// //     productA.id,
// //     value);
//                                                                 },
//                                                               ),
//                                                               width: 200),
//                                                         ));
//                                                   },
//                                                 );
//                                               },
//                                             ),
//                                           ),
//                                           SizedBox(width: 20),
//                                         ],
//                                       ),
//                                       const SizedBox(height: 10),
//                                       Text('قیمت به حروف : ' +
//                                           '${product.purchaseprice.toWord()} ' +
//                                           ' ریال'),
//                                       const SizedBox(height: 10),
//                                       Text('توضیحات محصول: ' + '${product.description}'),
//                                     ],
//                                   ),
//
//
//
//
//
//
//
//
// // title: Text(product.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                                   children: [
//
//
//
//
//
//
//
//                                     Card(
//                                       margin: const EdgeInsets.symmetric(
//                                           vertical: 4.0, horizontal: 16.0),
//                                       child: Container(
//                                         decoration: BoxDecoration(
// // color: product.listbuyProduct.okbuy
// // ? Colors.green[100]
// //     : Colors.yellow[200],
// // تغییر رنگ پس‌زمینه بر اساس productB.okbuy
//                                           border: Border.all(
// // color: productB.hurry
// // ? Colors.blue
// //     : Colors.grey,
// // تغییر رنگ بوردر بر اساس productB.hurry
//                                             width: 4, // ضخامت بوردر
//                                           ),
//                                           borderRadius:
//                                           BorderRadius.circular(8.0), // شکل گرد بوردر
//                                         ),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.stretch,
//                                             children: [
//
//
//                                               Row(
//                                                 children: [
//                                                   Card(
//                                                     child: Column(children: [
//                                                       IconButton(
//                                                         icon: const Icon(Icons.mode_edit),
//                                                         onPressed: () async {
// // نمایش پروگرس بار به مدت 1 ثانیه
//                                                           showDialog(
//                                                             context: context,
//                                                             barrierDismissible: false,
//                                                             builder: (context) {
//                                                               return Center(
//                                                                 child: CircularProgressIndicator(),
//                                                               );
//                                                             },
//                                                           );
//
//                                                         },
//                                                       ),
//                                                     ]),
//                                                   ),
//                                                   Text('${product.listbuyProduct.title} '),
//                                                 ],
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   const Text('تعداد: '),
//                                                   Text(product.listbuyProduct.number),
//                                                   Spacer(),
//
//                                                 ],
//                                               ),
//                                               Column(
//                                                 children: [
//                                                   Row(
//                                                     children: [
//                                                       const SizedBox(width: 20),
//                                                       Expanded(
//                                                         child: TextField(
//                                                           controller:
//                                                           TextEditingController(
//                                                               text: product.listbuyProduct
//                                                                   .purchaseprice
//                                                                   .convertToPrice()),
//                                                           decoration:
//                                                           const InputDecoration(
//                                                             border: OutlineInputBorder(),
//                                                             labelText: 'قیمت خرید',
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Expanded(
//                                                         child: Text('\n' +
//                                                             ' جمع مبلغ کل به حروف : ' +
//                                                             product.purchaseprice
//                                                                 .toWord() +
//                                                             ' ریال '),
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Spacer(),
//                                                       Row(
//                                                         children: [
//                                                           Text('نوع سفارش : '),
// // Text(product.listbuyProduct.official
// // ? 'رسمی'
// //     : 'غیر رسمی'),
//
//                                                         ],
//                                                       )
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       Text(' گارانتی :  '),
//                                                       MultiSelectContainer(
//                                                         prefix: MultiSelectPrefix(
//                                                           selectedPrefix: const Padding(
//                                                             padding: EdgeInsets.only(right: 5),
//                                                             child: Icon(
//                                                               Icons.check,
//                                                               color: Colors.blue,
//                                                               size: 14,
//                                                             ),
//                                                           ),
//                                                           disabledPrefix: const Padding(
//                                                             padding: EdgeInsets.only(right: 5),
//                                                             child: Icon(
//                                                               Icons.do_disturb_alt_sharp,
//                                                               size: 14,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         items: product. listbuyProduct.garranty.map((items) {
//                                                           return MultiSelectCard(
//                                                             value: items,
//                                                             label: items.garranty,
//                                                           );
//                                                         }).toList(),
//                                                         onChange: (allSelectedItems, selectedItem) {
// // handleSelectionChange(allSelectedItems, selectedItem);
//                                                         },
//                                                       ),
//                                                     ],
//                                                   ),
//                                                   ExpansionTileBorderItem(
//                                                     title:
//                                                     Text('SN ورود و خروج به انبار', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                                                     children: [
//                                                       ...product.listbuyProduct.snBuyProductLogin.map((sn) =>
//                                                           SizedBox(child:  Center(
//                                                             widthFactor: double.infinity,
//                                                             child:      Card(
//
//                                                               child:   Text('- ${sn.title} (${sn.sn})', style: TextStyle(fontSize: 16)),),),width: double.infinity,)
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//
//
//                                   ],
//                                 )
//                             ).toList(),
//                           ),
//                         ],
//                       ),
//
//                     ],
//                   ),
//                 ),
//               );
//
//           },
//         );
//       }),
//     );
//   }
//
//
// }


// class OrderView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final OrderControllerPage orderController = Get.put(OrderControllerPage());
// orderController.fetchAllOrderskmklist;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Details'),
//       ),
//       body: FutureBuilder<List<OrderNew>>(
//         future: orderController.fetchAllOrdersfesh(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
//             return Center(
//               child: Text('No orders found'),
//             );
//           } else {
//             final orders = snapshot.data!;
//
//             return ListView.builder(
//               itemCount: orders.length,
//               itemBuilder: (context, index) {
//                 final order = orders[index];
//                 return
//                   Card(
//
//
//                     margin: const EdgeInsets.all(8),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16),
//                       child: ListView(
//
//                         children: [
//
//
//                           Row(
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     'شماره سفارش ${order.title.toString()}',
//                                     style: TextStyle(fontWeight: FontWeight.bold),
//                                   )
//                                 ],
//                               ),
//                               Spacer(),
//                             ],
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//
//                               Row(
//                                 children: [
//                                   Text('نام ارگان : '),
//                                   Text(
//                                     order.title,
//                                     style: const TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//
//                               const SizedBox(height: 3),
//                               Row(
//                                 children: [
//                                   Text('شماره تماس ثابت  : '),
//                                   Text(
//                                     order.callnumber,
//                                     style: const TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 3),
//                               Row(
//                                 children: [
//                                   Text('شماره تماس همراه IT  : '),
//                                   Text(
//                                     order.phonenumberit,
//                                     style: const TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 3),
//                               Row(
//                                 children: [
//                                   Text('آدرس  : '),
//                                   Text(
//                                     order.address,
//                                     style: const TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 3),
//                               Row(
//                                 children: [
//                                   Text(' نوع سفارش : '),
//                                   Text(
//                                     order.buy,
//                                     style: const TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 3),
//                               Row(
//                                 children: [
//                                   Text(' تاریخ ثبت سفارش : '),
//                                   Text(
//                                     order.created,
//                                     style: const TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 3),
//                               Row(
//                                 children: [
//                                   Text(' تاریخ اعتبار سفارش : '),
//                                   Text(
//                                     order.datenow,
//                                     style: const TextStyle(
//                                         fontSize: 18, fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 20),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const SizedBox(height: 3),
//
//                                   SizedBox(height: 20),
//
//                                 ],
//                               ),
//                               const SizedBox(height: 16),
//                             ],
//                           ),
//
//
//
//                           SizedBox(height: 20),
//                           Text('Product A List:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//
//
//
//
//
//                           ExpansionTileBorderItem(
//                             textColor: Colors.black,
//                             border: Border.all(
//                               color: determineCollapsedBorderColor(order.listProductAa),
// // رنگ بوردر بر اساس محاسبات شما
//                               width: 4, // ضخامت بوردر
//                             ),
//                             title: Column(
//                               children: [
//                                 Text('محصولات'),
//                               ],
//                             ),
//                             children: [
//                               ExpansionTileGroup(
//                                 spaceBetweenItem: 14,
//                                 toggleType: ToggleType.expandOnlyCurrent,
//
//                                 children: order.listProductAa.map((product) =>
//
//                                     ExpansionTileBorderItem(
//                                       textColor: Colors.black,
//                                       collapsedBackgroundColor: product.unavailable
//                                           ? Colors.green[200]
//                                           : Colors.orange[200],
//                                       backgroundColor: product.unavailable
//                                           ? Colors.green[200]
//                                           : Colors.orange[200],
//
//                                       key: Key(product.id),
//
//                                       title: Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Row(
//                                                 mainAxisSize: MainAxisSize.max,
//                                                 mainAxisAlignment: MainAxisAlignment.start,
//                                                 children: [
//                                                   Card(
//                                                     child: Column(children: [
//                                                       IconButton(
//                                                         icon: const Icon(Icons.add),
//                                                         onPressed: () {
//                                                           orderController
//                                                               .fetchAllSuppliers();
//                                                           bool rezerv = false;
//
//                                                         },
//                                                       ),
//                                                     ]),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Text(product.title),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(' گارانتی :  '),
//                                               MultiSelectContainer(
//                                                 prefix: MultiSelectPrefix(
//                                                   selectedPrefix: const Padding(
//                                                     padding: EdgeInsets.only(right: 5),
//                                                     child: Icon(
//                                                       Icons.check,
//                                                       color: Colors.blue,
//                                                       size: 14,
//                                                     ),
//                                                   ),
//                                                   disabledPrefix: const Padding(
//                                                     padding: EdgeInsets.only(right: 5),
//                                                     child: Icon(
//                                                       Icons.do_disturb_alt_sharp,
//                                                       size: 14,
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 items: product.garranty.map((item) {
//                                                   return MultiSelectCard(
//                                                     value: item,
//                                                     label: item.garranty,
//                                                   );
//                                                 }).toList(),
//                                                 onChange: (allSelectedItems, selectedItem) {
// // handleSelectionChange(allSelectedItems, selectedItem);
//                                                 },
//                                               ),
//                                             ],
//                                           ),
//                                           Row(
//                                             children: [
//                                               const Text('تعداد: '),
//                                               Text(product.number),
//                                               Spacer(),
//                                               Text('عدم موجودی'),
//                                               Switch(
//                                                 value: product.unavailable,
//                                                 onChanged: (bool value) {
//                                                   if (value == true) {
//                                                     bool un = value;
//
//                                                   } else {
//                                                     showDialog(
//                                                       context: context,
//                                                       builder: (BuildContext context) {
//                                                         bool un = value;
//                                                         TextEditingController noteController =
//                                                         TextEditingController(
//                                                             text: product.description);
//                                                         return AlertDialog(
//                                                           title: const Text('توضیح محصول'),
//                                                           content: TextField(
//                                                             controller: noteController,
//                                                             maxLines: 5,
//                                                             decoration: const InputDecoration(
//                                                               border: OutlineInputBorder(),
//                                                               labelText: 'توضیحات',
//                                                             ),
//                                                           ),
//                                                           actions: [
//                                                             TextButton(
//                                                               onPressed: () {
//                                                                 Navigator.of(context).pop();
//                                                               },
//                                                               child: const Text('کنسل'),
//                                                             ),
//                                                             TextButton(
//                                                               onPressed: () {
//
//                                                                 Navigator.of(context).pop();
//                                                               },
//                                                               child: const Text('تایید'),
//                                                             ),
//                                                           ],
//                                                         );
//                                                       },
//                                                     );
//                                                   }
//                                                 },
//                                               ),
//                                             ],
//                                           ),
//                                           const SizedBox(height: 5),
//                                           Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 child: TextField(
//                                                   controller: TextEditingController(
//                                                       text: product.purchaseprice
//                                                           .convertToPrice()),
//                                                   decoration: const InputDecoration(
//                                                       labelText: 'قیمت خرید'),
//                                                   keyboardType: TextInputType.number,
//                                                   inputFormatters: [
//                                                     FilteringTextInputFormatter.allow(
//                                                         RegExp(r'[0-9۰-۹]')),
//                                                     TextInputFormatter.withFunction(
//                                                           (oldValue, newValue) {
//                                                         String newText =
//                                                         convertToEnglishNumbers(
//                                                             newValue.text);
//                                                         return TextEditingValue(
//                                                           text: newText,
//                                                           selection: TextSelection.collapsed(
//                                                               offset: newText.length),
//                                                         );
//                                                       },
//                                                     ),
//                                                   ],
//                                                   onTap: () {
//                                                     showDialog(
//                                                       context: context,
//                                                       builder: (BuildContext context) {
//                                                         return Directionality(
//                                                             textDirection: TextDirection.rtl,
//                                                             child: AlertDialog(
//                                                               title: const Text(
//                                                                   'قیمت محصول استعلام'),
//                                                               content: Container(
//                                                                   child: TextField(
//                                                                     controller:
//                                                                     TextEditingController(
//                                                                         text: product
//                                                                             .purchaseprice
//                                                                             .convertToPrice()),
//                                                                     decoration:
//                                                                     const InputDecoration(
//                                                                         labelText:
//                                                                         'قیمت خرید'),
//                                                                     keyboardType:
//                                                                     TextInputType.number,
//                                                                     inputFormatters: [
//                                                                       FilteringTextInputFormatter
//                                                                           .allow(RegExp(
//                                                                           r'[0-9۰-۹]')),
//                                                                       TextInputFormatter
//                                                                           .withFunction(
//                                                                             (oldValue,
//                                                                             newValue) {
//                                                                           String newText =
//                                                                           convertToEnglishNumbers(
//                                                                               newValue
//                                                                                   .text
//                                                                                   .convertToPrice());
//                                                                           return TextEditingValue(
//                                                                             text: newText,
//                                                                             selection: TextSelection
//                                                                                 .collapsed(
//                                                                                 offset: newText
//                                                                                     .length),
//                                                                           );
//                                                                         },
//                                                                       ),
//                                                                     ],
//
//                                                                     onChanged: (value) {
// // widget.orderController
// //     .updateProductBPricepurch(
// //     productA.id,
// //     value);
//                                                                     },
//                                                                   ),
//                                                                   width: 200),
//                                                             ));
//                                                       },
//                                                     );
//                                                   },
//                                                 ),
//                                               ),
//                                               SizedBox(width: 20),
//                                             ],
//                                           ),
//                                           const SizedBox(height: 10),
//                                           Text('قیمت به حروف : ' +
//                                               '${product.purchaseprice.toWord()} ' +
//                                               ' ریال'),
//                                           const SizedBox(height: 10),
//                                           Text('توضیحات محصول: ' + '${product.description}'),
//                                         ],
//                                       ),
//
//
//
//
//
//
//
//
// // title: Text(product.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                                       children: [
//
//
//
//
//
//
//
//                                         Card(
//                                           margin: const EdgeInsets.symmetric(
//                                               vertical: 4.0, horizontal: 16.0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
// // color: product.listbuyProduct.okbuy
// // ? Colors.green[100]
// //     : Colors.yellow[200],
// // تغییر رنگ پس‌زمینه بر اساس productB.okbuy
//                                               border: Border.all(
// // color: productB.hurry
// // ? Colors.blue
// //     : Colors.grey,
// // تغییر رنگ بوردر بر اساس productB.hurry
//                                                 width: 4, // ضخامت بوردر
//                                               ),
//                                               borderRadius:
//                                               BorderRadius.circular(8.0), // شکل گرد بوردر
//                                             ),
//                                             child: Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                 CrossAxisAlignment.stretch,
//                                                 children: [
//
//
//                                                   Row(
//                                                     children: [
//                                                       Card(
//                                                         child: Column(children: [
//                                                           IconButton(
//                                                             icon: const Icon(Icons.mode_edit),
//                                                             onPressed: () async {
// // نمایش پروگرس بار به مدت 1 ثانیه
//                                                               showDialog(
//                                                                 context: context,
//                                                                 barrierDismissible: false,
//                                                                 builder: (context) {
//                                                                   return Center(
//                                                                     child: CircularProgressIndicator(),
//                                                                   );
//                                                                 },
//                                                               );
//
//                                                             },
//                                                           ),
//                                                         ]),
//                                                       ),
//                                                       Text('${product.listbuyProduct.title} '),
//                                                     ],
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       const Text('تعداد: '),
//                                                       Text(product.listbuyProduct.number),
//                                                       Spacer(),
//
//                                                     ],
//                                                   ),
//                                                   Column(
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           const SizedBox(width: 20),
//                                                           Expanded(
//                                                             child: TextField(
//                                                               controller:
//                                                               TextEditingController(
//                                                                   text: product.listbuyProduct
//                                                                       .purchaseprice
//                                                                       .convertToPrice()),
//                                                               decoration:
//                                                               const InputDecoration(
//                                                                 border: OutlineInputBorder(),
//                                                                 labelText: 'قیمت خرید',
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Expanded(
//                                                             child: Text('\n' +
//                                                                 ' جمع مبلغ کل به حروف : ' +
//                                                                 product.purchaseprice
//                                                                     .toWord() +
//                                                                 ' ریال '),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Spacer(),
//                                                           Row(
//                                                             children: [
//                                                               Text('نوع سفارش : '),
// // Text(product.listbuyProduct.official
// // ? 'رسمی'
// //     : 'غیر رسمی'),
//
//                                                             ],
//                                                           )
//                                                         ],
//                                                       ),
//                                                       Row(
//                                                         children: [
//                                                           Text(' گارانتی :  '),
//                                                           MultiSelectContainer(
//                                                             prefix: MultiSelectPrefix(
//                                                               selectedPrefix: const Padding(
//                                                                 padding: EdgeInsets.only(right: 5),
//                                                                 child: Icon(
//                                                                   Icons.check,
//                                                                   color: Colors.blue,
//                                                                   size: 14,
//                                                                 ),
//                                                               ),
//                                                               disabledPrefix: const Padding(
//                                                                 padding: EdgeInsets.only(right: 5),
//                                                                 child: Icon(
//                                                                   Icons.do_disturb_alt_sharp,
//                                                                   size: 14,
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                             items: product. listbuyProduct.garranty.map((items) {
//                                                               return MultiSelectCard(
//                                                                 value: items,
//                                                                 label: items.garranty,
//                                                               );
//                                                             }).toList(),
//                                                             onChange: (allSelectedItems, selectedItem) {
// // handleSelectionChange(allSelectedItems, selectedItem);
//                                                             },
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       ExpansionTileBorderItem(
//                                                         title:
//                                                         Text('SN ورود و خروج به انبار', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                                                         children: [
//                                                           ...product.listbuyProduct.snBuyProductLogin.map((sn) =>
//                                                               SizedBox(child:  Center(
//                                                                 widthFactor: double.infinity,
//                                                                 child:      Card(
//
//                                                                   child:   Text('- ${sn.title} (${sn.sn})', style: TextStyle(fontSize: 16)),),),width: double.infinity,)
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//
//
//                                       ],
//                                     )
//                                 ).toList(),
//                               ),
//                             ],
//                           ),
//
//                         ],
//                       ),
//                     ),
//                   );
//
//
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   TextStyle _textStyle() {
//     return TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
//   }
//
//   Color determineCollapsedBorderColor(List<ProductAa> listProductA) {
//     // بررسی خالی بودن لیست
//     if (listProductA.isEmpty) {
//       return Colors.grey;
//     }
//
//     // بررسی محصولات برای داشتن قیمت خرید معتبر
//     for (var productA in listProductA) {
//       if (productA.purchaseprice == null ||
//           productA.purchaseprice.isEmpty ||
//           productA.purchaseprice == '0' ||
//           productA.purchaseprice == ' ' ||
//           productA.purchaseprice == 'N/A') {
//         return Colors.orange;
//       }
//     }
//
//     // اگر همه محصولات قیمت خرید معتبر داشتند، رنگ سبز برگردان
//     return Colors.green;
//   }
//
//   Widget buildStepIndicator(
//       double value, String text, String winner, String id) {
//     return Column(
//       children: [],
//     );
//   }
// //
// // Widget buildStepLabel(double value, String text) {
// //   return Column(
// //     children: [
// //       Icon(
// //         Icons.circle_notifications,
// //         color: widget._progressValue >= value ? Colors.green : Colors.grey,
// //         size: 20,
// //       ),
// //       Text(
// //         text,
// //         style: TextStyle(fontSize: 12),
// //       ),
// //     ],
// //   );
// // }
// }

// class OrderView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final OrderControllerPage orderController = Get.put(OrderControllerPage());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Order Details'),
//       ),
//       body: FutureBuilder<List<OrderNew>>(
//         future: orderController.fetchAllOrdersfesh(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
//             return Center(
//               child: Text('No orders found'),
//             );
//           } else {
//             final orders = snapshot.data!;
//
//             return ListView.builder(
//               itemCount: orders.length,
//               itemBuilder: (context, index) {
//                 final order = orders[index];
//                 return Card(
//                   margin: const EdgeInsets.all(8),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'شماره سفارش ${order.title}',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 10),
//                         Text('نام ارگان : ${order.title}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         Text('شماره تماس ثابت  : ${order.callnumber}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         Text('شماره تماس همراه IT  : ${order.phonenumberit}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         Text('آدرس  : ${order.address}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         Text(' نوع سفارش : ${order.buy}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         Text(' تاریخ ثبت سفارش : ${order.created}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         Text(' تاریخ اعتبار سفارش : ${order.datenow}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         SizedBox(height: 20),
//                         Text('Product A List:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//
//                         // نمایش محصولات ProductA
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: order.listProductAa.map((product) {
//                             return ListTile(
//                               title: Text(product.title),
//                               subtitle: Text('Number: ${product.number}, Price: ${product.purchaseprice}'),
//                             );
//                           }).toList(),
//                         ),
//
//                         SizedBox(height: 20),
//                         Text('Product B List:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//
//                         // نمایش محصولات ProductB
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: order.listProductBb.map((product) {
//                             return ListTile(
//                               title: Text(product.title),
//                             );
//                           }).toList(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

///

// class OrderView extends StatelessWidget {
//   final String orderId = 'efnec29b10bfzvs';
//
//   @override
//   Widget build(BuildContext context) {
//     final OrderControllerPage orderController = Get.put(OrderControllerPage());
//
//     // فراخوانی متد برای واکشی اطلاعات سفارش
//
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Order Details'),
//         ),
//     body: Container());
// //         body: FutureBuilder<OrderNew?>(
// //             future: orderController.fessshk(orderId),
// //             builder: (context, snapshot) {
// //               if (snapshot.connectionState == ConnectionState.waiting) {
// //                 return Center(
// //                   child: CircularProgressIndicator(),
// //                 );
// //               } else if (snapshot.hasError) {
// //                 return Center(
// //                   child: Text('Error: ${snapshot.error}'),
// //                 );
// //               } else if (!snapshot.hasData || snapshot.data == null) {
// //                 return Center(
// //                   child: Text('Order not found'),
// //                 );
// //               } else {
// //                 final order = snapshot.data!;
// //                 return
// //
// //
// //
// //
// //
// //                   Card(
// //
// //
// //                     margin: const EdgeInsets.all(8),
// //                     child: Padding(
// //                       padding: const EdgeInsets.all(16),
// //                       child: ListView(
// //
// //                         children: [
// //
// //
// //                           Row(
// //                             children: [
// //                               Row(
// //                                 children: [
// //                                   Text(
// //                                     'شماره سفارش ${order.title.toString()}',
// //                                     style: TextStyle(fontWeight: FontWeight.bold),
// //                                   )
// //                                 ],
// //                               ),
// //                               Spacer(),
// //                             ],
// //                           ),
// //                           Column(
// //                             crossAxisAlignment: CrossAxisAlignment.center,
// //                             children: [
// //
// //                               Row(
// //                                 children: [
// //                                   Text('نام ارگان : '),
// //                                   Text(
// //                                     order.title,
// //                                     style: const TextStyle(
// //                                         fontSize: 18, fontWeight: FontWeight.bold),
// //                                   ),
// //                                 ],
// //                               ),
// //
// //                               const SizedBox(height: 3),
// //                               Row(
// //                                 children: [
// //                                   Text('شماره تماس ثابت  : '),
// //                                   Text(
// //                                     order.callnumber,
// //                                     style: const TextStyle(
// //                                         fontSize: 18, fontWeight: FontWeight.bold),
// //                                   ),
// //                                 ],
// //                               ),
// //                               const SizedBox(height: 3),
// //                               Row(
// //                                 children: [
// //                                   Text('شماره تماس همراه IT  : '),
// //                                   Text(
// //                                     order.phonenumberit,
// //                                     style: const TextStyle(
// //                                         fontSize: 18, fontWeight: FontWeight.bold),
// //                                   ),
// //                                 ],
// //                               ),
// //                               const SizedBox(height: 3),
// //                               Row(
// //                                 children: [
// //                                   Text('آدرس  : '),
// //                                   Text(
// //                                     order.address,
// //                                     style: const TextStyle(
// //                                         fontSize: 18, fontWeight: FontWeight.bold),
// //                                   ),
// //                                 ],
// //                               ),
// //                               const SizedBox(height: 3),
// //                               Row(
// //                                 children: [
// //                                   Text(' نوع سفارش : '),
// //                                   Text(
// //                                     order.buy,
// //                                     style: const TextStyle(
// //                                         fontSize: 18, fontWeight: FontWeight.bold),
// //                                   ),
// //                                 ],
// //                               ),
// //                               const SizedBox(height: 3),
// //                               Row(
// //                                 children: [
// //                                   Text(' تاریخ ثبت سفارش : '),
// //                                   Text(
// //                                     order.created,
// //                                     style: const TextStyle(
// //                                         fontSize: 18, fontWeight: FontWeight.bold),
// //                                   ),
// //                                 ],
// //                               ),
// //                               const SizedBox(height: 3),
// //                               Row(
// //                                 children: [
// //                                   Text(' تاریخ اعتبار سفارش : '),
// //                                   Text(
// //                                     order.datenow,
// //                                     style: const TextStyle(
// //                                         fontSize: 18, fontWeight: FontWeight.bold),
// //                                   ),
// //                                 ],
// //                               ),
// //                               SizedBox(height: 20),
// //                               Column(
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 children: [
// //                                   const SizedBox(height: 3),
// //
// //                                   SizedBox(height: 20),
// //
// //                                 ],
// //                               ),
// //                               const SizedBox(height: 16),
// //                             ],
// //                           ),
// //
// //
// //
// //                           SizedBox(height: 20),
// //                           Text('Product A List:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
// //
// //
// //
// //
// //
// //                           ExpansionTileBorderItem(
// //                             textColor: Colors.black,
// //                             border: Border.all(
// //                               color: determineCollapsedBorderColor(order.listProductAa),
// // // رنگ بوردر بر اساس محاسبات شما
// //                               width: 4, // ضخامت بوردر
// //                             ),
// //                             title: Column(
// //                               children: [
// //                                 Text('محصولات'),
// //                               ],
// //                             ),
// //                             children: [
// //                               ExpansionTileGroup(
// //                                 spaceBetweenItem: 14,
// //                                 toggleType: ToggleType.expandOnlyCurrent,
// //
// //                                 children: order.listProductAa.map((product) =>
// //
// //                                     ExpansionTileBorderItem(
// //                                       textColor: Colors.black,
// //                                       collapsedBackgroundColor: product.unavailable
// //                                           ? Colors.green[200]
// //                                           : Colors.orange[200],
// //                                       backgroundColor: product.unavailable
// //                                           ? Colors.green[200]
// //                                           : Colors.orange[200],
// //
// //                                       key: Key(product.id),
// //
// //                                       title: Column(
// //                                         crossAxisAlignment: CrossAxisAlignment.start,
// //                                         children: [
// //                                           Row(
// //                                             children: [
// //                                               Row(
// //                                                 mainAxisSize: MainAxisSize.max,
// //                                                 mainAxisAlignment: MainAxisAlignment.start,
// //                                                 children: [
// //                                                   Card(
// //                                                     child: Column(children: [
// //                                                       IconButton(
// //                                                         icon: const Icon(Icons.add),
// //                                                         onPressed: () {
// //                                                           orderController
// //                                                               .fetchAllSuppliers();
// //                                                           bool rezerv = false;
// //
// //                                                         },
// //                                                       ),
// //                                                     ]),
// //                                                   ),
// //                                                 ],
// //                                               ),
// //                                               Text(product.title),
// //                                             ],
// //                                           ),
// //                                           Row(
// //                                             children: [
// //                                               Text(' گارانتی :  '),
// //                                               MultiSelectContainer(
// //                                                 prefix: MultiSelectPrefix(
// //                                                   selectedPrefix: const Padding(
// //                                                     padding: EdgeInsets.only(right: 5),
// //                                                     child: Icon(
// //                                                       Icons.check,
// //                                                       color: Colors.blue,
// //                                                       size: 14,
// //                                                     ),
// //                                                   ),
// //                                                   disabledPrefix: const Padding(
// //                                                     padding: EdgeInsets.only(right: 5),
// //                                                     child: Icon(
// //                                                       Icons.do_disturb_alt_sharp,
// //                                                       size: 14,
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                                 items: product.garranty.map((item) {
// //                                                   return MultiSelectCard(
// //                                                     value: item,
// //                                                     label: item.garranty,
// //                                                   );
// //                                                 }).toList(),
// //                                                 onChange: (allSelectedItems, selectedItem) {
// // // handleSelectionChange(allSelectedItems, selectedItem);
// //                                                 },
// //                                               ),
// //                                             ],
// //                                           ),
// //                                           Row(
// //                                             children: [
// //                                               const Text('تعداد: '),
// //                                               Text(product.number),
// //                                               Spacer(),
// //                                               Text('عدم موجودی'),
// //                                               Switch(
// //                                                 value: product.unavailable,
// //                                                 onChanged: (bool value) {
// //                                                   if (value == true) {
// //                                                     bool un = value;
// //
// //                                                   } else {
// //                                                     showDialog(
// //                                                       context: context,
// //                                                       builder: (BuildContext context) {
// //                                                         bool un = value;
// //                                                         TextEditingController noteController =
// //                                                         TextEditingController(
// //                                                             text: product.description);
// //                                                         return AlertDialog(
// //                                                           title: const Text('توضیح محصول'),
// //                                                           content: TextField(
// //                                                             controller: noteController,
// //                                                             maxLines: 5,
// //                                                             decoration: const InputDecoration(
// //                                                               border: OutlineInputBorder(),
// //                                                               labelText: 'توضیحات',
// //                                                             ),
// //                                                           ),
// //                                                           actions: [
// //                                                             TextButton(
// //                                                               onPressed: () {
// //                                                                 Navigator.of(context).pop();
// //                                                               },
// //                                                               child: const Text('کنسل'),
// //                                                             ),
// //                                                             TextButton(
// //                                                               onPressed: () {
// //
// //                                                                 Navigator.of(context).pop();
// //                                                               },
// //                                                               child: const Text('تایید'),
// //                                                             ),
// //                                                           ],
// //                                                         );
// //                                                       },
// //                                                     );
// //                                                   }
// //                                                 },
// //                                               ),
// //                                             ],
// //                                           ),
// //                                           const SizedBox(height: 5),
// //                                           Row(
// //                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                                             children: [
// //                                               Expanded(
// //                                                 child: TextField(
// //                                                   controller: TextEditingController(
// //                                                       text: product.purchaseprice
// //                                                           .convertToPrice()),
// //                                                   decoration: const InputDecoration(
// //                                                       labelText: 'قیمت خرید'),
// //                                                   keyboardType: TextInputType.number,
// //                                                   inputFormatters: [
// //                                                     FilteringTextInputFormatter.allow(
// //                                                         RegExp(r'[0-9۰-۹]')),
// //                                                     TextInputFormatter.withFunction(
// //                                                           (oldValue, newValue) {
// //                                                         String newText =
// //                                                         convertToEnglishNumbers(
// //                                                             newValue.text);
// //                                                         return TextEditingValue(
// //                                                           text: newText,
// //                                                           selection: TextSelection.collapsed(
// //                                                               offset: newText.length),
// //                                                         );
// //                                                       },
// //                                                     ),
// //                                                   ],
// //                                                   onTap: () {
// //                                                     showDialog(
// //                                                       context: context,
// //                                                       builder: (BuildContext context) {
// //                                                         return Directionality(
// //                                                             textDirection: TextDirection.rtl,
// //                                                             child: AlertDialog(
// //                                                               title: const Text(
// //                                                                   'قیمت محصول استعلام'),
// //                                                               content: Container(
// //                                                                   child: TextField(
// //                                                                     controller:
// //                                                                     TextEditingController(
// //                                                                         text: product
// //                                                                             .purchaseprice
// //                                                                             .convertToPrice()),
// //                                                                     decoration:
// //                                                                     const InputDecoration(
// //                                                                         labelText:
// //                                                                         'قیمت خرید'),
// //                                                                     keyboardType:
// //                                                                     TextInputType.number,
// //                                                                     inputFormatters: [
// //                                                                       FilteringTextInputFormatter
// //                                                                           .allow(RegExp(
// //                                                                           r'[0-9۰-۹]')),
// //                                                                       TextInputFormatter
// //                                                                           .withFunction(
// //                                                                             (oldValue,
// //                                                                             newValue) {
// //                                                                           String newText =
// //                                                                           convertToEnglishNumbers(
// //                                                                               newValue
// //                                                                                   .text
// //                                                                                   .convertToPrice());
// //                                                                           return TextEditingValue(
// //                                                                             text: newText,
// //                                                                             selection: TextSelection
// //                                                                                 .collapsed(
// //                                                                                 offset: newText
// //                                                                                     .length),
// //                                                                           );
// //                                                                         },
// //                                                                       ),
// //                                                                     ],
// //
// //                                                                     onChanged: (value) {
// // // widget.orderController
// // //     .updateProductBPricepurch(
// // //     productA.id,
// // //     value);
// //                                                                     },
// //                                                                   ),
// //                                                                   width: 200),
// //                                                             ));
// //                                                       },
// //                                                     );
// //                                                   },
// //                                                 ),
// //                                               ),
// //                                               SizedBox(width: 20),
// //                                             ],
// //                                           ),
// //                                           const SizedBox(height: 10),
// //                                           Text('قیمت به حروف : ' +
// //                                               '${product.purchaseprice.toWord()} ' +
// //                                               ' ریال'),
// //                                           const SizedBox(height: 10),
// //                                           Text('توضیحات محصول: ' + '${product.description}'),
// //                                         ],
// //                                       ),
// //
// //
// //
// //
// //
// //
// //
// //
// // // title: Text(product.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// //                                       children: [
// //
// //
// //
// //
// //
// //
// //
// //                                         Card(
// //                                           margin: const EdgeInsets.symmetric(
// //                                               vertical: 4.0, horizontal: 16.0),
// //                                           child: Container(
// //                                             decoration: BoxDecoration(
// // // color: product.listbuyProduct.okbuy
// // // ? Colors.green[100]
// // //     : Colors.yellow[200],
// // // تغییر رنگ پس‌زمینه بر اساس productB.okbuy
// //                                               border: Border.all(
// // // color: productB.hurry
// // // ? Colors.blue
// // //     : Colors.grey,
// // // تغییر رنگ بوردر بر اساس productB.hurry
// //                                                 width: 4, // ضخامت بوردر
// //                                               ),
// //                                               borderRadius:
// //                                               BorderRadius.circular(8.0), // شکل گرد بوردر
// //                                             ),
// //                                             child: Padding(
// //                                               padding: const EdgeInsets.all(8.0),
// //                                               child: Column(
// //                                                 crossAxisAlignment:
// //                                                 CrossAxisAlignment.stretch,
// //                                                 children: [
// //
// //
// //                                                   Row(
// //                                                     children: [
// //                                                       Card(
// //                                                         child: Column(children: [
// //                                                           IconButton(
// //                                                             icon: const Icon(Icons.mode_edit),
// //                                                             onPressed: () async {
// // // نمایش پروگرس بار به مدت 1 ثانیه
// //                                                               showDialog(
// //                                                                 context: context,
// //                                                                 barrierDismissible: false,
// //                                                                 builder: (context) {
// //                                                                   return Center(
// //                                                                     child: CircularProgressIndicator(),
// //                                                                   );
// //                                                                 },
// //                                                               );
// //
// //                                                             },
// //                                                           ),
// //                                                         ]),
// //                                                       ),
// //                                                       Text('${product.listbuyProduct.title} '),
// //                                                     ],
// //                                                   ),
// //                                                   Row(
// //                                                     children: [
// //                                                       const Text('تعداد: '),
// //                                                       Text(product.listbuyProduct.number),
// //                                                       Spacer(),
// //
// //                                                     ],
// //                                                   ),
// //                                                   Column(
// //                                                     children: [
// //                                                       Row(
// //                                                         children: [
// //                                                           const SizedBox(width: 20),
// //                                                           Expanded(
// //                                                             child: TextField(
// //                                                               controller:
// //                                                               TextEditingController(
// //                                                                   text: product.listbuyProduct
// //                                                                       .purchaseprice
// //                                                                       .convertToPrice()),
// //                                                               decoration:
// //                                                               const InputDecoration(
// //                                                                 border: OutlineInputBorder(),
// //                                                                 labelText: 'قیمت خرید',
// //                                                               ),
// //                                                             ),
// //                                                           ),
// //                                                         ],
// //                                                       ),
// //                                                       Row(
// //                                                         children: [
// //                                                           Expanded(
// //                                                             child: Text('\n' +
// //                                                                 ' جمع مبلغ کل به حروف : ' +
// //                                                                 product.purchaseprice
// //                                                                     .toWord() +
// //                                                                 ' ریال '),
// //                                                           ),
// //                                                         ],
// //                                                       ),
// //                                                       Row(
// //                                                         children: [
// //                                                           Spacer(),
// //                                                           Row(
// //                                                             children: [
// //                                                               Text('نوع سفارش : '),
// // // Text(product.listbuyProduct.official
// // // ? 'رسمی'
// // //     : 'غیر رسمی'),
// //
// //                                                             ],
// //                                                           )
// //                                                         ],
// //                                                       ),
// //                                                       Row(
// //                                                         children: [
// //                                                           Text(' گارانتی :  '),
// //                                                           MultiSelectContainer(
// //                                                             prefix: MultiSelectPrefix(
// //                                                               selectedPrefix: const Padding(
// //                                                                 padding: EdgeInsets.only(right: 5),
// //                                                                 child: Icon(
// //                                                                   Icons.check,
// //                                                                   color: Colors.blue,
// //                                                                   size: 14,
// //                                                                 ),
// //                                                               ),
// //                                                               disabledPrefix: const Padding(
// //                                                                 padding: EdgeInsets.only(right: 5),
// //                                                                 child: Icon(
// //                                                                   Icons.do_disturb_alt_sharp,
// //                                                                   size: 14,
// //                                                                 ),
// //                                                               ),
// //                                                             ),
// //                                                             items: product. listbuyProduct.garranty.map((items) {
// //                                                               return MultiSelectCard(
// //                                                                 value: items,
// //                                                                 label: items.garranty,
// //                                                               );
// //                                                             }).toList(),
// //                                                             onChange: (allSelectedItems, selectedItem) {
// // // handleSelectionChange(allSelectedItems, selectedItem);
// //                                                             },
// //                                                           ),
// //                                                         ],
// //                                                       ),
// //                                                       ExpansionTileBorderItem(
// //                                                         title:
// //                                                         Text('SN ورود و خروج به انبار', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
// //                                                         children: [
// //                                                           ...product.listbuyProduct.snBuyProductLogin.map((sn) =>
// //                                                               SizedBox(child:  Center(
// //                                                                 widthFactor: double.infinity,
// //                                                                 child:      Card(
// //
// //                                                                   child:   Text('- ${sn.title} (${sn.sn})', style: TextStyle(fontSize: 16)),),),width: double.infinity,)
// //                                                           ),
// //                                                         ],
// //                                                       ),
// //                                                     ],
// //                                                   ),
// //                                                 ],
// //                                               ),
// //                                             ),
// //                                           ),
// //                                         ),
// //
// //
// //                                       ],
// //                                     )
// //                                 ).toList(),
// //                               ),
// //                             ],
// //                           ),
// //
// //                         ],
// //                       ),
// //                     ),
// //                   );
// //
// //
// //
// //
// //               }
// //             }));
//   }
//
//   TextStyle _textStyle() {
//     return TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
//   }
//
//   Color determineCollapsedBorderColor(List<ProductAa> listProductA) {
//     // بررسی خالی بودن لیست
//     if (listProductA.isEmpty) {
//       return Colors.grey;
//     }
//
//     // بررسی محصولات برای داشتن قیمت خرید معتبر
//     for (var productA in listProductA) {
//       if (productA.purchaseprice == null ||
//           productA.purchaseprice.isEmpty ||
//           productA.purchaseprice == '0' ||
//           productA.purchaseprice == ' ' ||
//           productA.purchaseprice == 'N/A') {
//         return Colors.orange;
//       }
//     }
//
//     // اگر همه محصولات قیمت خرید معتبر داشتند، رنگ سبز برگردان
//     return Colors.green;
//   }
//
//   Widget buildStepIndicator(
//       double value, String text, String winner, String id) {
//     return Column(
//       children: [],
//     );
//   }
//
// // Widget buildStepLabel(double value, String text) {
// //   return Column(
// //     children: [
// //       Icon(
// //         Icons.circle_notifications,
// //         color: widget._progressValue >= value ? Colors.green : Colors.grey,
// //         size: 20,
// //       ),
// //       Text(
// //         text,
// //         style: TextStyle(fontSize: 12),
// //       ),
// //     ],
// //   );
// // }
// }


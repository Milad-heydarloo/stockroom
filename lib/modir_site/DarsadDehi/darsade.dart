import 'dart:async';
import 'dart:js_util';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/Get_X/Model/listproducta.dart';
import 'package:project/Get_X/Model/order.dart';
import 'package:project/modir_site/invoice/app.dart';
import 'package:project/modir_site/invoice/appBedoneh.dart';
import 'package:project/modir_site/invoice/appGaranty.dart';
import 'package:project/modir_site/invoice/appGarantyBedoneh.dart';
import 'package:project/modir_site/Block/tech_bloc.dart';
import 'package:project/modir_site/Block/tech_event.dart';
import 'package:project/modir_site/Block/tech_state.dart';
import 'package:project/utiliti/double_extenstions.dart';
import 'package:provider/provider.dart';

import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

class MyStatefulPage extends StatefulWidget {
  final List<ProductAtwo> listProductA;
  final OrderTwo order;

  const MyStatefulPage({required this.listProductA, required this.order});

  @override
  _MyStatefulPageState createState() => _MyStatefulPageState();
}

class _MyStatefulPageState extends State<MyStatefulPage> {
// تابع فرمت ارز

  double get _total => refreshlist
      .map<double>(
          (p) => multiply(double.parse(p.salePrice!), double.parse(p.number!)))
      .reduce((a, b) => add(a, b));

  // محاسبه مجموع کل به همراه مالیات
  double get _grandTotal => multiply(_total, 1.1);

  // محاسبه مقدار مالیات
  double get _taxAmount => subtract(_grandTotal, _total);

// کد فرمت مقادیر به صورت ارز برای نمایش
  String get formattedTotal => _total.toString().convertToPrice();

  String get formattedTaxAmount => _taxAmount.toString().convertToPrice();

  String get formattedGrandTotal => _grandTotal.toString().convertToPrice();

  late double totalPrice;
  late double totalPriceWithTax;
  final TextEditingController _percentController = TextEditingController();

  Timer? _debounce;

  late List<ProductAtwo> refreshlist;

  @override
  void initState() {
    super.initState();
    refreshlist = List.from(widget.listProductA);
    print('biiiiii');
    print(formattedTotal);
    print(formattedTaxAmount);
    print(formattedGrandTotal);
    _updatePrices();
  }

  void _updatePrices() {
    setState(() {
      _total;
      _grandTotal;
      _taxAmount;
    });
  }

  Future<void> _calculateSalePrice(
      TextEditingController percentController,
      TextEditingController priceController,
      double purchasePrice,
      int index,
      BuildContext context) async {
    print('qwqwqwqw');
    print('${_percentController}');
    print('${priceController}');
    print('${purchasePrice}');
    double? percent = double.tryParse(percentController.text);

    // استفاده از کتابخانه maths برای محاسبات
    double salePrice =
        add(purchasePrice, multiply(purchasePrice, divide(percent, 100)));

    // await Provider.of<PocketBaseProvider>(context, listen: false)
    //     .updateOrderDarsad_saleprice(widget.listProductA[index].id,
    //         salePrice.toString(), percentController.text);
    BlocProvider.of<OrderBloc>(context).add(UpdateAllPriceAndDarsad(
        refreshlist[index].id!,
        salePrice.toString(),
        percentController.text));
    priceController.text = salePrice.toString();

    setState(() {
      refreshlist[index] = ProductAtwo(
        id: refreshlist[index].id,
        title: refreshlist[index].title,
        percent: percentController.text,
        salePrice: salePrice.toString(),
        purchasePrice: refreshlist[index].purchasePrice,
        garranty: refreshlist[index].garranty,
        number: refreshlist[index].number,
        unavailable: refreshlist[index].unavailable,
        description: 'Updated',
      );

      _updatePrices();
    });
  }

  Future<void> _updateAllSalePrices(BuildContext contextBloc) async {
    final percentText = _percentController.text;

    final double percent = double.tryParse(percentText) ?? 0.0;
    for (int index = 0; index < refreshlist.length; index++) {
      final product = refreshlist[index];
      final double purchasePrice =
          double.parse(parsePrice(product.purchasePrice!));
      final double salePrice = purchasePrice + (purchasePrice * percent / 100);

      // await Provider.of<PocketBaseProvider>(context, listen: false)
      //     .updateOrderDarsad_saleprice(
      //         product.id, salePrice.toString(), percentText);
      BlocProvider.of<OrderBloc>(contextBloc).add(UpdateAllPriceAndDarsad(
          product.id!, salePrice.toString(), percentText));
      setState(() {
        refreshlist[index] = ProductAtwo(
          id: product.id,
          title: product.title,
          percent: percentText,
          salePrice: salePrice.toString(),
          purchasePrice: product.purchasePrice,
          garranty: product.garranty,
          number: product.number,
          unavailable: product.unavailable,
          description: 'Updated',
        );
      });
    }

    _updatePrices();
  }

  Future<void> _updateManualSalePrice(
      int index, String newSalePrice, BuildContext context) async {
    final product = refreshlist[index];
    // await Provider.of<PocketBaseProvider>(context, listen: false)
    //     .updateOrderSaleprice_productA(product.id, newSalePrice);
    BlocProvider.of<OrderBloc>(context)
        .add(UpdatePriceAndDarsad(product.id!, newSalePrice.toString()));
    setState(() {
      refreshlist[index] = ProductAtwo(
        id: product.id,
        title: product.title,
        percent: product.percent,
        salePrice: newSalePrice,
        purchasePrice: product.purchasePrice,
        garranty: product.garranty,
        number: product.number,
        unavailable: product.unavailable,
        description: 'Updated',
      );
      _updatePrices();
    });
  }
@override
  void dispose() {
    // TODO: implement dispose
  refreshlist.clear();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('لیست محصولات'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: ()  {
              context.read<OrderBloc>().add(FetchOrders());
              Navigator.pop(context);
            },
          ),

        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: BlocProvider.value(
            value: BlocProvider.of<OrderBloc>(context),
            child: BlocListener<OrderBloc, OrderState>(
              listener: (context, state) {},
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 4,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text('جمع مبلغ کل',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 8),
                                Text(

                                    //         '${totalPrice.toString().convertToPrice()} تومان',
                                    '${formattedTotal} ریال ',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                        // Card(
                        //   elevation: 4,
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width / 2.5,
                        //     padding: const EdgeInsets.all(16),
                        //     child: Column(
                        //       children: [
                        //         Text('جمع مبلغ کل با ۱۰٪ ارزش افزوده',
                        //             style: TextStyle(
                        //                 fontSize: 16, fontWeight: FontWeight.bold)),
                        //         SizedBox(height: 8),
                        //         Text(
                        //           //   '${totalPriceWithTax.toString().convertToPrice()} تومان',
                        //             '${formattedGrandTotal} تومان',
                        //             style: TextStyle(fontSize: 16)),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add print functionality here

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Center(child: Text('پرینت سفارش')),
                                  content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.all(12.0)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              )),
                                            ),
                                            child: Text('پرینت با ارزش افزوده',
                                                textAlign: TextAlign.center),
                                            onPressed: () {
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          MyApp_invoce(
                                                    us: widget.order,listprodut: refreshlist,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.blue),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.all(12.0)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              )),
                                            ),
                                            child: Text(
                                                'پرینت بدون ارزش افزوده',
                                                textAlign: TextAlign.center),
                                            onPressed: () {
                                              // Do something when the button is pressed
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          MyApp_invoceBedoneh(
                                                    us: widget.order,listProduct: refreshlist,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.orange),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.all(12.0)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              )),
                                            ),
                                            child: Text(
                                                'پرینت با گارانتی و بدون ارزش افزوده',
                                                textAlign: TextAlign.center),
                                            onPressed: () {
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder: (BuildContext
                                                          context) =>
                                                      MyApp_invoceGarantyBedoneh(
                                                    us: widget.order,listmahso: refreshlist,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.red),
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.all(12.0)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              )),
                                            ),
                                            child: Text(
                                                'پرینت با گارانتی و با ارزش افزوده',
                                                textAlign: TextAlign.center),
                                            onPressed: () {
                                              Navigator.push<void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          MyApp_invoceGaranty(
                                                    us: widget.order,listemahsolat: refreshlist,

                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ]),
                                  actions: <Widget>[],
                                );
                              },
                            );
                          },
                          child: Text('پرینت'),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _percentController,
                            decoration:
                                const InputDecoration(labelText: 'درصد'),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'-?[0-9۰-۹.]*')),
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
                          ),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            _updateAllSalePrices(context);
                          },
                          child: Text('ست'),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: refreshlist.length,
                      itemBuilder: (context, index) {
                        final product = refreshlist[index];
                        final TextEditingController percentController =
                            TextEditingController(text: product.percent);
                        final TextEditingController priceController =
                            TextEditingController(
                                text: product.salePrice!.convertToPrice());

                        return Card(
                          color: Colors.grey[100],
                          margin: EdgeInsets.all(19),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(product.title!),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        setState(() {
                                          refreshlist.removeAt(index);
                                          _updatePrices();
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(' گارانتی :  '),
                                    MultiSelectContainer(
                                      prefix: MultiSelectPrefix(
                                        selectedPrefix: const Padding(
                                          padding: EdgeInsets.only(right: 5),
                                          child: Icon(
                                            Icons.check,
                                            color: Colors.blue,
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
                                      items: product.garranty!.map((item) {
                                        return MultiSelectCard(
                                          value: item,
                                          label: item,
                                        );
                                      }).toList(),
                                      onChange:
                                          (allSelectedItems, selectedItem) {
                                        // handleSelectionChange(allSelectedItems, selectedItem);
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('تعداد: '),
                                    Text(product.number!),
                                    Spacer(),
                                    Text('عدم موجودی'),
                                    Switch(
                                      value: product.unavailable!,
                                      onChanged: (bool value) {
                                        setState(() {
                                          product.unavailable = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Center(
                                        child: Text('قیمت خرید ' +
                                            product.purchasePrice!
                                                .convertToPrice()),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: TextField(
                                        controller: percentController,
                                        decoration: const InputDecoration(
                                            labelText: 'درصد'),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'-?[0-9۰-۹.]*')),
                                          TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                              String newText =
                                                  convertToEnglishNumbers(
                                                      newValue.text);
                                              return TextEditingValue(
                                                text: newText,
                                                selection:
                                                    TextSelection.collapsed(
                                                        offset: newText.length),
                                              );
                                            },
                                          ),
                                        ],
                                        onChanged: (value) {
                                          if (_debounce?.isActive ?? false)
                                            _debounce?.cancel();
                                          _debounce = Timer(
                                              const Duration(seconds: 1), () {
                                            print('qwqwqwqw');
                                            print('${percentController.text}');
                                            print('${priceController.text}');
                                            print(
                                                '${double.parse(parsePrice(product.purchasePrice!))}');
                                            _calculateSalePrice(
                                                percentController,
                                                priceController,
                                                double.parse(parsePrice(
                                                    product.purchasePrice!)),
                                                index,
                                                context);
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: TextField(
                                        controller: priceController,
                                        decoration: const InputDecoration(
                                            labelText: 'قیمت فروش'),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9۰-۹]')),
                                          TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                              String newText =
                                                  convertToEnglishNumbers(
                                                      newValue.text);
                                              return TextEditingValue(
                                                text: newText,
                                                selection:
                                                    TextSelection.collapsed(
                                                        offset: newText.length),
                                              );
                                            },
                                          ),
                                        ],
                                        onChanged: (value) {
                                          if (_debounce?.isActive ?? false)
                                            _debounce?.cancel();
                                          _debounce = Timer(
                                              const Duration(seconds: 2), () {
                                            _updateManualSalePrice(index,
                                                parsePrice(value), context);
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

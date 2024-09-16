import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:project/Get_X/Model/listproducta.dart';
import 'package:project/Get_X/Model/order.dart';


import 'examples/invoiceGarantyBedoneh.dart';


class MyApp_invoceGarantyBedoneh extends StatefulWidget {
  OrderTwo? us;
List<ProductAtwo> listmahso;
  MyApp_invoceGarantyBedoneh({Key? key, required this.us,required this.listmahso}) : super(key: key);

  @override
  MyApp_invoceState createState() {
    return MyApp_invoceState();
  }
}

class MyApp_invoceState extends State<MyApp_invoceGarantyBedoneh>
    with SingleTickerProviderStateMixin {
  int _counter = 1;
  int _tab = 0;
  DateTime now = DateTime.now();

  // فرمت دهی تاریخ و ساعت
  String? formattedDate ;
  String? formattedTime ;
  // late TabController _tabController;
  late PrintingInfo printingInfo;

  late List<ProductInvoGarantyBedoneh> products;

  @override
  void initState() {
    super.initState();
products=[];
    _init();
    _getProductOrderData(widget.us!.niyaz!);
  }

  Future<void> _init() async {
    // await GoogleSheetsControllerproductorder.init();

    final info = await Printing.info();

    // _tabController = TabController(
    //   vsync: this,
    //   length: examples.length,
    //   initialIndex: _tab,
    // );
    // _tabController.addListener(() {
    //   if (_tab != _tabController.index) {
    //     setState(() {
    //       _tab = _tabController.index;
    //     });
    //   }
    // });

    setState(() {
      printingInfo = info;
    });
  }

  void _getProductOrderData(String numbersforoshande) async {
  //  await GoogleSheetsControllerproductorder.init();
  //  final users = await GoogleSheetsControllerproductorder.getAllproductorder();

    //final filteredUsers =
   // users.where((user) => user.idorder == numbersforoshande).toList();
    print('start');
   // print(filteredUsers.length);




    products = widget.listmahso!.map((user) {
      final product = ProductInvoGarantyBedoneh(
        _counter.toString(),
        user.title!,
        double.parse(user.salePrice!),
        int.parse(user.number!),
        user.garranty!
      );
      _counter++;

      return product;
    }).toList();


    for (var s in products) {
      print(s.productName+s.price.toString());
    }
  }

  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }

  Future<void> _saveAsFile(BuildContext context,
      LayoutCallback build,
      PdfPageFormat pageFormat,) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;

    final file = File('$appDocPath/document.pdf');
    print('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    await OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;

    // if (_tabController == null) {
    //   return const Center(child: CircularProgressIndicator());
    // }

    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        PdfPreviewAction(
          icon: const Icon(Icons.save),
          onPressed: _saveAsFile,
        )
    ];

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.blue,
        title: const Text('پرنت سفارش'),
      ),
      body: PdfPreview(
        maxPageWidth: 700,
        build: (format) {
          Completer<Uint8List> completer = Completer<
              Uint8List>(); // ایجاد یک Completer برای منتظر ماندن مکث

          // استفاده از Future.delayed برای ایجاد مکث
          Future.delayed(Duration(seconds: 3), () {
            Future<Uint8List> result = generateInvoiceGarantyBedoneh(

                format ,products ,widget.us!);
            completer.complete(
                result); // بازگرداندن مقدار مورد نظر به عنوان خروجی Completer
          });

          return completer
              .future; // بازگرداندن آینده Completer به عنوان خروجی تابع build
        },
        actions: actions,
        canDebug: false,
        enableScrollToPage: true,



        pdfFileName: widget.us!.title!+' شماره نیاز__'+widget.us!.niyaz!,
        actionBarTheme: PdfActionBarTheme(backgroundColor: Colors.blue,iconColor: Colors.white, elevation: 4.0),
        onPrinted: _showPrintedToast,
        onShared: _showSharedToast,
      ),
    );
  }

  DateFormat(String s) {}
}

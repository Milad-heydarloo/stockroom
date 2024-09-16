import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:project/Get_X/Model/order.dart';



Future<Uint8List> generateInvoiceGarantyBedoneh(
  PdfPageFormat pageFormat,
  List<ProductInvoGarantyBedoneh> products,
  OrderTwo us,
) async {
  //  print('aaaaaaaaaaaa'+products.toString());

  final invoice = Invoice(
    invoiceNumber: '${us.niyaz}',
    products: products,
    customerName: '${us.title}',
    customerAddress: '${us.address}',
    paymentInfo: ' نشانی کامل:تهران خیابان انقلاب روبروی پارک دانشجو' +
        '\n' +
        ' پلاک 7 برج ابن سینا طبقه همکف ' +
        '\n' +
        ' شماره تلفن - نمابر:  910118550-021 / 09123152167 ' +
        '\n',
    // ' نام شرکت : رهپویان توسعه تجارت ساتر '+
    // '\n' +
    // ' شماره حساب : 9872355736 '
    //     '\n' +
    // ' شماره کارت : 6104-3386-4522-1108 '
    //     '\n' +
    // ' شبا : IR24-0120-0200-0000-9872-3557-36 ',
    tax: .10,
    baseColor: PdfColors.teal,
    accentColor: PdfColors.blueGrey900,
  );

  return await invoice.buildPdf(pageFormat, us);
}
//
// final productss = <ProductInvo>[
//   ProductInvo('1', 'مادربرد ایسوس مدل PRIME Z690-P D4 سوکت 1700', 100000000000, 2),
//   ProductInvo('2', 'مادربرد ایسوس مدل PRIME Z690-P D4 سوکت 1700', 100000000000, 2),
//   ProductInvo('3', 'مادربرد ایسوس مدل PRIME Z690-P D4 سوکت 1700', 100000000000, 2),
//   ProductInvo('4', 'مادربرد ایسوس مدل PRIME Z690-P D4 سوکت 1700', 100000000000, 2),
//   ProductInvo('5', 'مادربرد ایسوس مدل PRIME Z690-P D4 سوکت 1700', 100000000000, 2),
//   Product('6', 'مادربرد ایسوس مدل PRIME Z690-P D4 سوکت 1700', 100000000000, 2),
//   Product('7', 'مادربرد ایسوس مدل PRIME Z690-P D4 سوکت 1700', 100000000000, 2),
//   Product('8', 'مادربرد ایسوس مدل PRIME Z690-P D4 سوکت 1700', 100000000000, 2),
//   Product('9', 'مادربرد ایسوس مدل PRIME Z690-P D4 سوکت 1700', 100000000000, 2),
//   Product('10', 'مادربرد ایسوس مدل PRIME Z690-P D4 سوکت 1700', 100000000000, 2),
//   Product('11', 'مادربرد ایسوس مدل PRIME Z690-P D4 سوکت 1700', 100000000000, 2),
//   Product('12', 'مادربرد ایسوس مدل PRIME Z690-P D4 سوکت 1700', 100000000000, 2),
// ];

// تعریف محلی برای متغیر productorder
//List<Product> productorder = [];

class Invoice {
  Invoice({
    required this.products,
    required this.customerName,
    required this.customerAddress,
    required this.invoiceNumber,
    required this.tax,
    required this.paymentInfo,
    required this.baseColor,
    required this.accentColor,
  });

  final List<ProductInvoGarantyBedoneh> products;
  final String customerName;
  final String customerAddress;
  final String invoiceNumber;
  final double tax;
  final String paymentInfo;
  final PdfColor baseColor;
  final PdfColor accentColor;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  PdfColor get _baseTextColor => baseColor.isLight ? _lightColor : _darkColor;

  PdfColor get _accentTextColor => baseColor.isLight ? _lightColor : _darkColor;

  double get _total =>
      products.map<double>((p) => p.total).reduce((a, b) => a + b);

  double get _grandTotal => _total * (1 + tax);

  double get _show => _grandTotal - _total;

  String? _logo;
  String? _mohr;

  String? _bgShape;

  Future<Uint8List> buildPdf(
    PdfPageFormat pageFormat,
    OrderTwo us,
  ) async {
    // Create a PDF document.
    final doc = pw.Document();
    final NumberFormat formatter = NumberFormat("#,###");
    final Jalali jalaliNow = Jalali.now();
    final String formattedDate =
        '${jalaliNow.formatter.yyyy}-${jalaliNow.formatter.mm}-${jalaliNow.formatter.dd}';

    var font = Font.ttf(await rootBundle.load('fonts/dm.ttf'));
    _logo = await rootBundle.loadString('assets/sattersvg.svg');
    _bgShape = await rootBundle.loadString('assets/invoice.svg');
    _mohr = await rootBundle.loadString('assets/mohrsv.svg');

    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(pageFormat, font, font, font),
        header: (context) => _buildHeader(context, font, formattedDate),
        footer: (context) => _buildFooter(context, font),
        build: (context) => [
          _contentHeader(context, font, us),
          _contentTable(context, font, formatter),
          pw.SizedBox(height: 20),
          _contentFooter(context, font),
          pw.SizedBox(height: 20),
          //  _termsAndConditions(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.Widget _buildHeader(
      pw.Context context, pw.Font font, String formattedDate) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.max,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topLeft,
                    padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                    height: 72,
                    child:
                        _logo != null ? pw.SvgImage(svg: _logo!) : pw.PdfLogo(),
                  ),
                  // pw.Container(
                  //   color: baseColor,
                  //   padding: pw.EdgeInsets.only(top: 3),
                  // ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                      height: 50,
                      padding: const pw.EdgeInsets.only(left: 17),
                      alignment: pw.Alignment.center,
                      child: pw.Directionality(
                          child: Text(' پیش فاکتور فروش کالا و خدمات',
                              textScaleFactor: 2,
                              style: pw.TextStyle(
                                font: font,
                                fontWeight: pw.FontWeight.bold,
                                fontSize: 7,
                              )),
                          textDirection: pw.TextDirection.rtl)),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius:
                          const pw.BorderRadius.all(pw.Radius.circular(2)),
                      color: accentColor,
                    ),
                    padding: const pw.EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 10),
                    alignment: pw.Alignment.centerRight,
                    height: 40,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: pw.Row(
                        children: [
                          pw.Directionality(
                              child: Text(formattedDate,
                                  style: pw.TextStyle(
                                    fontSize: 9,
                                  )),
                              textDirection: pw.TextDirection.rtl),
                          pw.Directionality(
                              child: Text('تاریخ : ',
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: 9,
                                  )),
                              textDirection: pw.TextDirection.rtl),
                          pw.Spacer(),
                          pw.Directionality(
                              child: Text(invoiceNumber,
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: 9,
                                  )),
                              textDirection: pw.TextDirection.rtl),
                          pw.Directionality(
                              child: Text('شماره نیاز : ',
                                  style: pw.TextStyle(
                                    font: font,
                                    fontSize: 9,
                                  )),
                              textDirection: pw.TextDirection.rtl),

                          // pw.Text('تاریخ : '),
                          // pw.Text(_formatDate(DateTime.now())),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.Widget _buildFooter(pw.Context context, pw.Font font) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Container(
          height: 20,
          width: 100,
          child: pw.Text(''),
        ),
        pw.Directionality(
            child: Text(' صفحه ${context.pageNumber}-${context.pagesCount}',
                style: pw.TextStyle(
                  color: PdfColors.white,
                  font: font,
                  fontSize: 12,
                )),
            textDirection: pw.TextDirection.rtl),
      ],
    );
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.SvgImage(svg: _bgShape!),
      ),
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
    );
  }

  pw.Widget _contentHeader(pw.Context context, pw.Font font, OrderTwo us) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        // pw.Expanded(
        //   child: pw.Container(
        //     margin: const pw.EdgeInsets.symmetric(horizontal: 20),
        //     height: 70,
        //     child: pw.FittedBox(
        //       child: pw.Text(
        //         'Total: ${_formatCurrency(_grandTotal)}',
        //         style: pw.TextStyle(
        //           color: baseColor,
        //           fontStyle: pw.FontStyle.italic,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        //

        pw.Expanded(
          child: pw.Row(
            children: [
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.Directionality(
                    textDirection: pw.TextDirection.rtl,
                    child: pw.RichText(
                      text: pw.TextSpan(
                        text: '$customerName\n',
                        style: pw.TextStyle(
                          color: _darkColor,
                          font: font,
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 12,
                        ),
                        children: [
                          const pw.TextSpan(
                            text: '\n',
                            style: pw.TextStyle(
                              fontSize: 2,
                            ),
                          ),
                          pw.TextSpan(
                            text: '    آدرس :   ' + customerAddress,
                            style: pw.TextStyle(
                              font: font,
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 9,
                            ),
                          ),
                          pw.TextSpan(
                            text: '\n' +
                                '    شماره تلفن :   ' +
                                '${us.callNumber}',
                            style: pw.TextStyle(
                              font: font,
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: pw.Directionality(
                    child: Text('مشخصات خریدار  : ',
                        style: pw.TextStyle(
                          color: _darkColor,
                          fontWeight: pw.FontWeight.bold,
                          font: font,
                          fontSize: 12,
                        )),
                    textDirection: pw.TextDirection.rtl),

                // pw.Text(
                //   'Invoice to:',
                //   style: pw.TextStyle(
                //     color: _darkColor,
                //     fontWeight: pw.FontWeight.bold,
                //     fontSize: 12,
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context, pw.Font font) {
    NumberFormat formatterq = NumberFormat("#,###");

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 1,
          child: pw.DefaultTextStyle(
            style: const pw.TextStyle(
              fontSize: 10,
              color: _darkColor,
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                // pw.Row(
                //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                //   children: [
                //     pw.Text(_formatCurrency(_total)),
                //     pw.Directionality(
                //       textDirection: pw.TextDirection.rtl,
                //       child: pw.Text('جمع قیمت کل :',
                //           style: pw.TextStyle(font: font)),
                //     ),
                //   ],
                // ),
                pw.SizedBox(height: 5),
                // pw.Row(
                //   mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                //   children: [
                //     pw.Text('${_formatCurrency(_show)}'),
                //     pw.Directionality(
                //       textDirection: pw.TextDirection.rtl,
                //       child: pw.Text('%10 مالیات و عوارض :',
                //           style: pw.TextStyle(font: font)),
                //     ),
                //   ],
                // ),
                pw.Divider(color: accentColor),
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: baseColor,
                    fontSize: 12,
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(_formatCurrency(_total)),
                      pw.Directionality(
                        textDirection: pw.TextDirection.rtl,
                        child: pw.Text('جمع مبلغ کل :',
                            style: pw.TextStyle(font: font)),
                      ),
                    ],
                  ),
                ),
                pw.Divider(color: accentColor),
                pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    color: baseColor,
                    fontSize: 12,
                    font: font,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Directionality(
                        textDirection: pw.TextDirection.rtl,
                        child: pw.Text('\n'+'\n'+' جمع مبلغ کل به حروف : '+_formatCurrency(_grandTotal).toWord(),
                            style: pw.TextStyle(font: font)),
                      ),
                    ],
                  ),
                ),
                pw.Container(
                  padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                  height: 72,
                  child: pw.SvgImage(svg: _mohr!),
                ),
              ],
            ),
          ),
        ),
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              // pw.Text(
              //   'Thank you for your business',
              //   style: pw.TextStyle(
              //     color: _darkColor,
              //     fontWeight: pw.FontWeight.bold,
              //   ),
              // ),
              pw.Container(
                margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
                child: pw.Directionality(
                  textDirection: pw.TextDirection.rtl,
                  child: pw.Text(
                    'مشخصات فروشنده : شرکت رهپویان توسعه تجارت ساتر',
                    style: pw.TextStyle(
                      font: font,
                      color: baseColor,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
              pw.Directionality(
                textDirection: pw.TextDirection.rtl,
                child: pw.Text(
                  paymentInfo,
                  style: pw.TextStyle(
                    font: font,
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _termsAndConditions(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(color: accentColor)),
                ),
                padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
                child: pw.Text(
                  'Terms & Conditions',
                  style: pw.TextStyle(
                    fontSize: 12,
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                pw.LoremText().paragraph(40),
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(
                  fontSize: 6,
                  lineSpacing: 2,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.SizedBox(),
        ),
      ],
    );
  }

  pw.Widget _contentTable(
      pw.Context context, pw.Font font, NumberFormat formatter) {
    const tableHeaders = ['مبلغ کل', 'قیمت', 'تعداد', 'گارانتی', 'مشخصات محصول', 'ردیف'];
    return pw.TableHelper.fromTextArray(
      headerDirection: pw.TextDirection.rtl,
      tableDirection: pw.TextDirection.rtl,
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: pw.BoxDecoration(
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(3)),
        color: baseColor,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
        5: pw.Alignment.centerRight, // Alignment for the "ردیف" column
      },
      headerStyle: pw.TextStyle(
        font: font,
        color: _baseTextColor,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: pw.TextStyle(
        font: font,
        color: _darkColor,
        fontSize: 10,
      ),
      rowDecoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: accentColor,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
            (col) => tableHeaders[col],
      ),
      data: List<List<String>>.generate(
        products.length,
            (row) => List<String>.generate(
          tableHeaders.length,
              (col) => products[row].getIndex(col),
        ),
      ),
    );
  }


}

String _formatCurrency(
    double amount,
    ) {
  NumberFormat formatterq = NumberFormat("#,###");
  return '${formatterq.format(amount)}';
}

class ProductInvoGarantyBedoneh {
  const ProductInvoGarantyBedoneh(
      this.sku,
      this.productName,
      this.price,
      this.quantity,
      this.warranty,
      );

  final String sku;
  final String productName;
  final double price;
  final int quantity;
  final List<String> warranty;

  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return _formatCurrency(total);  // "مبلغ کل" column
      case 1:
        return _formatCurrency(price);  // "قیمت" column
      case 2:
        return quantity.toString();  // "تعداد" column
      case 3:
        return warranty.join(', ');  // "گارانتی" column
      case 4:
        return productName;  // "مشخصات محصول" column
      case 5:
        return sku;  // "ردیف" column
    }
    return '';
  }
}

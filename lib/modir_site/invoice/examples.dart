import 'dart:async';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';



import 'examples/invoice.dart';


const examples = <Example>[
  // Example('RÉSUMÉ', 'resume.dart', generateResume),
  // Example('DOCUMENT', 'document.dart', generateDocument),
 //Example('پیش فاکتور فروش', 'invoice.dart', generateInvoice),

  // Example('REPORT', 'report.dart', generateReport),
  // Example('CALENDAR', 'calendar.dart', generateCalendar),
  // Example('CERTIFICATE', 'certificate.dart', generateCertificate, true),
];

typedef LayoutCallbackWithData = Future<Uint8List> Function(
    PdfPageFormat pageFormat);

class Example {
  const Example(this.name, this.file, this.builder,);

  final String name;

  final String file;

  final LayoutCallbackWithData builder;


}

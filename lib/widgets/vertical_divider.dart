import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

verticalDivider() {
  return pw.Row(mainAxisSize: pw.MainAxisSize.min, children: [
    pw.SizedBox(width: 4),
    pw.Container(
      width: 1.2,
      height: 12,
      color: PdfColor.fromInt(Colors.black.value),
    ),
    pw.SizedBox(width: 4),
  ]);

  return;
}

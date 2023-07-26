import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf/src/widgets/document.dart';

class AppPageView extends StatelessWidget {
  final File file;
  final String title;
  final Document pdf;
  const AppPageView(this.title, this.file, this.pdf, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: Text(title),
      ),
      body: PDFView(filePath: file.path),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.download),
        onPressed: () async {
          String filePath = '/storage/emulated/0/Download/resume.pdf';
          File file = File(filePath);
          try {
            await file.writeAsBytes(await pdf.save());
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saved in Downloads")));
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
          }
        },
      ),
    );
  }
}

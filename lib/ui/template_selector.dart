import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:resume_maker/app_page_view.dart';
import 'package:resume_maker/global/gInfo.dart';
import 'package:resume_maker/helper/local_path.dart';
import 'package:resume_maker/templates/templates.dart';

class TemplateSelector extends StatefulWidget {
  const TemplateSelector({Key? key}) : super(key: key);

  @override
  State<TemplateSelector> createState() => _TemplateSelectorState();
}

class _TemplateSelectorState extends State<TemplateSelector> {
  var allTemplates = [T1(), T2()];
  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Template")),
      body: Column(
        children: [
          DropdownButton<int>(
            onChanged: (v) => setState(() => index = v!),
            value: index,
            items: [
              DropdownMenuItem(child: Text("Template 1"), value: 0),
              DropdownMenuItem(child: Text("Template 2"), value: 1),
            ],
          ),
          Image.asset("assets/thumbnail/${index + 1}.png")
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.print),
        onPressed: _createAndShowPdf,
      ),
    );
  }

  Future<void> _createAndShowPdf() async {
    final pdf = pw.Document();
    Template template = allTemplates[index];

    template.insertPage(pdf, gInfo);

    final path = await appStoragePath();
    final file = File('$path/resume.pdf');
    await file.writeAsBytes(await pdf.save());
    print("app installed file location: $file");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AppPageView("Resume", file, pdf)),
    );
  }
}

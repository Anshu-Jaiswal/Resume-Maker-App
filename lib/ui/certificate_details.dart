import 'package:flutter/material.dart';
import 'package:resume_maker/info.dart';

import '../global/gInfo.dart';

class CertificateDetails extends StatefulWidget {
  const CertificateDetails({Key? key}) : super(key: key);

  @override
  State<CertificateDetails> createState() => _CertificateDetailsState();
}

class _CertificateDetailsState extends State<CertificateDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Certificate.sectionHeading),
        ),
        body: Column(
          children: [
            ElevatedButton(onPressed: _add, child: const Text("Add new certificate")),
            for (int i = 0; i < gInfo.certificates.length; i++)
              ExpansionTile(
                title: Text(gInfo.certificates[i].title),
                children: [
                  ListTile(title: Text(gInfo.certificates[i].link)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () => _edit(i), child: const Text("Edit")),
                      ElevatedButton(onPressed: () => _remove(i), child: const Text("Remove")),
                    ],
                  ),
                ],
              ),
          ],
        ));
  }

  void _add() {
    setState(() {
      gInfo.certificates.add(Certificate());
    });
  }

  _remove(int i) {
    setState(() {
      gInfo.certificates.removeAt(i);
    });
  }

  _edit(int i) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => EditCertificate(i)));
    setState(() {});
  }
}

class EditCertificate extends StatefulWidget {
  final int i;
  const EditCertificate(this.i, {Key? key}) : super(key: key);

  @override
  State<EditCertificate> createState() => _EditCertificateState();
}

class _EditCertificateState extends State<EditCertificate> {
  TextEditingController _titleCtr = TextEditingController();
  TextEditingController _linkCtr = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _titleCtr.text = gInfo.certificates[widget.i].title;
    _linkCtr.text = gInfo.certificates[widget.i].link;
  }

  @override
  void dispose() {
    _titleCtr.dispose();
    _linkCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Certificate"),
      ),
      body: Form(
        key: key,
        child: Column(
          children: [
            TextFormField(
              controller: _titleCtr,
              decoration: const InputDecoration(labelText: "Certificate Name"),
              validator: (value) {
                if (value == null || value.isEmpty) return "enter a title";
                return null;
              },
            ),
            TextFormField(
              controller: _linkCtr,
              decoration: const InputDecoration(labelText: "Certificate Url"),
              validator: (value) {
                if (value == null || value.isEmpty) return "enter a link";
                return null;
              },
            ),
            const Spacer(
              flex: 2,
            ),
            ElevatedButton(onPressed: _onSave, child: const Text("Save")),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _onSave() {
    if (key.currentState!.validate()) {
      var tl = _titleCtr.text;
      var ln = _linkCtr.text;

      gInfo.certificates[widget.i].title = tl;
      gInfo.certificates[widget.i].link = ln;
      Navigator.pop(context);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:resume_maker/helper/extensions.dart';

import '../global/gInfo.dart';
import '../info.dart';

class EducationDetails extends StatefulWidget {
  const EducationDetails({Key? key}) : super(key: key);

  @override
  State<EducationDetails> createState() => _EducationDetailsState();
}

class _EducationDetailsState extends State<EducationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Education.sectionHeading),
      ),
      body: ListView(
        children: [
          ElevatedButton(onPressed: _add, child: Text("Add")),
          for (int i = 0; i < gInfo.education.length; i++)
            ExpansionTile(
              title: Text(gInfo.education[i].instituteName),
              children: [
                ListTile(title: Text(gInfo.education[i].instituteLocation)),
                ListTile(title: Text(gInfo.education[i].degree)),
                if (gInfo.education[i].major != null) ListTile(title: Text(gInfo.education[i].major!)),
                ListTile(title: Text(gInfo.education[i].cgpa)),
                ListTile(title: Text(gInfo.education[i].startDate.fmtMYYYY)),
                ListTile(title: Text(gInfo.education[i].endDate.fmtMYYYY)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: () => _edit(i), child: Text("Edit")),
                    ElevatedButton(onPressed: () => _remove(i), child: Text("remove")),
                  ],
                )
              ],
            ),
        ],
      ),
    );
  }

  _edit(int i) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => EditEducation(i)));
    setState(() {});
  }

  _remove(int i) {
    setState(() {
      gInfo.education.removeAt(i);
    });
  }

  _add() {
    setState(() {
      gInfo.education.add(Education());
    });
  }
}

class EditEducation extends StatefulWidget {
  final int i;

  const EditEducation(this.i, {Key? key}) : super(key: key);

  @override
  State<EditEducation> createState() => _EditEducationState();
}

class _EditEducationState extends State<EditEducation> {
  final key = GlobalKey<FormState>();
  TextEditingController _nameCtr = TextEditingController();
  TextEditingController _locationCtr = TextEditingController();
  TextEditingController _degreeCtr = TextEditingController();
  TextEditingController _majorCtr = TextEditingController();
  TextEditingController _cgpaCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    var ed = gInfo.education[widget.i];

    _locationCtr.text = ed.instituteLocation;
    _nameCtr.text = ed.instituteName;
    _degreeCtr.text = ed.degree;
    _majorCtr.text = ed.major ?? '';
    _cgpaCtr.text = ed.cgpa;
  }

  @override
  void dispose() {
    _locationCtr.dispose();
    _nameCtr.dispose();
    _degreeCtr.dispose();
    _majorCtr.dispose();
    _cgpaCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: key,
          child: ListView(
            children: [
              TextFormField(
                controller: _degreeCtr,
                decoration: InputDecoration(labelText: "Degree"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a value";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameCtr,
                decoration: InputDecoration(labelText: "Institute Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a value";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationCtr,
                decoration: InputDecoration(labelText: "Institute Location"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a value";
                  }
                  return null;
                },
              ),
              ListTile(
                  title: Text(gInfo.education[widget.i].startDate.fmtMYYYY),
                  subtitle: Text("Start"),
                  trailing: ElevatedButton(onPressed: _pickStartDate, child: Text("Edit"))),
              ListTile(
                  title: Text(gInfo.education[widget.i].endDate.fmtMYYYY),
                  subtitle: Text("End"),
                  trailing: ElevatedButton(onPressed: _pickEndDate, child: Text("Edit"))),
              TextFormField(
                controller: _majorCtr,
                decoration: InputDecoration(labelText: "Major"),
              ),
              TextFormField(
                controller: _cgpaCtr,
                decoration: InputDecoration(labelText: "CGPA"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a value";
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(onPressed: _save, child: Text("Save"))
            ],
          ),
        ),
      ),
    );
  }

  _pickStartDate() async {
    var pick = await showDatePicker(
      context: context,
      initialDate: gInfo.education[widget.i].startDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pick != null) {
      setState(() => gInfo.education[widget.i].startDate = pick);
    }
  }

  _pickEndDate() async {
    var pick = await showDatePicker(
      context: context,
      initialDate: gInfo.education[widget.i].endDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pick != null) {
      setState(() => gInfo.education[widget.i].endDate = pick);
    }
  }

  void _save() {
    if (key.currentState!.validate()) {
      var nm = _nameCtr.text;
      gInfo.education[widget.i].instituteName = nm;

      var lo = _locationCtr.text;
      gInfo.education[widget.i].instituteLocation = lo;

      var dg = _degreeCtr.text;
      gInfo.education[widget.i].degree = dg;

      var mj = _majorCtr.text.isNotEmpty ? _majorCtr.text : null;
      gInfo.education[widget.i].major = mj;

      var cg = _cgpaCtr.text;
      gInfo.education[widget.i].cgpa = cg;

      Navigator.pop(context);
    }
  }
}

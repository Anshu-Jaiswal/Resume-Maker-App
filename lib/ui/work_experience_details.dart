import 'package:flutter/material.dart';
import 'package:resume_maker/global/gInfo.dart';
import 'package:resume_maker/helper/extensions.dart';

import '../info.dart';

class WorkExperienceDetails extends StatefulWidget {
  const WorkExperienceDetails({Key? key}) : super(key: key);

  @override
  State<WorkExperienceDetails> createState() => _WorkExperienceDetailsState();
}

class _WorkExperienceDetailsState extends State<WorkExperienceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WorkExperience.sectionHeading),
      ),
      body: ListView(
        children: [
          ElevatedButton(onPressed: _add, child: Text("Add")),
          for (int i = 0; i < gInfo.workExperience.length; i++)
            ExpansionTile(
              title: Text(gInfo.workExperience[i].designation),
              children: [
                ListTile(title: Text(gInfo.workExperience[i].companyName)),
                ListTile(title: Text(gInfo.workExperience[i].location)),
                for (var r in gInfo.workExperience[i].responsibility) ListTile(title: Text(r)),
                ListTile(title: Text(gInfo.workExperience[i].startDate.fmtMYYYY)),
                ListTile(title: Text(gInfo.workExperience[i].endDate.fmtMYYYY)),
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
    await Navigator.push(context, MaterialPageRoute(builder: (context) => EditWorkExperience(i)));
    setState(() {});
  }

  _remove(int i) {
    setState(() {
      gInfo.workExperience.removeAt(i);
    });
  }

  _add() {
    setState(() {
      gInfo.workExperience.add(WorkExperience());
    });
  }
}

class EditWorkExperience extends StatefulWidget {
  final int i;
  const EditWorkExperience(this.i, {Key? key}) : super(key: key);

  @override
  State<EditWorkExperience> createState() => _EditWorkExperienceState();
}

class _EditWorkExperienceState extends State<EditWorkExperience> {
  final key = GlobalKey<FormState>();
  TextEditingController _locationCtr = TextEditingController();
  TextEditingController _designationCtr = TextEditingController();
  TextEditingController _companyNameCtr = TextEditingController();
  TextEditingController _respLine1Ctr = TextEditingController();
  TextEditingController _respLine2Ctr = TextEditingController();
  TextEditingController _respLine3Ctr = TextEditingController();
  TextEditingController _respLine4Ctr = TextEditingController();

  @override
  void initState() {
    super.initState();
    var exp = gInfo.workExperience[widget.i];

    _locationCtr.text = exp.location;
    _designationCtr.text = exp.designation;
    _companyNameCtr.text = exp.companyName;

    var resp = [_respLine1Ctr, _respLine2Ctr, _respLine3Ctr, _respLine4Ctr];

    for (int j = 0; j < exp.responsibility.length; j++) {
      resp[j].text = exp.responsibility[j];
    }
  }

  @override
  void dispose() {
    _locationCtr.dispose();
    _designationCtr.dispose();
    _companyNameCtr.dispose();
    _respLine1Ctr.dispose();
    _respLine2Ctr.dispose();
    _respLine3Ctr.dispose();
    _respLine4Ctr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: key,
          child: ListView(
            children: [
              TextFormField(
                controller: _companyNameCtr,
                decoration: InputDecoration(labelText: "Company Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a value";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _designationCtr,
                decoration: InputDecoration(labelText: "Designation"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a value";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationCtr,
                decoration: InputDecoration(labelText: "Location"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a value";
                  }
                  return null;
                },
              ),
              ListTile(
                  title: Text(gInfo.workExperience[widget.i].startDate.fmtMYYYY),
                  subtitle: Text("Start"),
                  trailing: ElevatedButton(onPressed: _pickStartDate, child: Text("Edit"))),
              ListTile(
                  title: Text(gInfo.workExperience[widget.i].endDate.fmtMYYYY),
                  subtitle: Text("End"),
                  trailing: ElevatedButton(onPressed: _pickEndDate, child: Text("Edit"))),
              TextFormField(
                controller: _respLine1Ctr,
                decoration: InputDecoration(labelText: "Line 1"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a value";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _respLine2Ctr,
                decoration: InputDecoration(labelText: "Line 2"),
              ),
              TextFormField(
                controller: _respLine3Ctr,
                decoration: InputDecoration(labelText: "Line 3"),
              ),
              TextFormField(
                controller: _respLine4Ctr,
                decoration: InputDecoration(labelText: "Line 4"),
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
      initialDate: gInfo.workExperience[widget.i].startDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pick != null) {
      setState(() => gInfo.workExperience[widget.i].startDate = pick);
    }
  }

  _pickEndDate() async {
    var pick = await showDatePicker(
      context: context,
      initialDate: gInfo.workExperience[widget.i].endDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pick != null) {
      setState(() => gInfo.workExperience[widget.i].endDate = pick);
    }
  }

  void _save() {
    if (key.currentState!.validate()) {
      var cn = _companyNameCtr.text;
      gInfo.workExperience[widget.i].companyName = cn;

      var ds = _designationCtr.text;
      gInfo.workExperience[widget.i].designation = ds;

      var lo = _locationCtr.text;
      gInfo.workExperience[widget.i].location = lo;

      var nr = [_respLine1Ctr.text];

      if (_respLine2Ctr.text.isNotEmpty) {
        nr.add(_respLine2Ctr.text);
      }

      if (_respLine3Ctr.text.isNotEmpty) {
        nr.add(_respLine3Ctr.text);
      }

      if (_respLine4Ctr.text.isNotEmpty) {
        nr.add(_respLine4Ctr.text);
      }

      gInfo.workExperience[widget.i].responsibility = nr;

      Navigator.pop(context);
    }
  }
}

import 'package:flutter/material.dart';

import '../global/gInfo.dart';
import '../info.dart';

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({Key? key}) : super(key: key);

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Project Details")),
      body: ListView(
        children: [
          ListTile(
            title: Text(Project.sectionHeading),
          ),
          ElevatedButton(
            onPressed: _add,
            child: Text("Add New Project"),
          ),
          for (int i = 0; i < gInfo.projects.length; i++)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text(gInfo.projects[i].projectName),
                  children: [
                    ListTile(
                      title: Text(gInfo.projects[i].description),
                    ),
                    ListTile(
                      title: Text(gInfo.projects[i].technology.join(", ")),
                    ),
                    if (gInfo.projects[i].projectLink != null)
                      ListTile(
                        title: Text(gInfo.projects[i].projectLink!),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(onPressed: () => _edit(i), child: Text("Edit")),
                        ElevatedButton(onPressed: () => _remove(i), child: Text("Remove")),
                      ],
                    ),
                  ],
                ),
              ],
            )
        ],
      ),
    );
  }

  _add() {
    setState(() {
      gInfo.projects.add(Project());
    });
  }

  _remove(int i) {
    setState(() {
      gInfo.projects.removeAt(i);
    });
  }

  _edit(int i) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => EditProject(i)));
    // since we are not using provider, we need to manually refresh the screen to see the updates
    setState(() {});
  }
}

class EditProject extends StatefulWidget {
  final int i;
  const EditProject(this.i, {Key? key}) : super(key: key);

  @override
  State<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends State<EditProject> {
  final TextEditingController _nameCtr = TextEditingController();
  final TextEditingController _descCtr = TextEditingController();
  final TextEditingController _techCtr = TextEditingController();
  final TextEditingController _linkCtr = TextEditingController();
  final key = GlobalKey<FormState>(); // used to validate textfield

  @override
  void initState() {
    super.initState();
    final p = gInfo.projects[widget.i];
    _nameCtr.text = p.projectName;
    _descCtr.text = p.description;
    _techCtr.text = p.technology.join(",");
    _linkCtr.text = p.projectLink ?? '';
  }

  @override
  void dispose() {
    _nameCtr.dispose();
    _linkCtr.dispose();
    _techCtr.dispose();
    _descCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameCtr,
                  decoration: InputDecoration(labelText: "Project Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "enter a name";
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descCtr,
                  decoration: InputDecoration(labelText: "Description"),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "enter a description";
                    return null;
                  },
                ),
                TextFormField(
                  controller: _techCtr,
                  decoration: InputDecoration(labelText: "Tech used"),
                  validator: (value) {
                    if (value == null || value.isEmpty) return "enter technology used";
                    return null;
                  },
                ),
                TextFormField(
                  controller: _linkCtr,
                  decoration: InputDecoration(labelText: "Link"),
                ),
                Spacer(),
                ElevatedButton(onPressed: _onSave, child: Text("Save"))
              ],
            ),
          ),
        ));
  }

  void _onSave() {
    if (key.currentState!.validate()) {
      var nm = _nameCtr.text;
      var des = _descCtr.text;
      var tec = _techCtr.text.split(",");
      var ln = _linkCtr.text.isNotEmpty ? _linkCtr.text : null;

      gInfo.projects[widget.i].projectName = nm;
      gInfo.projects[widget.i].description = des;
      gInfo.projects[widget.i].technology = tec;
      gInfo.projects[widget.i].projectLink = ln;

      Navigator.pop(context);
    }
  }
}

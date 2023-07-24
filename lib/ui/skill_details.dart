import 'package:flutter/material.dart';
import 'package:resume_maker/global/gInfo.dart';
import 'package:resume_maker/info.dart';

class SkillSetDetails extends StatefulWidget {
  const SkillSetDetails({Key? key}) : super(key: key);

  @override
  State<SkillSetDetails> createState() => _SkillSetDetailsState();
}

class _SkillSetDetailsState extends State<SkillSetDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Skill Details")),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            children: [
              Text(SkillSet.sectionHeading),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: _addNew,
                  child: const Text("Add new skill"),
                ),
              ),
              for (int i = 0; i < gInfo.skillSet.length; i++)
                ExpansionTile(
                  title: Text(gInfo.skillSet[i].label),
                  children: [
                    ListTile(title: Text(gInfo.skillSet[i].skills.join(", "))),
                    ListTile(
                        title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(onPressed: () => _edit(i), child: const Text("Edit")),
                        ElevatedButton(onPressed: () => _remove(i), child: const Text("Remove")),
                      ],
                    )),
                  ],
                ),
            ],
          ),
        ));
  }

  void _addNew() => setState(() => gInfo.skillSet.add(SkillSet()));
  void _remove(int pos) => setState(() => gInfo.skillSet.removeAt(pos));
  Future<void> _edit(int pos) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) => EditSkillSet(pos)));
    setState(() {});
  }
}

class EditSkillSet extends StatefulWidget {
  const EditSkillSet(this.pos, {Key? key}) : super(key: key);
  final int pos;

  @override
  State<EditSkillSet> createState() => _EditSkillSetState();
}

class _EditSkillSetState extends State<EditSkillSet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _skillLabelCtrl = TextEditingController();
  final TextEditingController _skillDetailCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    final skill = gInfo.skillSet[widget.pos];

    _skillLabelCtrl.text = skill.label;
    _skillDetailCtrl.text = skill.skills.join(",");
  }

  @override
  void dispose() {
    _skillLabelCtrl.dispose();
    _skillDetailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Skills")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                controller: _skillLabelCtrl,
                decoration: const InputDecoration(labelText: "Skill Heading"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter a label for the skill";
                  }
                  return null;
                }),
            TextFormField(
                controller: _skillDetailCtrl,
                decoration: const InputDecoration(labelText: "Skills"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter the skills";
                  }
                  return null;
                }),
            Spacer(),
            ElevatedButton(onPressed: _onSave, child: Text("Ok"))
          ],
        ),
      ),
    );
  }

  _onSave() {
    if (!_formKey.currentState!.validate()) return;

    final lb = _skillLabelCtrl.text;
    final sk = _skillDetailCtrl.text.split(",");

    gInfo.skillSet[widget.pos].label = lb;
    gInfo.skillSet[widget.pos].skills = sk;

    Navigator.pop(context);
  }
}

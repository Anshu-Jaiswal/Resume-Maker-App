import 'package:flutter/material.dart';
import 'package:resume_maker/ui/ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const PdfMaker(),
    );
  }
}

class PdfMaker extends StatelessWidget {
  const PdfMaker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fill Details")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(onPressed: () => _goToProfileDetails(context), child: const Text("Profile")),
                ElevatedButton(onPressed: () => _goToSkillsDetails(context), child: const Text("Skills")),
                ElevatedButton(onPressed: () => _goToProjectDetails(context), child: const Text("Project")),
                ElevatedButton(onPressed: () => _goToCertificateDetails(context), child: const Text("Certificate")),
                ElevatedButton(onPressed: () => _goToWorkDetails(context), child: const Text("Work Experience")),
                ElevatedButton(onPressed: () => _goToEducationDetails(context), child: const Text("Education")),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.arrow_right),
        onPressed: () => _templateSelectPageNav(context),
        label: Text("Next"),
      ),
    );
  }

  _templateSelectPageNav(context) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => TemplateSelector()));

  void _goToProfileDetails(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfileDetails(),
        ));
  }

  void _goToSkillsDetails(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const SkillSetDetails(),
        ));
  }

  void _goToProjectDetails(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ProjectDetails(),
        ));
  }

  void _goToCertificateDetails(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CertificateDetails()));
  }

  void _goToWorkDetails(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => WorkExperienceDetails()));
  }

  void _goToEducationDetails(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EducationDetails()));
  }
}

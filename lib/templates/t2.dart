import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:resume_maker/helper/extensions.dart';
import 'package:resume_maker/info.dart';
import 'package:resume_maker/templates/base_template.dart';

class T2 implements Template {
  @override
  void insertPage(Document pdf, Info info) {
    pdf.addPage(Page(build: (context) => _buildPage(context, info)));
  }

  Widget _buildPage(Context context, Info info) {
    return Column(children: [
      profileSection(info.profile),
      experienceSection(info.workExperience),
      skillSection(info.skillSet),
      educationSection(info.education),
      projectSection(info.projects),
      certificateSection(info.certificates),
    ]);
  }

  Widget profileSection(Profile profile) {
    final name = RichText(
        text: TextSpan(
            text: profile.firstName,
            style: const TextStyle(fontSize: 28, color: PdfColors.blue),
            children: [TextSpan(text: profile.lastName, style: TextStyle(fontWeight: FontWeight.bold))]));

    final contact = Wrap(alignment: WrapAlignment.spaceBetween, spacing: 8, runSpacing: 8, children: [
      Text("email: ${profile.email}"),
      Text("phone: ${profile.phoneNumber}"),
      Text("location: ${profile.location}"),
    ]);

    return Column(children: [
      name,
      contact,
    ]);
  }

  Widget projectSection(List<Project> projects) {
    Widget txt(String label, String link) => RichText(
            text: TextSpan(text: label, children: [
          TextSpan(text: " : "),
          TextSpan(text: link, style: TextStyle(decoration: TextDecoration.underline))
        ]));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(Project.sectionHeading),
        for (var p in projects)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(p.projectName, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(p.description),
              Text("Using: ${p.technology.join(", ")}"),
              if (p.projectLink != null) txt("Project Link", p.projectLink!),
            ],
          ).padding(top: 4)
      ],
    );
  }

  Widget certificateSection(List<Certificate> certificates) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionHeader(Certificate.sectionHeading),
        for (var c in certificates)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(c.title, style: TextStyle(fontWeight: FontWeight.bold)),
              RichText(
                  text: TextSpan(
                      text: "Certificate Here :",
                      children: [TextSpan(text: c.link, style: TextStyle(decoration: TextDecoration.underline))]))
            ],
          ).padding(top: 4)
      ],
    );
  }

  Widget experienceSection(List<WorkExperience> experience) {
    return Column(children: [
      sectionHeader(WorkExperience.sectionHeading),
      for (var e in experience)
        Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(e.companyName, style: TextStyle(fontWeight: FontWeight.bold)), Text(e.location)]),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(e.designation), Text("${e.startDate.fmtMYYYY} - ${e.endDate.fmtMYYYY}")]),
          for (var r in e.responsibility) Bullet(text: r)
        ])
    ]);
  }

  Widget skillSection(List<SkillSet> skills) {
    return Column(children: [
      sectionHeader(SkillSet.sectionHeading),
      for (var s in skills)
        Row(children: [
          Text(s.label),
          Spacer(),
          Text(s.skills.join(", ")),
        ]).padding(top: 2)
    ]);
  }

  Widget educationSection(List<Education> education) {
    return Column(children: [
      sectionHeader(Education.sectionHeading),
      for (var e in education)
        Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(e.instituteName, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(e.instituteLocation)
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${e.degree} in ${e.major}"),
              Text("${e.startDate.fmtYYYY} - ${e.endDate.fmtYYYY}"),
            ],
          )
        ]).padding(top: 6)
    ]);
  }

  Widget sectionHeader(String label) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      Expanded(child: Divider(thickness: 1, color: PdfColors.black, height: 10, indent: 8)),
    ]).padding(top: 12);
  }
}

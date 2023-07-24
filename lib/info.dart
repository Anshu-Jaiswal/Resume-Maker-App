class Info {
  Profile profile = Profile();
  List<Education> education = [Education(), Education()];
  List<WorkExperience> workExperience = [WorkExperience(), WorkExperience()];
  List<SkillSet> skillSet = [SkillSet(), SkillSet()];
  List<Project> projects = [Project(), Project()];
  List<Certificate> certificates = [Certificate(), Certificate()];
}

class Profile {
  String firstName = "John";
  String? lastName = "Doe";
  String email = "john_doe@mail.com";
  String? phoneNumber = "+1 1234567890";
  String? location;
}

class Education {
  static String sectionHeading = "Education";
  String instituteName = "XYZ College"; // school name
  String instituteLocation = "Bhopal";
  String degree = "B.E.";
  String? major = "I.T.";
  String cgpa = "8.4";
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
}

class WorkExperience {
  static String sectionHeading = "Work Experience";
  String companyName = "xyz";
  String designation = "Software Developer";
  String location = "Pune";
  List<String> responsibility = [
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Tempora, voluptates.",
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Tempora, voluptates.",
  ];
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
}

class SkillSet {
  static String sectionHeading = "Skills";
  String label = "Programming Languages";
  List<String> skills = ["Java", "C", "Dart"];
}

class Project {
  static String sectionHeading = "Projects";
  String projectName = "HIYT";
  String description = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Tempora, voluptates.";
  List<String> technology = ["Flutter", "Dart"];
  String? projectLink = "http://example.com";
}

class Certificate {
  static String sectionHeading = "Certificates";
  String title = "Java Certificate";
  String link = "http://java";
}

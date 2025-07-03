class ProfileModel {
  BasicInfo? basicInfo;
  List<Education>? education;
  List<Experience>? experiences;
  List<Certification>? certifications;
  JobPreferences? jobPreferences;
  Goals? goals;
  Skills? skills;

  ProfileModel({
    this.basicInfo,
    this.education,
    this.experiences,
    this.certifications,
    this.jobPreferences,
    this.goals,
    this.skills,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        basicInfo: json["basicInfo"] == null ? null : BasicInfo.fromJson(json["basicInfo"]),
        education:
            json["education"] == null ? [] : List<Education>.from(json["education"]!.map((x) => Education.fromJson(x))),
        experiences: json["experiences"] == null
            ? []
            : List<Experience>.from(json["experiences"]!.map((x) => Experience.fromJson(x))),
        certifications: json["certifications"] == null
            ? []
            : List<Certification>.from(json["certifications"]!.map((x) => Certification.fromJson(x))),
        jobPreferences: json["jobPreferences"] == null ? null : JobPreferences.fromJson(json["jobPreferences"]),
        goals: json["goals"] == null ? null : Goals.fromJson(json["goals"]),
        skills: json["skills"] == null ? null : Skills.fromJson(json["skills"]),
      );

  Map<String, dynamic> toJson() => {
        "basicInfo": basicInfo?.toJson(),
        "education": education == null ? [] : List<dynamic>.from(education!.map((x) => x.toJson())),
        "experiences": experiences == null ? [] : List<dynamic>.from(experiences!.map((x) => x.toJson())),
        "certifications": certifications == null ? [] : List<dynamic>.from(certifications!.map((x) => x.toJson())),
        "jobPreferences": jobPreferences?.toJson(),
        "goals": goals?.toJson(),
        "skills": skills?.toJson(),
      };
}

class BasicInfo {
  String? gender;
  String? dateOfBirth;
  String? location;
  List<String>? languages;

  BasicInfo({
    this.gender,
    this.dateOfBirth,
    this.location,
    this.languages,
  });

  factory BasicInfo.fromJson(Map<String, dynamic> json) => BasicInfo(
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"],
        location: json["location"],
        languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "location": location,
        "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x)),
      };
}

class Certification {
  String? name;
  String? issuer;
  String? issueDate;

  Certification({
    this.name,
    this.issuer,
    this.issueDate,
  });

  factory Certification.fromJson(Map<String, dynamic> json) => Certification(
        name: json["name"],
        issuer: json["issuer"],
        issueDate: json["issueDate"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "issuer": issuer,
        "issueDate": issueDate,
      };
}

class Education {
  String? degree;
  String? field;
  String? university;
  int? endYear;
  double? gpa;

  Education({
    this.degree,
    this.field,
    this.university,
    this.endYear,
    this.gpa,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        degree: json["degree"],
        field: json["field"],
        university: json["university"],
        endYear: json["endYear"],
        gpa: json["GPA"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "degree": degree,
        "field": field,
        "university": university,
        "endYear": endYear,
        "GPA": gpa,
      };
}

class Experience {
  String? jobTitle;
  String? company;
  String? location;
  String? startDate;
  bool? isCurrent;
  String? endDate;
  String? description;

  Experience({
    this.jobTitle,
    this.company,
    this.location,
    this.startDate,
    this.isCurrent,
    this.endDate,
    this.description,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        jobTitle: json["jobTitle"],
        company: json["company"],
        location: json["location"],
        startDate: json["startDate"],
        isCurrent: json["isCurrent"],
        endDate: json["endDate"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "jobTitle": jobTitle,
        "company": company,
        "location": location,
        "startDate": startDate,
        "isCurrent": isCurrent,
        "endDate": endDate,
        "description": description,
      };
}

class Goals {
  String? careerGoal;
  List<String>? interests;

  Goals({
    this.careerGoal,
    this.interests,
  });

  factory Goals.fromJson(Map<String, dynamic> json) => Goals(
        careerGoal: json["careerGoal"],
        interests: json["interests"] == null ? [] : List<String>.from(json["interests"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "careerGoal": careerGoal,
        "interests": interests == null ? [] : List<dynamic>.from(interests!.map((x) => x)),
      };
}

class JobPreferences {
  List<String>? workPlaceType;
  List<String>? jobType;
  String? jobLocation;

  JobPreferences({
    this.workPlaceType,
    this.jobType,
    this.jobLocation,
  });

  factory JobPreferences.fromJson(Map<String, dynamic> json) => JobPreferences(
        workPlaceType: json["workPlaceType"] == null ? [] : List<String>.from(json["workPlaceType"]!.map((x) => x)),
        jobType: json["jobType"] == null ? [] : List<String>.from(json["jobType"]!.map((x) => x)),
        jobLocation: json["jobLocation"],
      );

  Map<String, dynamic> toJson() => {
        "workPlaceType": workPlaceType == null ? [] : List<dynamic>.from(workPlaceType!.map((x) => x)),
        "jobType": jobType == null ? [] : List<dynamic>.from(jobType!.map((x) => x)),
        "jobLocation": jobLocation,
      };
}

class Skills {
  List<TechnicalSkill>? technicalSkills;
  List<TechnicalSkill>? softSkills;

  Skills({
    this.technicalSkills,
    this.softSkills,
  });

  factory Skills.fromJson(Map<String, dynamic> json) => Skills(
        technicalSkills: json["technical_skills"] == null
            ? []
            : List<TechnicalSkill>.from(json["technical_skills"]!.map((x) => TechnicalSkill.fromJson(x))),
        softSkills: json["soft_skills"] == null
            ? []
            : List<TechnicalSkill>.from(json["soft_skills"]!.map((x) => TechnicalSkill.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "technical_skills": technicalSkills == null ? [] : List<dynamic>.from(technicalSkills!.map((x) => x.toJson())),
        "soft_skills": softSkills == null ? [] : List<dynamic>.from(softSkills!.map((x) => x.toJson())),
      };
}

class TechnicalSkill {
  String? name;
  int? level;

  TechnicalSkill({
    this.name,
    this.level,
  });

  factory TechnicalSkill.fromJson(Map<String, dynamic> json) => TechnicalSkill(
        name: json["name"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "level": level,
      };
}

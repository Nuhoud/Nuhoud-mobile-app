import 'package:nuhoud/features/profile/data/models/profile_model.dart';

class JobApplicationModel {
  List<JobApplication>? data;
  int? total;
  int? page;
  int? totalPages;

  JobApplicationModel({
    this.data,
    this.total,
    this.page,
    this.totalPages,
  });

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) => JobApplicationModel(
        data:
            json["data"] == null ? [] : List<JobApplication>.from(json["data"]!.map((x) => JobApplication.fromJson(x))),
        total: json["total"],
        page: json["page"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "totalPages": totalPages,
      };
}

class JobApplication {
  String? id;
  String? jobOfferId;
  String? companyName;
  String? jobTitle;
  String? userId;
  UserSnap? userSnap;
  String? status;
  String? postedAt;
  String? employerNote;

  JobApplication({
    this.id,
    this.jobOfferId,
    this.companyName,
    this.jobTitle,
    this.userId,
    this.userSnap,
    this.status,
    this.postedAt,
    this.employerNote,
  });

  factory JobApplication.fromJson(Map<String, dynamic> json) => JobApplication(
        id: json["_id"],
        jobOfferId: json["jobOfferId"],
        companyName: json["companyName"],
        jobTitle: json["jobTitle"],
        userId: json["userId"],
        userSnap: json["userSnap"] == null ? null : UserSnap.fromJson(json["userSnap"]),
        status: json["status"],
        postedAt: json["postedAt"],
        employerNote: json["employerNote"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "jobOfferId": jobOfferId,
        "companyName": companyName,
        "jobTitle": jobTitle,
        "userId": userId,
        "userSnap": userSnap?.toJson(),
        "status": status,
        "postedAt": postedAt,
        "employerNote": employerNote,
        "id": id,
      };
}

class UserSnap {
  String? name;
  String? email;
  BasicInfo? basic;
  List<Education>? education;
  List<Experience>? experiences;
  List<Certification>? certifications;
  Skills? skills;
  JobPreferences? jobPreferences;
  Goals? goals;

  UserSnap({
    this.name,
    this.email,
    this.basic,
    this.education,
    this.experiences,
    this.certifications,
    this.skills,
    this.jobPreferences,
    this.goals,
  });

  factory UserSnap.fromJson(Map<String, dynamic> json) => UserSnap(
        name: json["name"],
        email: json["email"],
        basic: json["basic"] == null ? null : BasicInfo.fromJson(json["basic"]),
        education:
            json["education"] == null ? [] : List<Education>.from(json["education"]!.map((x) => Education.fromJson(x))),
        experiences: json["experiences"] == null
            ? []
            : List<Experience>.from(json["experiences"]!.map((x) => Experience.fromJson(x))),
        certifications: json["certifications"] == null
            ? []
            : List<Certification>.from(json["certifications"]!.map((x) => Certification.fromJson(x))),
        skills: json["skills"] == null ? null : Skills.fromJson(json["skills"]),
        jobPreferences: json["jobPreferences"] == null ? null : JobPreferences.fromJson(json["jobPreferences"]),
        goals: json["goals"] == null ? null : Goals.fromJson(json["goals"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "basic": basic?.toJson(),
        "education": education == null ? [] : List<dynamic>.from(education!.map((x) => x.toJson())),
        "experiences": experiences == null ? [] : List<dynamic>.from(experiences!.map((x) => x.toJson())),
        "certifications": certifications == null ? [] : List<dynamic>.from(certifications!.map((x) => x.toJson())),
        "skills": skills?.toJson(),
        "jobPreferences": jobPreferences?.toJson(),
        "goals": goals?.toJson(),
      };
}

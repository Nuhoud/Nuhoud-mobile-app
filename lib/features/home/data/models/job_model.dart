class JobModel {
  final String title;
  final String experienceLevel;
  final String workPlaceType;
  final String jobType;
  final String jobLocation;
  final String description;
  final List<String> requirements;
  final List<String> skillsRequired;
  final SalaryRange salaryRange;
  final String companyName;
  final DateTime deadline;

  JobModel({
    required this.title,
    required this.experienceLevel,
    required this.workPlaceType,
    required this.jobType,
    required this.jobLocation,
    required this.description,
    required this.requirements,
    required this.skillsRequired,
    required this.salaryRange,
    required this.companyName,
    required this.deadline,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      title: json['title'],
      experienceLevel: json['experienceLevel'],
      workPlaceType: json['workPlaceType'],
      jobType: json['jobType'],
      jobLocation: json['jobLocation'],
      description: json['description'],
      requirements: List<String>.from(json['requirements']),
      skillsRequired: List<String>.from(json['skillsRequired']),
      salaryRange: SalaryRange.fromJson(json['salaryRange']),
      companyName: json['companyName'],
      deadline: DateTime.parse(json['deadline']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'experienceLevel': experienceLevel,
      'workPlaceType': workPlaceType,
      'jobType': jobType,
      'jobLocation': jobLocation,
      'description': description,
      'requirements': requirements,
      'skillsRequired': skillsRequired,
      'salaryRange': salaryRange.toJson(),
      'companyName': companyName,
      'deadline': deadline.toIso8601String(),
    };
  }
}

class SalaryRange {
  final int min;
  final int max;
  final String currency;

  SalaryRange({
    required this.min,
    required this.max,
    required this.currency,
  });

  factory SalaryRange.fromJson(Map<String, dynamic> json) {
    return SalaryRange(
      min: json['min'],
      max: json['max'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'min': min,
      'max': max,
      'currency': currency,
    };
  }
}

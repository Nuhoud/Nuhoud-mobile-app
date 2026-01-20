class JobModel {
  final String id;
  final String title;
  final String employerId;
  final String companyName;
  final String experienceLevel;
  final String workPlaceType;
  final String jobType;
  final String jobLocation;
  final String description;
  final List<String> requirements;
  final List<String> skillsRequired;
  final SalaryRange salaryRange;
  final DateTime postedAt;
  final DateTime deadline;
  final String status;
  final int applicationsCount;
  final bool? isActive;
  final bool? isExpired;
  final int? daysRemaining;

  JobModel({
    required this.id,
    required this.title,
    required this.employerId,
    required this.companyName,
    required this.experienceLevel,
    required this.workPlaceType,
    required this.jobType,
    required this.jobLocation,
    required this.description,
    required this.requirements,
    required this.skillsRequired,
    required this.salaryRange,
    required this.postedAt,
    required this.deadline,
    required this.status,
    required this.applicationsCount,
    required this.isActive,
    required this.isExpired,
    required this.daysRemaining,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['_id'],
      title: json['title'],
      employerId: json['employerId'],
      companyName: json['companyName'],
      experienceLevel: json['experienceLevel'],
      workPlaceType: json['workPlaceType'],
      jobType: json['jobType'],
      jobLocation: json['jobLocation'],
      description: json['description'],
      requirements: List<String>.from(json['requirements']),
      skillsRequired: List<String>.from(json['skillsRequired']),
      salaryRange: SalaryRange.fromJson(json['salaryRange']),
      postedAt: DateTime.parse(json['postedAt']),
      deadline: DateTime.parse(json['deadline']),
      status: json['status'],
      applicationsCount: json['applicationsCount'],
      isActive: json['isActive'],
      isExpired: json['isExpired'],
      daysRemaining: json['daysRemaining'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'employerId': employerId,
      'companyName': companyName,
      'experienceLevel': experienceLevel,
      'workPlaceType': workPlaceType,
      'jobType': jobType,
      'jobLocation': jobLocation,
      'description': description,
      'requirements': requirements,
      'skillsRequired': skillsRequired,
      'salaryRange': salaryRange.toJson(),
      'postedAt': postedAt.toIso8601String(),
      'deadline': deadline.toIso8601String(),
      'status': status,
      'applicationsCount': applicationsCount,
      'isActive': isActive,
      'isExpired': isExpired,
      'daysRemaining': daysRemaining,
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

String getCurrencyArabic(String currency) {
  switch (currency) {
    case 'EUR':
      return '€';
    case 'USD':
      return '\$';
    case 'SYP':
      return 'ل.س';
    default:
      return '';
  }
}

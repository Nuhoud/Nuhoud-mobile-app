class ExperincesModel {
  final String jobTitle;
  final String company;
  final String jobDescription;
  final String jobStartDate;
  final String? jobEndDate;
  final String jobLocation;
  final bool isCurrent;

  ExperincesModel({
    required this.jobTitle,
    required this.company,
    required this.jobDescription,
    required this.jobStartDate,
    this.jobEndDate,
    required this.jobLocation,
    required this.isCurrent,
  });

  factory ExperincesModel.fromJson(Map<String, dynamic> json) {
    return ExperincesModel(
      jobTitle: json['jobTitle'],
      company: json['company'],
      jobDescription: json['description'],
      jobStartDate: json['startDate'],
      jobEndDate: json['endDate'],
      jobLocation: json['location'],
      isCurrent: json['isCurrent'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'company': company,
      'startDate': jobStartDate,
      'location': jobLocation,
      'isCurrent': isCurrent,
      if (!isCurrent) 'endDate': jobEndDate,
      'description': jobDescription
    };
  }
}

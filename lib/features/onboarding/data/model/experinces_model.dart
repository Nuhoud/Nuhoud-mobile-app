class ExperincesModel {
  final String jobTitle;
  final String company;
  final String jobDescription;
  final String jobStartDate;
  final String jobEndDate;
  final String jobLocation;

  ExperincesModel({
    required this.jobTitle,
    required this.company,
    required this.jobDescription,
    required this.jobStartDate,
    required this.jobEndDate,
    required this.jobLocation,
  });

  factory ExperincesModel.fromJson(Map<String, dynamic> json) {
    return ExperincesModel(
      jobTitle: json['jobTitle'],
      company: json['company'],
      jobDescription: json['description'],
      jobStartDate: json['startDate'],
      jobEndDate: json['endDate'],
      jobLocation: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'company': company,
      'location': jobDescription,
      'startDate': jobStartDate,
      'endDate': jobEndDate,
      'description': jobLocation,
    };
  }
}

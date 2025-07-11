import 'package:nuhoud/features/home/data/models/job_model.dart';

class JobDataModel {
  List<JobModel> jobs;
  int totalJobs;
  int totalPages;
  int currentPage;
  JobDataModel({required this.jobs, required this.totalJobs, required this.totalPages, required this.currentPage});

  factory JobDataModel.fromJson(Map<String, dynamic> json) {
    return JobDataModel(
      jobs: List<JobModel>.from(json["data"].map((x) => JobModel.fromJson(x))),
      totalJobs: json["total"],
      totalPages: json["totalPages"],
      currentPage: json["page"],
    );
  }
}

class EducationModel {
  final String? degree;
  final String? field;
  final String? university;
  final int? endYear;
  final double? gpa;

  EducationModel({
    required this.degree,
    required this.field,
    required this.university,
    required this.endYear,
    required this.gpa,
  });

  Map<String, dynamic> toJson() => {
        "degree": degree,
        "field": field,
        "university": university,
        "endYear": endYear,
        "GPA": gpa,
      };
}

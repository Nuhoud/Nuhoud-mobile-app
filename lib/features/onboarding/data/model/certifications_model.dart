class CertificationsModel {
  final String name;
  final String issueDate;
  final String issuer;

  CertificationsModel({
    required this.name,
    required this.issueDate,
    required this.issuer,
  });

  factory CertificationsModel.fromJson(Map<String, dynamic> json) => CertificationsModel(
        name: json["name"],
        issueDate: json["issueDate"],
        issuer: json["issuer"],
      );

  Map<String, dynamic> toJson() => {"name": name, "issueDate": issueDate, "issuer": issuer};
}

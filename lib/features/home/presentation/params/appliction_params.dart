class OfferParams {
  final String title;
  final String employerId;
  final String companyName;

  OfferParams({
    required this.title,
    required this.employerId,
    required this.companyName,
  });

  toJson() {
    return {
      'title': title,
      'employerId': employerId,
      'companyName': companyName,
    };
  }
}
